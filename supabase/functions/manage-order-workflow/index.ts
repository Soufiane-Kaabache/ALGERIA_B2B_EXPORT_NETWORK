import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // 1. Initialiser le client Admin (contourne le RLS car il a les droits absolus)
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // 2. Récupérer les données envoyées par le frontend
    const { order_id, action, transport_mode } = await req.json()

    if (!order_id || !action) {
      return new Response(JSON.stringify({ error: 'Missing order_id or action' }), {
        status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      })
    }

    // ---------------------------------------------------------
    // ACTION : Demander des devis
    // ---------------------------------------------------------
    if (action === 'request_quotes') {
      
      // Récupérer les fournisseurs uniques impliqués dans cette commande
      const { data: items, error: itemsError } = await supabaseAdmin
        .from('order_items')
        .select('supplier_id')
        .eq('order_id', order_id)

      if (itemsError) throw itemsError

      // Éliminer les doublons (si 2 produits viennent du même fournisseur)
      const uniqueSuppliers = [...new Set(items.map(item => item.supplier_id))]

      // Créer une quote_request pour chaque point de collecte
      const quoteRequestsToInsert = uniqueSuppliers.map(supplier_id => ({
        order_id: order_id,
        supplier_id: supplier_id,
        transport_mode: transport_mode || 'maritime',
        status: 'open'
      }))

      const { error: qrError } = await supabaseAdmin
        .from('quote_requests')
        .insert(quoteRequestsToInsert)

      if (qrError) throw qrError

      // Mettre à jour le statut de la commande
      const { error: orderError } = await supabaseAdmin
        .from('orders')
        .update({ status: 'quotes_requested' })
        .eq('id', order_id)

      if (orderError) throw orderError

      // NOTIFICATION : Prévenir les transporteurs DZ actifs
      const { data: carriersDZ } = await supabaseAdmin
        .from('carriers_dz')
        .select('user_id')
        .eq('active', true)

      const carrierNotifications = (carriersDZ || []).map(c => ({
        user_id: c.user_id,
        title: 'Nouvelle demande de transport',
        message: 'Un client cherche un transport pour une commande.',
        type: 'quote_request',
        link: `/dashboard/quotes` 
      }))

      // NOTIFICATION : Prévenir les transitaires actifs
      const { data: forwarders } = await supabaseAdmin
        .from('freight_forwarders')
        .select('user_id')
        .eq('active', true)

      const forwarderNotifications = (forwarders || []).map(f => ({
        user_id: f.user_id,
        title: 'Nouvelle demande de transit',
        message: 'Une commande nécessite vos services.',
        type: 'quote_request',
        link: `/dashboard/quotes`
      }))

      // Insérer toutes les notifications en base
      if (carrierNotifications.length > 0 || forwarderNotifications.length > 0) {
        await supabaseAdmin.from('notifications').insert([
          ...carrierNotifications,
          ...forwarderNotifications
        ])
      }

      return new Response(JSON.stringify({ 
        success: true, 
        message: 'Quotes requested successfully' 
      }), {
        status: 200, 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      })
    }

    return new Response(JSON.stringify({ error: 'Unknown action' }), {
      status: 400, 
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500, 
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })
  }
})
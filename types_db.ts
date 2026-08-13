export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.15"
  }
  public: {
    Tables: {
      audit_logs: {
        Row: {
          action: string
          changed_at: string
          changed_by: string | null
          id: string
          new_data: Json | null
          old_data: Json | null
          record_id: string
          table_name: string
        }
        Insert: {
          action: string
          changed_at?: string
          changed_by?: string | null
          id?: string
          new_data?: Json | null
          old_data?: Json | null
          record_id: string
          table_name: string
        }
        Update: {
          action?: string
          changed_at?: string
          changed_by?: string | null
          id?: string
          new_data?: Json | null
          old_data?: Json | null
          record_id?: string
          table_name?: string
        }
        Relationships: []
      }
      buyers_eu: {
        Row: {
          active: boolean | null
          address: string | null
          business_status: Database["public"]["Enums"]["business_status"]
          buyer_type: string | null
          city: string | null
          company_name: string
          contact_name: string | null
          country: string | null
          created_at: string | null
          deleted_at: string | null
          email: string | null
          id: string
          legal_form: Database["public"]["Enums"]["legal_form"] | null
          notes: string | null
          phone: string | null
          stripe_customer_id: string | null
          tax_id: string | null
          updated_at: string | null
          user_id: string | null
        }
        Insert: {
          active?: boolean | null
          address?: string | null
          business_status?: Database["public"]["Enums"]["business_status"]
          buyer_type?: string | null
          city?: string | null
          company_name: string
          contact_name?: string | null
          country?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          notes?: string | null
          phone?: string | null
          stripe_customer_id?: string | null
          tax_id?: string | null
          updated_at?: string | null
          user_id?: string | null
        }
        Update: {
          active?: boolean | null
          address?: string | null
          business_status?: Database["public"]["Enums"]["business_status"]
          buyer_type?: string | null
          city?: string | null
          company_name?: string
          contact_name?: string | null
          country?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          notes?: string | null
          phone?: string | null
          stripe_customer_id?: string | null
          tax_id?: string | null
          updated_at?: string | null
          user_id?: string | null
        }
        Relationships: []
      }
      carriers_dz: {
        Row: {
          active: boolean | null
          address: string | null
          bank_details: Json | null
          business_status: Database["public"]["Enums"]["business_status"]
          carrier_number: string | null
          city: string | null
          company_name: string
          contact_name: string | null
          created_at: string | null
          deleted_at: string | null
          email: string | null
          id: string
          kyc_reviewed_at: string | null
          kyc_reviewed_by: string | null
          kyc_status: Database["public"]["Enums"]["kyc_status"]
          legal_form: Database["public"]["Enums"]["legal_form"] | null
          notes: string | null
          phone: string | null
          rating_avg: number | null
          tax_id: string | null
          transport_capacity: string | null
          updated_at: string | null
          user_id: string | null
          vehicle_types: Json | null
          wilaya_code: string | null
          zones_covered: Json | null
        }
        Insert: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          carrier_number?: string | null
          city?: string | null
          company_name: string
          contact_name?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          notes?: string | null
          phone?: string | null
          rating_avg?: number | null
          tax_id?: string | null
          transport_capacity?: string | null
          updated_at?: string | null
          user_id?: string | null
          vehicle_types?: Json | null
          wilaya_code?: string | null
          zones_covered?: Json | null
        }
        Update: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          carrier_number?: string | null
          city?: string | null
          company_name?: string
          contact_name?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          notes?: string | null
          phone?: string | null
          rating_avg?: number | null
          tax_id?: string | null
          transport_capacity?: string | null
          updated_at?: string | null
          user_id?: string | null
          vehicle_types?: Json | null
          wilaya_code?: string | null
          zones_covered?: Json | null
        }
        Relationships: [
          {
            foreignKeyName: "fk_carriers_dz_wilaya_code"
            columns: ["wilaya_code"]
            isOneToOne: false
            referencedRelation: "wilayas"
            referencedColumns: ["code"]
          },
        ]
      }
      carriers_eu: {
        Row: {
          active: boolean | null
          address: string | null
          bank_details: Json | null
          business_status: Database["public"]["Enums"]["business_status"]
          carrier_number: string | null
          city: string | null
          company_name: string
          contact_name: string | null
          country: string | null
          created_at: string | null
          deleted_at: string | null
          email: string | null
          id: string
          kyc_reviewed_at: string | null
          kyc_reviewed_by: string | null
          kyc_status: Database["public"]["Enums"]["kyc_status"]
          legal_form: Database["public"]["Enums"]["legal_form"] | null
          linked_buyer_id: string | null
          notes: string | null
          phone: string | null
          rating_avg: number | null
          tax_id: string | null
          transport_capacity: string | null
          updated_at: string | null
          user_id: string | null
          vehicle_types: Json | null
          zones_covered: Json | null
        }
        Insert: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          carrier_number?: string | null
          city?: string | null
          company_name: string
          contact_name?: string | null
          country?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          linked_buyer_id?: string | null
          notes?: string | null
          phone?: string | null
          rating_avg?: number | null
          tax_id?: string | null
          transport_capacity?: string | null
          updated_at?: string | null
          user_id?: string | null
          vehicle_types?: Json | null
          zones_covered?: Json | null
        }
        Update: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          carrier_number?: string | null
          city?: string | null
          company_name?: string
          contact_name?: string | null
          country?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          linked_buyer_id?: string | null
          notes?: string | null
          phone?: string | null
          rating_avg?: number | null
          tax_id?: string | null
          transport_capacity?: string | null
          updated_at?: string | null
          user_id?: string | null
          vehicle_types?: Json | null
          zones_covered?: Json | null
        }
        Relationships: [
          {
            foreignKeyName: "carriers_eu_linked_buyer_fkey"
            columns: ["linked_buyer_id"]
            isOneToOne: false
            referencedRelation: "buyers_eu"
            referencedColumns: ["id"]
          },
        ]
      }
      chat_messages: {
        Row: {
          content: string
          conversation_id: string
          created_at: string | null
          id: string
          read_by: Json | null
          sender_id: string
        }
        Insert: {
          content: string
          conversation_id: string
          created_at?: string | null
          id?: string
          read_by?: Json | null
          sender_id: string
        }
        Update: {
          content?: string
          conversation_id?: string
          created_at?: string | null
          id?: string
          read_by?: Json | null
          sender_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "chat_messages_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      company_contacts: {
        Row: {
          contact_type: Database["public"]["Enums"]["contact_type"]
          created_at: string | null
          deleted_at: string | null
          email: string | null
          entity_id: string
          entity_type: string
          full_name: string
          id: string
          is_primary: boolean
          phone: string | null
          updated_at: string | null
        }
        Insert: {
          contact_type?: Database["public"]["Enums"]["contact_type"]
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          entity_id: string
          entity_type: string
          full_name: string
          id?: string
          is_primary?: boolean
          phone?: string | null
          updated_at?: string | null
        }
        Update: {
          contact_type?: Database["public"]["Enums"]["contact_type"]
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          entity_id?: string
          entity_type?: string
          full_name?: string
          id?: string
          is_primary?: boolean
          phone?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      conversation_participants: {
        Row: {
          conversation_id: string
          id: string
          joined_at: string | null
          user_id: string
        }
        Insert: {
          conversation_id: string
          id?: string
          joined_at?: string | null
          user_id: string
        }
        Update: {
          conversation_id?: string
          id?: string
          joined_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "conversation_participants_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      conversations: {
        Row: {
          created_at: string | null
          id: string
          order_id: string | null
          subject: string | null
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          id?: string
          order_id?: string | null
          subject?: string | null
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          id?: string
          order_id?: string | null
          subject?: string | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "conversations_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
        ]
      }
      delivery_companies: {
        Row: {
          active: boolean | null
          address: string | null
          bank_details: Json | null
          business_status: Database["public"]["Enums"]["business_status"]
          city: string | null
          company_name: string
          contact_name: string | null
          country: string | null
          created_at: string | null
          deleted_at: string | null
          delivery_number: string | null
          email: string | null
          id: string
          kyc_reviewed_at: string | null
          kyc_reviewed_by: string | null
          kyc_status: Database["public"]["Enums"]["kyc_status"]
          legal_form: Database["public"]["Enums"]["legal_form"] | null
          notes: string | null
          phone: string | null
          rating_avg: number | null
          tax_id: string | null
          updated_at: string | null
          user_id: string | null
          vehicle_types: Json | null
          zones_covered: Json | null
        }
        Insert: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          city?: string | null
          company_name: string
          contact_name?: string | null
          country?: string | null
          created_at?: string | null
          deleted_at?: string | null
          delivery_number?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          notes?: string | null
          phone?: string | null
          rating_avg?: number | null
          tax_id?: string | null
          updated_at?: string | null
          user_id?: string | null
          vehicle_types?: Json | null
          zones_covered?: Json | null
        }
        Update: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          city?: string | null
          company_name?: string
          contact_name?: string | null
          country?: string | null
          created_at?: string | null
          deleted_at?: string | null
          delivery_number?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          notes?: string | null
          phone?: string | null
          rating_avg?: number | null
          tax_id?: string | null
          updated_at?: string | null
          user_id?: string | null
          vehicle_types?: Json | null
          zones_covered?: Json | null
        }
        Relationships: []
      }
      documents: {
        Row: {
          created_at: string | null
          doc_type: string
          file_name: string | null
          file_size: number | null
          file_url: string
          id: string
          mime_type: string | null
          order_id: string | null
          uploaded_by: string | null
          visible_to: Json | null
        }
        Insert: {
          created_at?: string | null
          doc_type: string
          file_name?: string | null
          file_size?: number | null
          file_url: string
          id?: string
          mime_type?: string | null
          order_id?: string | null
          uploaded_by?: string | null
          visible_to?: Json | null
        }
        Update: {
          created_at?: string | null
          doc_type?: string
          file_name?: string | null
          file_size?: number | null
          file_url?: string
          id?: string
          mime_type?: string | null
          order_id?: string | null
          uploaded_by?: string | null
          visible_to?: Json | null
        }
        Relationships: [
          {
            foreignKeyName: "documents_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
        ]
      }
      exchange_rates: {
        Row: {
          created_at: string | null
          currency_from: string
          currency_to: string
          id: string
          rate: number
          rate_date: string
          source: string | null
        }
        Insert: {
          created_at?: string | null
          currency_from?: string
          currency_to?: string
          id?: string
          rate: number
          rate_date?: string
          source?: string | null
        }
        Update: {
          created_at?: string | null
          currency_from?: string
          currency_to?: string
          id?: string
          rate?: number
          rate_date?: string
          source?: string | null
        }
        Relationships: []
      }
      freight_forwarders: {
        Row: {
          active: boolean | null
          address: string | null
          bank_details: Json | null
          business_status: Database["public"]["Enums"]["business_status"]
          city: string | null
          company_name: string
          contact_name: string | null
          country: string | null
          created_at: string | null
          deleted_at: string | null
          email: string | null
          id: string
          kyc_reviewed_at: string | null
          kyc_reviewed_by: string | null
          kyc_status: Database["public"]["Enums"]["kyc_status"]
          legal_form: Database["public"]["Enums"]["legal_form"] | null
          license_number: string | null
          notes: string | null
          phone: string | null
          ports_covered: Json | null
          rating_avg: number | null
          services: Json | null
          tax_id: string | null
          updated_at: string | null
          user_id: string | null
        }
        Insert: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          city?: string | null
          company_name: string
          contact_name?: string | null
          country?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          license_number?: string | null
          notes?: string | null
          phone?: string | null
          ports_covered?: Json | null
          rating_avg?: number | null
          services?: Json | null
          tax_id?: string | null
          updated_at?: string | null
          user_id?: string | null
        }
        Update: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          city?: string | null
          company_name?: string
          contact_name?: string | null
          country?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          license_number?: string | null
          notes?: string | null
          phone?: string | null
          ports_covered?: Json | null
          rating_avg?: number | null
          services?: Json | null
          tax_id?: string | null
          updated_at?: string | null
          user_id?: string | null
        }
        Relationships: []
      }
      kyc_documents: {
        Row: {
          created_at: string | null
          doc_type: string
          document_number: string | null
          entity_id: string
          entity_type: string
          expiry_date: string | null
          file_name: string | null
          file_size: number | null
          file_url: string
          id: string
          mime_type: string | null
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["kyc_status"]
          uploaded_by: string | null
        }
        Insert: {
          created_at?: string | null
          doc_type: string
          document_number?: string | null
          entity_id: string
          entity_type: string
          expiry_date?: string | null
          file_name?: string | null
          file_size?: number | null
          file_url: string
          id?: string
          mime_type?: string | null
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["kyc_status"]
          uploaded_by?: string | null
        }
        Update: {
          created_at?: string | null
          doc_type?: string
          document_number?: string | null
          entity_id?: string
          entity_type?: string
          expiry_date?: string | null
          file_name?: string | null
          file_size?: number | null
          file_url?: string
          id?: string
          mime_type?: string | null
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["kyc_status"]
          uploaded_by?: string | null
        }
        Relationships: []
      }
      notifications: {
        Row: {
          created_at: string | null
          id: string
          link: string | null
          message: string
          read: boolean | null
          title: string
          type: string
          user_id: string
        }
        Insert: {
          created_at?: string | null
          id?: string
          link?: string | null
          message: string
          read?: boolean | null
          title: string
          type?: string
          user_id: string
        }
        Update: {
          created_at?: string | null
          id?: string
          link?: string | null
          message?: string
          read?: boolean | null
          title?: string
          type?: string
          user_id?: string
        }
        Relationships: []
      }
      order_items: {
        Row: {
          created_at: string | null
          id: string
          order_id: string
          product_id: string
          quantity: number
          subtotal_eur: number | null
          supplier_id: string
          unit_price_dzd: number
          unit_price_eur: number | null
        }
        Insert: {
          created_at?: string | null
          id?: string
          order_id: string
          product_id: string
          quantity: number
          subtotal_eur?: number | null
          supplier_id: string
          unit_price_dzd: number
          unit_price_eur?: number | null
        }
        Update: {
          created_at?: string | null
          id?: string
          order_id?: string
          product_id?: string
          quantity?: number
          subtotal_eur?: number | null
          supplier_id?: string
          unit_price_dzd?: number
          unit_price_eur?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "order_items_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "order_items_product_id_fkey"
            columns: ["product_id"]
            isOneToOne: false
            referencedRelation: "products_catalog"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "order_items_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "suppliers"
            referencedColumns: ["id"]
          },
        ]
      }
      orders: {
        Row: {
          buyer_id: string
          cancellation_reason: string | null
          cancelled_at: string | null
          confirmed_at: string | null
          created_at: string | null
          deleted_at: string | null
          delivered_at: string | null
          exchange_rate_id: string | null
          exchange_rate_value: number | null
          id: string
          notes: string | null
          paid_at: string | null
          status: Database["public"]["Enums"]["order_status"] | null
          total_amount_dzd: number | null
          total_amount_eur: number | null
          updated_at: string | null
        }
        Insert: {
          buyer_id: string
          cancellation_reason?: string | null
          cancelled_at?: string | null
          confirmed_at?: string | null
          created_at?: string | null
          deleted_at?: string | null
          delivered_at?: string | null
          exchange_rate_id?: string | null
          exchange_rate_value?: number | null
          id?: string
          notes?: string | null
          paid_at?: string | null
          status?: Database["public"]["Enums"]["order_status"] | null
          total_amount_dzd?: number | null
          total_amount_eur?: number | null
          updated_at?: string | null
        }
        Update: {
          buyer_id?: string
          cancellation_reason?: string | null
          cancelled_at?: string | null
          confirmed_at?: string | null
          created_at?: string | null
          deleted_at?: string | null
          delivered_at?: string | null
          exchange_rate_id?: string | null
          exchange_rate_value?: number | null
          id?: string
          notes?: string | null
          paid_at?: string | null
          status?: Database["public"]["Enums"]["order_status"] | null
          total_amount_dzd?: number | null
          total_amount_eur?: number | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "orders_buyer_id_fkey"
            columns: ["buyer_id"]
            isOneToOne: false
            referencedRelation: "buyers_eu"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "orders_exchange_rate_id_fkey"
            columns: ["exchange_rate_id"]
            isOneToOne: false
            referencedRelation: "exchange_rates"
            referencedColumns: ["id"]
          },
        ]
      }
      payments: {
        Row: {
          amount_eur: number
          created_at: string | null
          id: string
          metadata: Json | null
          order_id: string
          paid_at: string | null
          status: string | null
          stripe_payment_id: string | null
        }
        Insert: {
          amount_eur: number
          created_at?: string | null
          id?: string
          metadata?: Json | null
          order_id: string
          paid_at?: string | null
          status?: string | null
          stripe_payment_id?: string | null
        }
        Update: {
          amount_eur?: number
          created_at?: string | null
          id?: string
          metadata?: Json | null
          order_id?: string
          paid_at?: string | null
          status?: string | null
          stripe_payment_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "payments_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
        ]
      }
      payouts: {
        Row: {
          amount_dzd: number | null
          amount_eur: number
          confirmed_at: string | null
          created_at: string | null
          id: string
          method: string | null
          notes: string | null
          order_id: string
          payee_id: string
          payee_type: string
          reference: string | null
          sent_at: string | null
          status: string | null
        }
        Insert: {
          amount_dzd?: number | null
          amount_eur: number
          confirmed_at?: string | null
          created_at?: string | null
          id?: string
          method?: string | null
          notes?: string | null
          order_id: string
          payee_id: string
          payee_type: string
          reference?: string | null
          sent_at?: string | null
          status?: string | null
        }
        Update: {
          amount_dzd?: number | null
          amount_eur?: number
          confirmed_at?: string | null
          created_at?: string | null
          id?: string
          method?: string | null
          notes?: string | null
          order_id?: string
          payee_id?: string
          payee_type?: string
          reference?: string | null
          sent_at?: string | null
          status?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "payouts_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
        ]
      }
      products_catalog: {
        Row: {
          active: boolean | null
          available_qty: number | null
          category: string | null
          created_at: string | null
          deleted_at: string | null
          description: string | null
          id: string
          image_url: string | null
          min_order_qty: number | null
          price_dzd: number
          product_name: string
          status: Database["public"]["Enums"]["product_status"]
          supplier_id: string
          unit: string
          updated_at: string | null
        }
        Insert: {
          active?: boolean | null
          available_qty?: number | null
          category?: string | null
          created_at?: string | null
          deleted_at?: string | null
          description?: string | null
          id?: string
          image_url?: string | null
          min_order_qty?: number | null
          price_dzd: number
          product_name: string
          status?: Database["public"]["Enums"]["product_status"]
          supplier_id: string
          unit?: string
          updated_at?: string | null
        }
        Update: {
          active?: boolean | null
          available_qty?: number | null
          category?: string | null
          created_at?: string | null
          deleted_at?: string | null
          description?: string | null
          id?: string
          image_url?: string | null
          min_order_qty?: number | null
          price_dzd?: number
          product_name?: string
          status?: Database["public"]["Enums"]["product_status"]
          supplier_id?: string
          unit?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "products_catalog_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "suppliers"
            referencedColumns: ["id"]
          },
        ]
      }
      quote_requests: {
        Row: {
          created_at: string | null
          deadline: string | null
          id: string
          order_id: string
          status: Database["public"]["Enums"]["quote_status"] | null
          supplier_id: string
          transport_mode: string | null
        }
        Insert: {
          created_at?: string | null
          deadline?: string | null
          id?: string
          order_id: string
          status?: Database["public"]["Enums"]["quote_status"] | null
          supplier_id: string
          transport_mode?: string | null
        }
        Update: {
          created_at?: string | null
          deadline?: string | null
          id?: string
          order_id?: string
          status?: Database["public"]["Enums"]["quote_status"] | null
          supplier_id?: string
          transport_mode?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "quote_requests_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "quote_requests_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "suppliers"
            referencedColumns: ["id"]
          },
        ]
      }
      quotes: {
        Row: {
          created_at: string | null
          estimated_days: number | null
          id: string
          notes: string | null
          price_breakdown: Json | null
          price_eur: number
          provider_id: string
          provider_type: string
          quote_request_id: string
          status: Database["public"]["Enums"]["quote_response_status"] | null
          valid_until: string | null
        }
        Insert: {
          created_at?: string | null
          estimated_days?: number | null
          id?: string
          notes?: string | null
          price_breakdown?: Json | null
          price_eur: number
          provider_id: string
          provider_type: string
          quote_request_id: string
          status?: Database["public"]["Enums"]["quote_response_status"] | null
          valid_until?: string | null
        }
        Update: {
          created_at?: string | null
          estimated_days?: number | null
          id?: string
          notes?: string | null
          price_breakdown?: Json | null
          price_eur?: number
          provider_id?: string
          provider_type?: string
          quote_request_id?: string
          status?: Database["public"]["Enums"]["quote_response_status"] | null
          valid_until?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "quotes_quote_request_id_fkey"
            columns: ["quote_request_id"]
            isOneToOne: false
            referencedRelation: "quote_requests"
            referencedColumns: ["id"]
          },
        ]
      }
      reviews: {
        Row: {
          comment: string | null
          created_at: string | null
          id: string
          order_id: string | null
          rating: number
          reviewer_id: string
          status: Database["public"]["Enums"]["review_status"]
          target_id: string
          target_type: string
        }
        Insert: {
          comment?: string | null
          created_at?: string | null
          id?: string
          order_id?: string | null
          rating: number
          reviewer_id: string
          status?: Database["public"]["Enums"]["review_status"]
          target_id: string
          target_type: string
        }
        Update: {
          comment?: string | null
          created_at?: string | null
          id?: string
          order_id?: string | null
          rating?: number
          reviewer_id?: string
          status?: Database["public"]["Enums"]["review_status"]
          target_id?: string
          target_type?: string
        }
        Relationships: [
          {
            foreignKeyName: "reviews_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
        ]
      }
      shipments: {
        Row: {
          arrived_at: string | null
          carrier_id: string | null
          carrier_type: string | null
          created_at: string | null
          delivered_at: string | null
          departed_at: string | null
          destination_location: string | null
          id: string
          incoterm: Database["public"]["Enums"]["incoterm_type"] | null
          order_id: string
          origin_location: string | null
          package_type: Database["public"]["Enums"]["package_type"] | null
          status: Database["public"]["Enums"]["shipment_status"]
          tracking_number: string | null
          transport_mode: Database["public"]["Enums"]["transport_mode"]
          updated_at: string | null
        }
        Insert: {
          arrived_at?: string | null
          carrier_id?: string | null
          carrier_type?: string | null
          created_at?: string | null
          delivered_at?: string | null
          departed_at?: string | null
          destination_location?: string | null
          id?: string
          incoterm?: Database["public"]["Enums"]["incoterm_type"] | null
          order_id: string
          origin_location?: string | null
          package_type?: Database["public"]["Enums"]["package_type"] | null
          status?: Database["public"]["Enums"]["shipment_status"]
          tracking_number?: string | null
          transport_mode: Database["public"]["Enums"]["transport_mode"]
          updated_at?: string | null
        }
        Update: {
          arrived_at?: string | null
          carrier_id?: string | null
          carrier_type?: string | null
          created_at?: string | null
          delivered_at?: string | null
          departed_at?: string | null
          destination_location?: string | null
          id?: string
          incoterm?: Database["public"]["Enums"]["incoterm_type"] | null
          order_id?: string
          origin_location?: string | null
          package_type?: Database["public"]["Enums"]["package_type"] | null
          status?: Database["public"]["Enums"]["shipment_status"]
          tracking_number?: string | null
          transport_mode?: Database["public"]["Enums"]["transport_mode"]
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "shipments_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
        ]
      }
      subscriptions: {
        Row: {
          amount_eur: number
          billing_cycle: string
          cancelled_at: string | null
          created_at: string | null
          current_period_end: string | null
          current_period_start: string | null
          entity_id: string
          entity_type: string
          id: string
          payment_method: Database["public"]["Enums"]["payment_method"] | null
          plan: Database["public"]["Enums"]["subscription_plan"]
          status: Database["public"]["Enums"]["sub_status"]
          stripe_subscription_id: string | null
          updated_at: string | null
        }
        Insert: {
          amount_eur: number
          billing_cycle?: string
          cancelled_at?: string | null
          created_at?: string | null
          current_period_end?: string | null
          current_period_start?: string | null
          entity_id: string
          entity_type: string
          id?: string
          payment_method?: Database["public"]["Enums"]["payment_method"] | null
          plan?: Database["public"]["Enums"]["subscription_plan"]
          status?: Database["public"]["Enums"]["sub_status"]
          stripe_subscription_id?: string | null
          updated_at?: string | null
        }
        Update: {
          amount_eur?: number
          billing_cycle?: string
          cancelled_at?: string | null
          created_at?: string | null
          current_period_end?: string | null
          current_period_start?: string | null
          entity_id?: string
          entity_type?: string
          id?: string
          payment_method?: Database["public"]["Enums"]["payment_method"] | null
          plan?: Database["public"]["Enums"]["subscription_plan"]
          status?: Database["public"]["Enums"]["sub_status"]
          stripe_subscription_id?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      suppliers: {
        Row: {
          active: boolean | null
          address: string | null
          bank_details: Json | null
          business_status: Database["public"]["Enums"]["business_status"]
          certifications: Json | null
          city: string | null
          company_name: string
          contact_name: string | null
          created_at: string | null
          deleted_at: string | null
          email: string | null
          id: string
          kyc_reviewed_at: string | null
          kyc_reviewed_by: string | null
          kyc_status: Database["public"]["Enums"]["kyc_status"]
          legal_form: Database["public"]["Enums"]["legal_form"] | null
          notes: string | null
          phone: string | null
          product_categories: Json | null
          rating_avg: number | null
          supplier_number: string | null
          tax_id: string | null
          updated_at: string | null
          user_id: string | null
          wilaya_code: string | null
        }
        Insert: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          certifications?: Json | null
          city?: string | null
          company_name: string
          contact_name?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          notes?: string | null
          phone?: string | null
          product_categories?: Json | null
          rating_avg?: number | null
          supplier_number?: string | null
          tax_id?: string | null
          updated_at?: string | null
          user_id?: string | null
          wilaya_code?: string | null
        }
        Update: {
          active?: boolean | null
          address?: string | null
          bank_details?: Json | null
          business_status?: Database["public"]["Enums"]["business_status"]
          certifications?: Json | null
          city?: string | null
          company_name?: string
          contact_name?: string | null
          created_at?: string | null
          deleted_at?: string | null
          email?: string | null
          id?: string
          kyc_reviewed_at?: string | null
          kyc_reviewed_by?: string | null
          kyc_status?: Database["public"]["Enums"]["kyc_status"]
          legal_form?: Database["public"]["Enums"]["legal_form"] | null
          notes?: string | null
          phone?: string | null
          product_categories?: Json | null
          rating_avg?: number | null
          supplier_number?: string | null
          tax_id?: string | null
          updated_at?: string | null
          user_id?: string | null
          wilaya_code?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "fk_suppliers_wilaya_code"
            columns: ["wilaya_code"]
            isOneToOne: false
            referencedRelation: "wilayas"
            referencedColumns: ["code"]
          },
        ]
      }
      transactions: {
        Row: {
          amount_eur: number
          created_at: string | null
          currency: string
          id: string
          notes: string | null
          payment_method: Database["public"]["Enums"]["payment_method"] | null
          related_order_id: string | null
          related_payout_id: string | null
          related_subscription_id: string | null
          status: Database["public"]["Enums"]["transaction_status"]
          stripe_reference: string | null
          type: Database["public"]["Enums"]["transaction_type"]
        }
        Insert: {
          amount_eur: number
          created_at?: string | null
          currency?: string
          id?: string
          notes?: string | null
          payment_method?: Database["public"]["Enums"]["payment_method"] | null
          related_order_id?: string | null
          related_payout_id?: string | null
          related_subscription_id?: string | null
          status?: Database["public"]["Enums"]["transaction_status"]
          stripe_reference?: string | null
          type: Database["public"]["Enums"]["transaction_type"]
        }
        Update: {
          amount_eur?: number
          created_at?: string | null
          currency?: string
          id?: string
          notes?: string | null
          payment_method?: Database["public"]["Enums"]["payment_method"] | null
          related_order_id?: string | null
          related_payout_id?: string | null
          related_subscription_id?: string | null
          status?: Database["public"]["Enums"]["transaction_status"]
          stripe_reference?: string | null
          type?: Database["public"]["Enums"]["transaction_type"]
        }
        Relationships: [
          {
            foreignKeyName: "transactions_related_order_id_fkey"
            columns: ["related_order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "transactions_related_payout_id_fkey"
            columns: ["related_payout_id"]
            isOneToOne: false
            referencedRelation: "payouts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "transactions_related_subscription_id_fkey"
            columns: ["related_subscription_id"]
            isOneToOne: false
            referencedRelation: "subscriptions"
            referencedColumns: ["id"]
          },
        ]
      }
      user_roles: {
        Row: {
          granted_at: string | null
          granted_by: string | null
          id: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Insert: {
          granted_at?: string | null
          granted_by?: string | null
          id?: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Update: {
          granted_at?: string | null
          granted_by?: string | null
          id?: string
          role?: Database["public"]["Enums"]["app_role"]
          user_id?: string
        }
        Relationships: []
      }
      vehicles: {
        Row: {
          active: boolean
          capacity_kg: number | null
          carrier_id: string
          carrier_type: string
          created_at: string | null
          deleted_at: string | null
          id: string
          is_refrigerated: boolean
          plate_number: string
          updated_at: string | null
          vehicle_type: string | null
        }
        Insert: {
          active?: boolean
          capacity_kg?: number | null
          carrier_id: string
          carrier_type: string
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          is_refrigerated?: boolean
          plate_number: string
          updated_at?: string | null
          vehicle_type?: string | null
        }
        Update: {
          active?: boolean
          capacity_kg?: number | null
          carrier_id?: string
          carrier_type?: string
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          is_refrigerated?: boolean
          plate_number?: string
          updated_at?: string | null
          vehicle_type?: string | null
        }
        Relationships: []
      }
      wilayas: {
        Row: {
          code: string
          created_at: string | null
          name_ar: string
          name_en: string
          name_fr: string
        }
        Insert: {
          code: string
          created_at?: string | null
          name_ar: string
          name_en: string
          name_fr: string
        }
        Update: {
          code?: string
          created_at?: string | null
          name_ar?: string
          name_en?: string
          name_fr?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      get_buyer_id: { Args: never; Returns: string }
      get_carrier_dz_id: { Args: never; Returns: string }
      get_carrier_eu_id: { Args: never; Returns: string }
      get_delivery_company_id: { Args: never; Returns: string }
      get_freight_forwarder_id: { Args: never; Returns: string }
      get_public_catalogue_categories: {
        Args: never
        Returns: {
          category: string
        }[]
      }
      get_public_catalogue_products: {
        Args: {
          category_filter?: string
          limit_count?: number
          search_text?: string
        }
        Returns: {
          available_qty: number
          category: string
          created_at: string
          description: string
          image_url: string
          min_order_qty: number
          price_dzd: number
          product_id: string
          product_name: string
          supplier_city: string
          supplier_company_name: string
          supplier_id: string
          supplier_rating_avg: number
          supplier_wilaya: string
          unit: string
        }[]
      }
      get_supplier_id: { Args: never; Returns: string }
      is_admin: { Args: never; Returns: boolean }
      is_catalog_manager: { Args: never; Returns: boolean }
      is_conversation_participant: {
        Args: { conv_id: string }
        Returns: boolean
      }
      is_current_user_actor: {
        Args: { p_id: string; p_type: string }
        Returns: boolean
      }
      is_developer: { Args: never; Returns: boolean }
      is_finance: { Args: never; Returns: boolean }
      is_kyc_officer: { Args: never; Returns: boolean }
      is_logistics: { Args: never; Returns: boolean }
      is_moderator: { Args: never; Returns: boolean }
      is_order_participant: { Args: { o_id: string }; Returns: boolean }
      is_support: { Args: never; Returns: boolean }
      notify_expiring_documents: { Args: never; Returns: undefined }
      validate_polymorphic_ref: {
        Args: { p_id: string; p_type: string }
        Returns: boolean
      }
    }
    Enums: {
      ad_status: "pending" | "active" | "ended" | "rejected"
      app_role:
        | "admin"
        | "moderator"
        | "support"
        | "supplier"
        | "carrier_dz"
        | "carrier_eu"
        | "freight_forwarder"
        | "delivery_company"
        | "buyer_eu"
        | "finance"
        | "kyc_officer"
        | "logistics"
        | "catalog_manager"
        | "developer"
      business_status:
        | "draft"
        | "pending_review"
        | "rejected"
        | "active"
        | "suspended"
        | "closed"
      contact_type:
        | "commercial"
        | "logistics"
        | "management"
        | "technical"
        | "other"
      continent_type: "africa" | "europe" | "asia" | "america" | "oceania"
      conversation_status: "active" | "closed"
      incoterm_type: "FOB" | "CIF" | "CFR" | "EXW" | "DAP" | "DDP" | "FCA"
      kyc_status: "pending" | "verified" | "rejected"
      legal_form:
        | "sarl"
        | "spa"
        | "eurl"
        | "snc"
        | "surl"
        | "sas"
        | "auto_entrepreneur"
        | "association"
      measurement_unit:
        | "kg"
        | "ton"
        | "liter"
        | "m3"
        | "unit"
        | "m2"
        | "ml"
        | "carton"
        | "pallet"
      notification_type:
        | "new_message"
        | "new_quote_request"
        | "quote_response"
        | "status_change"
        | "new_review"
        | "subscription_alert"
        | "transport_request"
        | "transit_request"
        | "kyc_approved"
        | "kyc_rejected"
        | "system"
        | "document_expiring"
      order_status:
        | "confirmed"
        | "preparing"
        | "ready_to_ship"
        | "shipped"
        | "delivered"
        | "cancelled"
        | "disputed"
        | "draft"
        | "quotes_requested"
        | "quotes_received"
      package_type:
        | "pallet"
        | "container_20"
        | "container_40"
        | "carton"
        | "bulk"
        | "tank"
      payment_method: "card" | "transfer" | "ccp" | "check"
      product_status: "draft" | "published" | "archived" | "rejected"
      quote_response_status: "pending" | "accepted" | "refused"
      quote_status:
        | "sent"
        | "seen"
        | "answered"
        | "cancelled"
        | "expired"
        | "open"
        | "quoted"
      review_status: "published" | "moderated" | "reported"
      shipment_status:
        | "preparing"
        | "loaded"
        | "in_transit"
        | "arrived"
        | "delivered"
        | "delayed"
      shipping_doc_type:
        | "bl"
        | "awb"
        | "commercial_invoice"
        | "certificate_of_origin"
        | "phytosanitary"
        | "packing_list"
        | "customs_declaration"
        | "insurance"
        | "other"
      sub_status: "active" | "expired" | "cancelled"
      subscription_plan: "free" | "starter" | "pro" | "enterprise"
      supplier_doc_status: "pending" | "approved" | "rejected"
      supplier_doc_type:
        | "nrc"
        | "nif"
        | "export_register"
        | "articles_of_association"
        | "tax_certificate"
        | "other"
      transaction_status: "pending" | "completed" | "failed" | "refunded"
      transaction_type: "subscription" | "commission" | "refund"
      transport_mode: "maritime" | "air" | "road" | "rail" | "multimodal"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      ad_status: ["pending", "active", "ended", "rejected"],
      app_role: [
        "admin",
        "moderator",
        "support",
        "supplier",
        "carrier_dz",
        "carrier_eu",
        "freight_forwarder",
        "delivery_company",
        "buyer_eu",
        "finance",
        "kyc_officer",
        "logistics",
        "catalog_manager",
        "developer",
      ],
      business_status: [
        "draft",
        "pending_review",
        "rejected",
        "active",
        "suspended",
        "closed",
      ],
      contact_type: [
        "commercial",
        "logistics",
        "management",
        "technical",
        "other",
      ],
      continent_type: ["africa", "europe", "asia", "america", "oceania"],
      conversation_status: ["active", "closed"],
      incoterm_type: ["FOB", "CIF", "CFR", "EXW", "DAP", "DDP", "FCA"],
      kyc_status: ["pending", "verified", "rejected"],
      legal_form: [
        "sarl",
        "spa",
        "eurl",
        "snc",
        "surl",
        "sas",
        "auto_entrepreneur",
        "association",
      ],
      measurement_unit: [
        "kg",
        "ton",
        "liter",
        "m3",
        "unit",
        "m2",
        "ml",
        "carton",
        "pallet",
      ],
      notification_type: [
        "new_message",
        "new_quote_request",
        "quote_response",
        "status_change",
        "new_review",
        "subscription_alert",
        "transport_request",
        "transit_request",
        "kyc_approved",
        "kyc_rejected",
        "system",
        "document_expiring",
      ],
      order_status: [
        "confirmed",
        "preparing",
        "ready_to_ship",
        "shipped",
        "delivered",
        "cancelled",
        "disputed",
        "draft",
        "quotes_requested",
        "quotes_received",
      ],
      package_type: [
        "pallet",
        "container_20",
        "container_40",
        "carton",
        "bulk",
        "tank",
      ],
      payment_method: ["card", "transfer", "ccp", "check"],
      product_status: ["draft", "published", "archived", "rejected"],
      quote_response_status: ["pending", "accepted", "refused"],
      quote_status: [
        "sent",
        "seen",
        "answered",
        "cancelled",
        "expired",
        "open",
        "quoted",
      ],
      review_status: ["published", "moderated", "reported"],
      shipment_status: [
        "preparing",
        "loaded",
        "in_transit",
        "arrived",
        "delivered",
        "delayed",
      ],
      shipping_doc_type: [
        "bl",
        "awb",
        "commercial_invoice",
        "certificate_of_origin",
        "phytosanitary",
        "packing_list",
        "customs_declaration",
        "insurance",
        "other",
      ],
      sub_status: ["active", "expired", "cancelled"],
      subscription_plan: ["free", "starter", "pro", "enterprise"],
      supplier_doc_status: ["pending", "approved", "rejected"],
      supplier_doc_type: [
        "nrc",
        "nif",
        "export_register",
        "articles_of_association",
        "tax_certificate",
        "other",
      ],
      transaction_status: ["pending", "completed", "failed", "refunded"],
      transaction_type: ["subscription", "commission", "refund"],
      transport_mode: ["maritime", "air", "road", "rail", "multimodal"],
    },
  },
} as const

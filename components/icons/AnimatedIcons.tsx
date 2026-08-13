// components/icons/AnimatedIcons.tsx

// ==========================================
// 1. RÉTICULE DE CIBLAGE (Tracking / Paiement)
// ==========================================
export const RadarTargetIcon = ({ ...props }) => {
  return (
    <svg
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      {/* Croix de visée fixe ultra-fine */}
      <path 
        d="M12 6V10M12 14V18M6 12H10M14 12H18" 
        stroke="currentColor" 
        strokeWidth="1" 
        opacity="0.4"
        className="icon-radar-demo"
        style={{
          strokeDasharray: 20,
          strokeDashoffset: 20,
          animation: 'line-draw 1s ease-out forwards'
        }}
      />
      
      {/* Point central fixe */}
      <circle cx="12" cy="12" r="1.5" fill="currentColor" />
      
      {/* Ondes de pulsation radar */}
      <circle cx="12" cy="12" stroke="currentColor" fill="none" strokeWidth="1.5">
        <animate attributeName="r" from="3" to="10" dur="2s" begin="0s" repeatCount="indefinite" />
        <animate attributeName="opacity" from="0.8" to="0" dur="2s" begin="0s" repeatCount="indefinite" />
        <animate attributeName="stroke-width" from="1.5" to="0.2" dur="2s" begin="0s" repeatCount="indefinite" />
      </circle>
      <circle cx="12" cy="12" stroke="currentColor" fill="none" strokeWidth="1.5">
        <animate attributeName="r" from="3" to="10" dur="2s" begin="0.7s" repeatCount="indefinite" />
        <animate attributeName="opacity" from="0.8" to="0" dur="2s" begin="0.7s" repeatCount="indefinite" />
        <animate attributeName="stroke-width" from="1.5" to="0.2" dur="2s" begin="0.7s" repeatCount="indefinite" />
      </circle>
    </svg>
  );
};

// ==========================================
// 2. RÉSEAU MAILLÉ (KYC / Vérification)
// ==========================================
export const MeshNetworkIcon = ({ ...props }) => {
  return (
    <svg
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      {/* Structure géométrique qui se trace */}
      <path 
        d="M12 3L21 7.5V16.5L12 21L3 16.5V7.5L12 3Z" 
        stroke="currentColor" 
        strokeWidth="1.5"
        className="icon-radar-demo"
        style={{
          strokeDasharray: 60,
          strokeDashoffset: 60,
          animation: 'line-draw 1.5s ease-out forwards'
        }}
      />
      
      {/* Lignes de structure internes (apparaissent en fondu) */}
      <path d="M12 12L3 7.5M12 12L21 7.5M12 12V21M12 12L3 16.5M12 12L21 16.5M12 3V12" stroke="currentColor" strokeWidth="0.5" opacity="0.3" />
      
      {/* Nœuds de connexion aux sommets */}
      <circle cx="12" cy="3" r="1.5" fill="currentColor" className="icon-radar-demo" style={{ animation: 'line-draw 0.3s ease-out 1.2s both' }} />
      <circle cx="21" cy="7.5" r="1.5" fill="currentColor" className="icon-radar-demo" style={{ animation: 'line-draw 0.3s ease-out 1.3s both' }} />
      <circle cx="21" cy="16.5" r="1.5" fill="currentColor" className="icon-radar-demo" style={{ animation: 'line-draw 0.3s ease-out 1.4s both' }} />
      <circle cx="12" cy="21" r="1.5" fill="currentColor" className="icon-radar-demo" style={{ animation: 'line-draw 0.3s ease-out 1.5s both' }} />
      <circle cx="3" cy="16.5" r="1.5" fill="currentColor" className="icon-radar-demo" style={{ animation: 'line-draw 0.3s ease-out 1.6s both' }} />
      <circle cx="3" cy="7.5" r="1.5" fill="currentColor" className="icon-radar-demo" style={{ animation: 'line-draw 0.3s ease-out 1.7s both' }} />
      
      {/* Nœud central lumineux */}
      <circle cx="12" cy="12" r="2" fill="currentColor" />
    </svg>
  );
};

// ==========================================
// 3. CIRCUIT IMPRIMÉ (Transit / Flux de données)
// ==========================================
export const CircuitStreamIcon = ({ ...props }) => {
  return (
    <svg
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      {/* Trace du circuit qui se dessine */}
      <path 
        d="M3 12H9L12 8H21" 
        stroke="currentColor" 
        strokeWidth="1.5"
        className="icon-radar-demo"
        style={{
          strokeDasharray: 25,
          strokeDashoffset: 25,
          animation: 'line-draw 1s ease-out forwards'
        }}
      />
      <path 
        d="M3 16H15L18 12H21" 
        stroke="currentColor" 
        strokeWidth="1.5" 
        opacity="0.4"
        className="icon-radar-demo"
        style={{
          strokeDasharray: 20,
          strokeDashoffset: 20,
          animation: 'line-draw 1s ease-out 0.3s forwards'
        }}
      />

      {/* Points de données qui voyagent sur le circuit principal */}
      <circle cx="3" cy="12" r="1" fill="currentColor" />
      <circle cx="12" cy="8" r="1" fill="currentColor" />
      <circle cx="21" cy="8" r="1" fill="currentColor" className="icon-radar-demo" style={{ transformOrigin: 'center', animation: 'stream-flow 1.5s ease-in-out 1.2s infinite' }} />
      
      {/* Points de données secondaires */}
      <circle cx="15" cy="16" r="0.75" fill="currentColor" opacity="0.5" />
      <circle cx="18" cy="12" r="0.75" fill="currentColor" opacity="0.5" />
      <circle cx="21" cy="12" r="0.75" fill="currentColor" opacity="0.5" className="icon-radar-demo" style={{ transformOrigin: 'center', animation: 'stream-flow 1.5s ease-in-out 1.5s infinite' }} />
    </svg>
  );
};
// ==========================================
// 4. AGROALIMENTAIRE
// ==========================================
export const AgroIcon = ({ ...props }) => (
  <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" {...props}>
    <path d="M2 22 16 8" />
    <path d="M3.47 12.53 5 11l1.53 1.53a3.5 3.5 0 0 1 0 4.94L5 19l-1.53-1.53a3.5 3.5 0 0 1 0-4.94Z" />
    <path d="M7.47 8.53 9 7l1.53 1.53a3.5 3.5 0 0 1 0 4.94L9 15l-1.53-1.53a3.5 3.5 0 0 1 0-4.94Z" />
    <path d="M11.47 4.53 13 3l1.53 1.53a3.5 3.5 0 0 1 0 4.94L13 11l-1.53-1.53a3.5 3.5 0 0 1 0-4.94Z" />
    <path d="M20 2h2v2a4 4 0 0 1-4 4h-2V6a4 4 0 0 1 4-4Z" />
  </svg>
);

// ==========================================
// 5. CONSTRUCTION
// ==========================================
export const ConstructionIcon = ({ ...props }) => (
  <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" {...props}>
    <path d="M6 22V4a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v18Z" />
    <path d="M6 12H4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h2" />
    <path d="M18 9h2a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2h-2" />
    <path d="M10 6h4" /><path d="M10 10h4" /><path d="M10 14h4" /><path d="M10 18h4" />
  </svg>
);

// ==========================================
// 6. CHIMIE
// ==========================================
export const ChemistryIcon = ({ ...props }) => (
  <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" {...props}>
    <path d="M10 2v7.527a2 2 0 0 1-.211.896L4.72 20.55a1 1 0 0 0 .9 1.45h12.76a1 1 0 0 0 .9-1.45l-5.069-10.127A2 2 0 0 1 14 9.527V2" />
    <path d="M8.5 2h7" />
    <path d="M7 16.5h10" />
  </svg>
);

// ==========================================
// 7. TEXTILE
// ==========================================
export const TextileIcon = ({ ...props }) => (
  <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" {...props}>
    <circle cx="6" cy="6" r="3" />
    <path d="M8.12 8.12 12 12" />
    <path d="M20 4 8.12 15.88" />
    <circle cx="6" cy="18" r="3" />
    <path d="M14.8 14.8 20 20" />
  </svg>
);

import { Context, Next } from 'hono';

// Extremely aggressive deep object mutator for native Edge Translation
function translatePayload(obj: any): any {
  // Ultra-fast dictionary for Cloudflare Edge Payload Intercepts
  const frDictionary: Record<string, string> = {
    // Headers & SDUI
    "Personal Information": "Informations Personnelles",
    "Submit": "Soumettre",
    "Cancel": "Annuler",
    // Shell Titles
    "Home": "Tableau de Bord",
    "My Shifts": "Mes Quarts",
    "Messages": "Messages",
    "Incidents": "Incidents",
    "Training": "Formation",
    "Settings": "Paramètres",
    "Profile": "Profil",
    "Live Dispatch Matrix": "Matrice de Répartition Active",
    // Data Matrix Status
    "Unassigned": "Non Assigné",
    "Assigned": "Assigné",
    "GPS Verified": "GPS Vérifié",
    "Completed": "Terminé",
    "completed": "Terminé",
    "verified": "Vérifié",
    "assigned": "Assigné",
    "unstaffed": "Non Assigné",
    // Shift Analytics
    "Fleet Utilization": "Utilisation de la Flotte",
    "Check Blood Pressure": "Vérifier la Tension Artérielle",
    "Administer Morning Meds": "Administrer les Médicaments",
    "Assist with Bathing": "Aider à la Toilette",
    "Prepare Breakfast": "Préparer le Petit Déjeuner",
    "Check In": "Enregistrement",
    "Checkout": "Caisse",
    "Verify GPS": "Vérifier le GPS",
    // Operations
    "Sports Massage - Gym": "Massage Sportif - Gymnase",
    "Therapeutic Massage 60m": "Massage Thérapeutique 60m",
    "Facility Block": "Bloc d'Établissement"
  };

  if (typeof obj === 'string') {
    // Capitalize exactly if translation exists
    return frDictionary[obj] || obj; 
  } else if (Array.isArray(obj)) {
    return obj.map(translatePayload);
  } else if (obj !== null && typeof obj === 'object') {
    const translated: any = {};
    for (const key in obj) {
      if (['label', 'title', 'text', 'message', 'name', 'patient', 'status', 'description'].includes(key) && typeof obj[key] === 'string') {
        const t = frDictionary[obj[key]];
        translated[key] = t ? t : obj[key];
      } else {
        translated[key] = translatePayload(obj[key]);
      }
    }
    return translated;
  }
  return obj;
}

export const edgeTranslator = () => async (c: Context, next: Next) => {
  await next();
  
  // Read request boundary headers or query strings injected explicitly by mobile FLutter clients
  const lang = c.req.header('Accept-Language') || c.req.query('lang');
  
  if (lang && lang.toLowerCase().startsWith('fr')) {
    const contentType = c.res.headers.get('content-type');
    if (contentType && contentType.includes('application/json')) {
      try {
        const resClone = c.res.clone();
        const data = await resClone.json();
        
        // Execute absolute deep translation map across payload array
        const translatedData = translatePayload(data);
        
        c.res = new Response(JSON.stringify(translatedData), {
          status: c.res.status,
          statusText: c.res.statusText,
          headers: c.res.headers,
        });
      } catch (e) {
        console.error('Edge Translation Stream interception failed natively:', e);
      }
    }
  }
};

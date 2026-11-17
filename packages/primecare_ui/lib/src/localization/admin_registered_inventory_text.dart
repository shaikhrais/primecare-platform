/// Fallback text for the existing native catalog screens, matching their
/// supported English, French and Spanish locales.
class AdminRegisteredInventoryText {
  static const _catalog = {
    'en': {
      'hint': 'Search registered screens',
      'search': 'Search',
      'reload': 'Reload',
      'roleKey': 'Exact role key',
      'denied': 'Screen inventory access denied.',
      'loading': 'Loading registered screens…',
      'error': 'Screen inventory unavailable.',
      'empty': 'No matching registered screens on this page.',
      'previous': 'Previous',
      'next': 'Next',
      'range': '{first}–{last} of {total}',
      'noRole': 'Role unavailable',
      'noName': 'Screen name unavailable',
      'ready': 'Recorded production-ready',
      'notReady': 'Not recorded as production-ready',
      'unknownReadiness': 'Production readiness unavailable',
      'realityGap': 'Interaction metrics, purpose audits and review flags are unavailable from this API.',
      'carouselGap': 'Interaction and workflow scores are unavailable from this API.',
      'galleryTitle': 'Visual Verification Gallery',
      'galleryGap': 'Screenshot images and visual verification scores are unavailable. This view shows registered screen metadata only.',
    },
    'fr': {
      'hint': 'Rechercher les écrans enregistrés',
      'search': 'Rechercher',
      'reload': 'Actualiser',
      'roleKey': 'Clé de rôle exacte',
      'denied': 'Accès à l’inventaire des écrans refusé.',
      'loading': 'Chargement des écrans enregistrés…',
      'error': 'Inventaire des écrans indisponible.',
      'empty': 'Aucun écran enregistré correspondant sur cette page.',
      'previous': 'Précédent',
      'next': 'Suivant',
      'range': '{first}–{last} sur {total}',
      'noRole': 'Rôle indisponible',
      'noName': 'Nom de l’écran indisponible',
      'ready': 'Enregistré comme prêt pour la production',
      'notReady': 'Non enregistré comme prêt pour la production',
      'unknownReadiness': 'État de préparation à la production indisponible',
      'realityGap': 'Les mesures d’interaction, les audits de finalité et les indicateurs de révision ne sont pas disponibles dans cette API.',
      'carouselGap': 'Les scores d’interaction et de flux de travail ne sont pas disponibles dans cette API.',
      'galleryTitle': 'Galerie de vérification visuelle',
      'galleryGap': 'Les captures d’écran et les scores de vérification visuelle sont indisponibles. Seules les métadonnées des écrans enregistrés sont affichées.',
    },
    'es': {
      'hint': 'Buscar pantallas registradas',
      'search': 'Buscar',
      'reload': 'Actualizar',
      'roleKey': 'Clave exacta del rol',
      'denied': 'Acceso al inventario de pantallas denegado.',
      'loading': 'Cargando pantallas registradas…',
      'error': 'Inventario de pantallas no disponible.',
      'empty': 'No hay pantallas registradas que coincidan en esta página.',
      'previous': 'Anterior',
      'next': 'Siguiente',
      'range': '{first}–{last} de {total}',
      'noRole': 'Rol no disponible',
      'noName': 'Nombre de la pantalla no disponible',
      'ready': 'Registrada como lista para producción',
      'notReady': 'No registrada como lista para producción',
      'unknownReadiness': 'Estado de preparación para producción no disponible',
      'realityGap': 'Las métricas de interacción, las auditorías de propósito y los indicadores de revisión no están disponibles en esta API.',
      'carouselGap': 'Las puntuaciones de interacción y flujo de trabajo no están disponibles en esta API.',
      'galleryTitle': 'Galería de verificación visual',
      'galleryGap': 'Las capturas de pantalla y las puntuaciones de verificación visual no están disponibles. Solo se muestran los metadatos de pantallas registradas.',
    },
  };

  static String resolve(String language, String key,
      {Map<String, String> args = const {}}) {
    final template = (_catalog[language] ?? _catalog['en']!)[key];
    if (template == null) throw ArgumentError.value(key, 'key');
    return template.replaceAllMapped(RegExp(r'\{([a-z]+)\}'), (match) {
      final parameter = match.group(1)!;
      return args[parameter] ?? (throw ArgumentError.value(parameter, 'args'));
    });
  }
}

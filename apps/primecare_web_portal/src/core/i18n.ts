export type Language = 'en' | 'fr' | 'es';

export const translations = {
  en: {
    dashboard: 'Dashboard',
    clients: 'Clients',
    telemetry: 'Telemetry',
    settings: 'Settings',
    sys_overview: 'System Overview',
    client_mgmt: 'Client Management',
    real_time_telemetry: 'Real-time Telemetry',
    platform_settings: 'Platform Settings',
    profile: 'Profile',
    logout: 'Logout',
    system_health: 'System Health',
    active_sessions: 'Active Sessions',
    db_latency: 'Database Latency',
    all_operational: 'All core services operational.',
    fetching_telemetry: 'Fetching real-time telemetry stream...',
    under_construction: 'This section is currently under construction.',
    admin_portal: 'Admin Portal',
    superuser: 'Superuser Access',
    kitchen_sink: 'Kitchen Sink'
  },
  fr: {
    dashboard: 'Tableau de bord',
    clients: 'Clients',
    telemetry: 'Télémétrie',
    settings: 'Paramètres',
    sys_overview: 'Aperçu du système',
    client_mgmt: 'Gestion des clients',
    real_time_telemetry: 'Télémétrie en temps réel',
    platform_settings: 'Paramètres de la plateforme',
    profile: 'Profil',
    logout: 'Déconnexion',
    system_health: 'Santé du système',
    active_sessions: 'Sessions actives',
    db_latency: 'Latence de la base de données',
    all_operational: 'Tous les services essentiels sont opérationnels.',
    fetching_telemetry: 'Récupération du flux de télémétrie en temps réel...',
    under_construction: 'Cette section est actuellement en construction.',
    admin_portal: 'Portail Admin',
    superuser: 'Accès Super-utilisateur',
    kitchen_sink: 'Composants (Sink)'
  },
  es: {
    dashboard: 'Panel de control',
    clients: 'Clientes',
    telemetry: 'Telemetría',
    settings: 'Ajustes',
    sys_overview: 'Resumen del sistema',
    client_mgmt: 'Gestión de clientes',
    real_time_telemetry: 'Telemetría en tiempo real',
    platform_settings: 'Ajustes de la plataforma',
    profile: 'Perfil',
    logout: 'Cerrar sesión',
    system_health: 'Salud del sistema',
    active_sessions: 'Sesiones activas',
    db_latency: 'Latencia de base de datos',
    all_operational: 'Todos los servicios centrales operativos.',
    fetching_telemetry: 'Obteniendo flujo de telemetría en tiempo real...',
    under_construction: 'Esta sección está actualmente en construcción.',
    admin_portal: 'Portal de administración',
    superuser: 'Acceso de superusuario',
    kitchen_sink: 'Componentes (Sink)'
  }
};

export type TranslationKey = keyof typeof translations.en;

class I18nService {
  private currentLang: Language = 'en';

  public setLanguage(lang: Language) {
    this.currentLang = lang;
  }

  public getLanguage(): Language {
    return this.currentLang;
  }

  public t(key: TranslationKey): string {
    return translations[this.currentLang][key] || key;
  }
}

export const i18n = new I18nService();

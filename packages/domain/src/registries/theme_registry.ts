export const ThemeRegistry = {
    COLORS: {
        PRIMARY: '--pc-primary',
        PRIMARY_DARK: '--pc-primary-dark',
        PRIMARY_CONTAINER: '--pc-primary-container',
        BACKGROUND: '--pc-bg-primary',
        SURFACE: '--pc-surface-card',
        BORDER: '--pc-border-primary',
        BORDER_SECONDARY: '--pc-border-secondary',
        OUTLINE: '--pc-outline',
        TEXT: {
            PRIMARY: '--pc-text-primary',
            SECONDARY: '--pc-text-secondary',
            ON_PRIMARY: '--pc-text-on-primary',
        },
        STATUS: {
            SUCCESS: '--pc-success',
            WARNING: '--pc-warning',
            ERROR: '--pc-error',
            ERROR_CONTAINER: '--pc-error-container',
        }
    },
    PRESETS: {
        PRIMECARE_CLINICAL: {
            primary: '#004ac6',
            surface: '#f7f9fb',
            onSurface: '#191c1e',
            primaryContainer: '#2563eb',
            outline: '#737686',
        },
        PRIMECARE_DARK: {
            primary: '#b4c5ff',
            surface: '#191c1e',
            onSurface: '#eff1f3',
            primaryContainer: '#004ac6',
            outline: '#938f99',
        }
    }
} as const;

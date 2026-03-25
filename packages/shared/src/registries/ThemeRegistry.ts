export const ThemeRegistry = {
    COLORS: {
        PRIMARY: '--pc-primary',
        PRIMARY_DARK: '--pc-primary-dark',
        ACCENT: '--pc-accent',
        BACKGROUND: '--pc-bg',
        SURFACE: '--pc-surface',
        BORDER: '--pc-border',
        TEXT: {
            BASE: '--pc-text-base',
            MUTED: '--pc-text-muted',
            ON_PRIMARY: '--pc-text-on-primary',
        },
        STATUS: {
            SUCCESS: '--pc-status-success',
            WARNING: '--pc-status-warning',
            ERROR: '--pc-status-error',
            INFO: '--pc-status-info',
        }
    },
    PRESETS: {
        PRIMECARE_STANDARD: {
            primary: '#00897b',
            primaryDark: '#004d40',
            accent: '#c2ffd9',
        },
        DUSK_MODE: {
            primary: '#1e293b',
            primaryDark: '#0f172a',
            accent: '#38bdf8',
        },
        EMERALD_CITY: {
            primary: '#059669',
            primaryDark: '#064e3b',
            accent: '#a7f3d0',
        }
    }
} as const;

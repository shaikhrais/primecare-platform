/**
 * #21: Environment validation — run at application startup.
 * Ensures all required env vars are present before the app starts.
 * Prevents cryptic runtime errors from missing configuration.
 */

interface EnvVar {
    name: string;
    required: boolean;
    defaultValue?: string;
}

const REQUIRED_ENV_VARS: EnvVar[] = [
    { name: 'VITE_API_URL', required: true },
];

export function validateEnvironment(): void {
    const missing: string[] = [];

    for (const { name, required, defaultValue } of REQUIRED_ENV_VARS) {
        const value = import.meta.env[name];
        if (required && !value && !defaultValue) {
            missing.push(name);
        }
    }

    if (missing.length > 0) {
        console.error(
            `[ENV] Missing required environment variables: ${missing.join(', ')}. ` +
            `Create a .env file with these values.`
        );
    }
}

/**
 * .env.example template for new developers:
 *
 * VITE_API_URL=https://primecare-api.itpro-mohammed.workers.dev
 */

/**
 * Typed API Client — powered by openapi-fetch
 *
 * Pre-configured client that provides full type safety for all 363 API paths.
 * Request bodies, response types, and path parameters are all inferred from
 * the OpenAPI spec — zero manual type annotations needed.
 *
 * Usage:
 *   import { createApiClient } from '@primecare/contracts/client';
 *
 *   const api = createApiClient('https://api.example.com');
 *   const { data } = await api.GET('/v1/admin/users');
 *   //    ^? User[]  (inferred from spec)
 *
 *   await api.POST('/v1/admin/users', {
 *     body: { email: 'test@test.com', fullName: 'Test', roles: ['admin'] },
 *   });
 */
import createClient from 'openapi-fetch';
import type { paths } from '../generated/api';

/**
 * Create a typed API client instance.
 *
 * @param baseUrl - The base URL of the worker-api (e.g., https://api.primecare.com)
 * @param options - Additional fetch options (headers, credentials, etc.)
 */
export function createApiClient(
    baseUrl: string,
    options?: {
        headers?: Record<string, string>;
        credentials?: RequestCredentials;
    }
) {
    return createClient<paths>({
        baseUrl,
        credentials: options?.credentials ?? 'include',
        headers: {
            'Content-Type': 'application/json',
            ...options?.headers,
        },
    });
}

export type { paths };
export default createApiClient;

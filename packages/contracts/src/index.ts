/**
 * @primecare/contracts — Auto-Generated API Types
 *
 * This package provides TypeScript types auto-generated from the PrimeCare
 * Worker API OpenAPI specification (363 paths, 375+ endpoints).
 *
 * Usage:
 *   import type { paths, operations } from '@primecare/contracts';
 *
 *   // Get the response type for a specific endpoint:
 *   type UsersResponse = paths['/v1/admin/users']['get']['responses']['200']['content']['application/json'];
 *
 *   // Get the request body for a mutation:
 *   type CreateUserBody = paths['/v1/admin/users']['post']['requestBody']['content']['application/json'];
 *
 * Regenerate types:
 *   npm run api:generate
 */

// Re-export all generated types
export type { paths, operations, components } from '../generated/api';

// ── Helper Types ────────────────────────────────────────────────────────────

/**
 * Extract the successful (2xx) JSON response type for a given path + method.
 *
 * @example
 *   type Users = ApiResponse<'/v1/admin/users', 'get'>;
 */
export type ApiResponse<
    P extends keyof import('../generated/api').paths,
    M extends keyof import('../generated/api').paths[P],
> = import('../generated/api').paths[P][M] extends {
    responses: { 200: { content: { 'application/json': infer R } } };
}
    ? R
    : import('../generated/api').paths[P][M] extends {
            responses: { 201: { content: { 'application/json': infer R } } };
        }
        ? R
        : never;

/**
 * Extract the request body type for a given path + method.
 *
 * @example
 *   type CreateUserBody = ApiRequestBody<'/v1/admin/users', 'post'>;
 */
export type ApiRequestBody<
    P extends keyof import('../generated/api').paths,
    M extends keyof import('../generated/api').paths[P],
> = import('../generated/api').paths[P][M] extends {
    requestBody?: { content: { 'application/json': infer B } };
}
    ? B
    : never;

/**
 * Extract path parameter types for a given path + method.
 *
 * @example
 *   type UserParams = ApiPathParams<'/v1/admin/users/{id}/roles', 'patch'>;
 *   // { id: string }
 */
export type ApiPathParams<
    P extends keyof import('../generated/api').paths,
    M extends keyof import('../generated/api').paths[P],
> = import('../generated/api').paths[P][M] extends {
    parameters: { path: infer PP };
}
    ? PP
    : never;

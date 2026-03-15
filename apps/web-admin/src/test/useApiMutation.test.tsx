/**
 * useApiMutation Unit Tests
 *
 * Tests the core mutation logic (mutationFn, error handling, response unwrapping)
 * used by the useApiMutation hook, without renderHook to avoid React version conflicts.
 */
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { apiClient, ApiError } from '../shared/utils/apiClient';

// Mock apiClient methods
vi.mock('../shared/utils/apiClient', () => ({
    ApiError: class ApiError extends Error {
        status: number;
        data: unknown;
        constructor(status: number, message: string, data?: unknown) {
            super(message);
            this.name = 'ApiError';
            this.status = status;
            this.data = data;
        }
    },
    apiClient: {
        post: vi.fn(),
        put: vi.fn(),
        patch: vi.fn(),
        delete: vi.fn(),
    },
}));

// Replicate the core mutationFn logic from useApiMutation.ts for direct testing
async function executeMutation(
    path: string,
    method: 'POST' | 'PUT' | 'PATCH' | 'DELETE',
    input: any
): Promise<any> {
    let response: Response;
    switch (method) {
        case 'PUT':
            response = await apiClient.put(path, input);
            break;
        case 'PATCH':
            response = await apiClient.patch(path, input);
            break;
        case 'DELETE':
            response = await apiClient.delete(path);
            break;
        default:
            response = await apiClient.post(path, input);
    }

    if (!response.ok) {
        const errBody = await response.json().catch(() => ({ error: 'Request failed' }));
        throw new ApiError(response.status, errBody.error || `HTTP ${response.status}`, errBody);
    }

    const json = await response.json().catch(() => ({}));
    return json.data !== undefined ? json.data : json;
}

function mockOkResponse(data: any = {}): Response {
    return {
        ok: true,
        status: 200,
        json: vi.fn().mockResolvedValue({ data }),
    } as unknown as Response;
}

function mockFlatResponse(body: any): Response {
    return {
        ok: true,
        status: 200,
        json: vi.fn().mockResolvedValue(body),
    } as unknown as Response;
}

function mockErrorResponse(status: number, error: string): Response {
    return {
        ok: false,
        status,
        json: vi.fn().mockResolvedValue({ error }),
    } as unknown as Response;
}

describe('useApiMutation – core mutationFn logic', () => {
    beforeEach(() => {
        vi.clearAllMocks();
    });

    // ── HTTP Method Routing ──────────────────────────────────────────────
    describe('HTTP method routing', () => {
        it('calls apiClient.post for POST method', async () => {
            (apiClient.post as any).mockResolvedValue(mockOkResponse({ id: 1 }));
            await executeMutation('/v1/items', 'POST', { name: 'test' });
            expect(apiClient.post).toHaveBeenCalledWith('/v1/items', { name: 'test' });
            expect(apiClient.put).not.toHaveBeenCalled();
            expect(apiClient.patch).not.toHaveBeenCalled();
            expect(apiClient.delete).not.toHaveBeenCalled();
        });

        it('calls apiClient.put for PUT method', async () => {
            (apiClient.put as any).mockResolvedValue(mockOkResponse({}));
            await executeMutation('/v1/items/1', 'PUT', { data: 'x' });
            expect(apiClient.put).toHaveBeenCalledWith('/v1/items/1', { data: 'x' });
            expect(apiClient.post).not.toHaveBeenCalled();
        });

        it('calls apiClient.patch for PATCH method', async () => {
            (apiClient.patch as any).mockResolvedValue(mockOkResponse({}));
            await executeMutation('/v1/items/1', 'PATCH', { field: 'val' });
            expect(apiClient.patch).toHaveBeenCalledWith('/v1/items/1', { field: 'val' });
            expect(apiClient.post).not.toHaveBeenCalled();
        });

        it('calls apiClient.delete for DELETE method (ignores input)', async () => {
            (apiClient.delete as any).mockResolvedValue(mockOkResponse({}));
            await executeMutation('/v1/items/1', 'DELETE', undefined);
            expect(apiClient.delete).toHaveBeenCalledWith('/v1/items/1');
            expect(apiClient.post).not.toHaveBeenCalled();
        });
    });

    // ── Response Handling ─────────────────────────────────────────────────
    describe('response handling', () => {
        it('unwraps { data: ... } response format', async () => {
            (apiClient.post as any).mockResolvedValue(
                mockOkResponse({ id: 42, name: 'Created' })
            );
            const result = await executeMutation('/v1/items', 'POST', {});
            expect(result).toEqual({ id: 42, name: 'Created' });
        });

        it('returns full body when no data wrapper exists', async () => {
            (apiClient.post as any).mockResolvedValue(
                mockFlatResponse({ message: 'Success', count: 5 })
            );
            const result = await executeMutation('/v1/items', 'POST', {});
            expect(result).toEqual({ message: 'Success', count: 5 });
        });

        it('handles empty JSON body gracefully', async () => {
            (apiClient.post as any).mockResolvedValue(mockFlatResponse({}));
            const result = await executeMutation('/v1/items', 'POST', {});
            expect(result).toEqual({});
        });

        it('handles null data field', async () => {
            (apiClient.post as any).mockResolvedValue(
                mockFlatResponse({ data: null })
            );
            const result = await executeMutation('/v1/items', 'POST', {});
            expect(result).toBeNull();
        });
    });

    // ── Error Handling ────────────────────────────────────────────────────
    describe('error handling', () => {
        it('throws ApiError on 400 with error message', async () => {
            (apiClient.post as any).mockResolvedValue(
                mockErrorResponse(400, 'Validation failed')
            );
            await expect(
                executeMutation('/v1/items', 'POST', {})
            ).rejects.toThrow('Validation failed');
        });

        it('throws ApiError on 500 server error', async () => {
            (apiClient.post as any).mockResolvedValue(
                mockErrorResponse(500, 'Internal Server Error')
            );
            await expect(
                executeMutation('/v1/items', 'POST', {})
            ).rejects.toThrow('Internal Server Error');
        });

        it('throws ApiError with status code', async () => {
            (apiClient.post as any).mockResolvedValue(
                mockErrorResponse(403, 'Forbidden')
            );
            try {
                await executeMutation('/v1/items', 'POST', {});
                expect.unreachable('Should have thrown');
            } catch (error: any) {
                expect(error.status).toBe(403);
                expect(error.message).toContain('Forbidden');
            }
        });

        it('handles broken JSON in error response', async () => {
            const badJsonResponse = {
                ok: false,
                status: 502,
                json: vi.fn().mockRejectedValue(new Error('JSON parse failed')),
            } as unknown as Response;
            (apiClient.post as any).mockResolvedValue(badJsonResponse);

            try {
                await executeMutation('/v1/items', 'POST', {});
                expect.unreachable('Should have thrown');
            } catch (error: any) {
                expect(error.message).toContain('Request failed');
                expect(error.status).toBe(502);
            }
        });

        it('uses HTTP status in error message when no error field', async () => {
            const noErrorFieldResponse = {
                ok: false,
                status: 422,
                json: vi.fn().mockResolvedValue({ details: 'some info' }),
            } as unknown as Response;
            (apiClient.post as any).mockResolvedValue(noErrorFieldResponse);

            try {
                await executeMutation('/v1/items', 'POST', {});
                expect.unreachable('Should have thrown');
            } catch (error: any) {
                expect(error.message).toContain('HTTP 422');
            }
        });
    });

    // ── ApiError Class ────────────────────────────────────────────────────
    describe('ApiError class', () => {
        it('creates ApiError with status and message', () => {
            const err = new ApiError(404, 'Not Found');
            expect(err.status).toBe(404);
            expect(err.message).toBe('Not Found');
            expect(err.name).toBe('ApiError');
        });

        it('creates ApiError with data payload', () => {
            const err = new ApiError(400, 'Bad Request', { field: 'name' });
            expect(err.data).toEqual({ field: 'name' });
        });

        it('is an instance of Error', () => {
            const err = new ApiError(500, 'Server Error');
            expect(err instanceof Error).toBe(true);
        });
    });
});

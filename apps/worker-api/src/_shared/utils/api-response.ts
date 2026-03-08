/**
 * API Response Envelope Utility
 * Standardizes all API responses with a consistent shape:
 * { data, meta, error }
 *
 * Usage in route handlers:
 *   return apiResponse.success(c, { users }, { page: 1, total: 50 });
 *   return apiResponse.error(c, 'Not found', 404);
 *   return apiResponse.paginated(c, items, page, limit, total);
 */

import { Context } from 'hono';

interface ApiMeta {
    page?: number;
    limit?: number;
    total?: number;
    totalPages?: number;
    [key: string]: any;
}

export const apiResponse = {
    /**
     * Standard success response
     */
    success<T>(c: Context, data: T, meta?: ApiMeta, status: number = 200) {
        return c.json({
            success: true,
            data,
            meta: meta || null,
            error: null,
        }, status as any);
    },

    /**
     * Standard error response
     */
    error(c: Context, message: string, status: number = 400, details?: any) {
        return c.json({
            success: false,
            data: null,
            meta: null,
            error: { message, ...(details ? { details } : {}) },
        }, status as any);
    },

    /**
     * Paginated list response
     */
    paginated<T>(c: Context, items: T[], page: number, limit: number, total: number) {
        return c.json({
            success: true,
            data: items,
            meta: {
                page,
                limit,
                total,
                totalPages: Math.ceil(total / limit),
                hasNext: page * limit < total,
                hasPrev: page > 1,
            },
            error: null,
        }, 200);
    },

    /**
     * Created response (201)
     */
    created<T>(c: Context, data: T, meta?: ApiMeta) {
        return this.success(c, data, meta, 201);
    },

    /**
     * No content response (204)
     */
    noContent(c: Context) {
        return c.body(null, 204);
    },
};

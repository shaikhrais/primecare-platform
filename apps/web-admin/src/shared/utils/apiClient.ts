const API_URL = import.meta.env.VITE_API_URL || '';

interface RequestOptions extends RequestInit {
    params?: Record<string, string>;
    timeoutMs?: number;  // #11: Request timeout
}

// #23: Typed API error class
export class ApiError extends Error {
    status: number;
    data: any;
    constructor(status: number, message: string, data?: any) {
        super(message);
        this.name = 'ApiError';
        this.status = status;
        this.data = data;
    }
}

export const apiClient = {
    async request(path: string, options: RequestOptions = {}) {
        const { params, timeoutMs = 30000, ...init } = options;
        let url = `${API_URL}${path}`;

        if (params) {
            const searchParams = new URLSearchParams(params);
            url += `?${searchParams.toString()}`;
        }

        const userStr = localStorage.getItem('user');
        const userData = userStr ? JSON.parse(userStr) : null;
        const tenantId = userData?.tenantId;

        // #2: REMOVED URL token handling — use HttpOnly cookies only
        // Tokens in URLs are an XSS injection + browser history leak vector

        const token = localStorage.getItem('token');

        const isFormData = init.body instanceof FormData;
        const defaultOptions: RequestInit = {
            ...init,
            headers: {
                ...(!isFormData ? { 'Content-Type': 'application/json' } : {}),
                ...(token ? { 'Authorization': `Bearer ${token}` } : {}),
                ...(tenantId ? { 'X-Tenant-ID': tenantId } : {}),
                'X-Requested-With': 'XMLHttpRequest',  // #13: CSRF protection header
                ...init.headers,
            },
            credentials: 'include',
        };

        // #11: AbortController for request timeout
        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), timeoutMs);
        defaultOptions.signal = controller.signal;

        // Retry with backoff for cold-start resilience
        let response!: Response;
        let lastError: any;
        for (let attempt = 0; attempt < 3; attempt++) {
            try {
                response = await fetch(url, defaultOptions);
                lastError = null;
                break;
            } catch (err: any) {
                lastError = err;
                if (err.name === 'AbortError') {
                    clearTimeout(timeoutId);
                    throw new ApiError(408, `Request timeout after ${timeoutMs}ms`, { path });
                }
                // Only retry on network errors (cold start crashes), not HTTP errors
                if (attempt < 2) {
                    await new Promise(r => setTimeout(r, 800 * (attempt + 1)));
                }
            }
        }
        clearTimeout(timeoutId);
        if (lastError) throw lastError;

        // Handle Token Refresh (401)
        const { AdminRegistry } = await import('prime-care-shared');
        const { ApiRegistry, RouteRegistry } = AdminRegistry;
        if (response.status === 401 && !path.includes(ApiRegistry.AUTH.REFRESH) && !path.includes(ApiRegistry.AUTH.LOGIN)) {
            try {
                const refreshResponse = await fetch(`${API_URL}${ApiRegistry.AUTH.REFRESH}`, {
                    method: 'POST',
                    credentials: 'include',
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
                });

                if (refreshResponse.ok) {
                    const data = await refreshResponse.json();
                    if (data.token) {
                        localStorage.setItem('token', data.token);
                    }

                    // Retry original request with new token
                    const isFormDataRetry = init.body instanceof FormData;
                    const retryOptions: RequestInit = {
                        ...init,
                        headers: {
                            ...(!isFormDataRetry ? { 'Content-Type': 'application/json' } : {}),
                            ...(data.token ? { 'Authorization': `Bearer ${data.token}` } : {}),
                            'X-Requested-With': 'XMLHttpRequest',
                            ...init.headers,
                        },
                        credentials: 'include' as RequestCredentials,
                    };
                    response = await fetch(url, retryOptions);
                } else {
                    // Refresh failed, cleanup and redirect
                    localStorage.removeItem('user');
                    localStorage.removeItem('token');

                    const isAuthPage = window.location.pathname === RouteRegistry.LOGIN || window.location.pathname === RouteRegistry.REGISTER;
                    if (!isAuthPage) {
                        window.location.href = RouteRegistry.LOGIN;
                    }
                }
            } catch (err) {
                console.error('Refresh re-auth attempt failed');
            }
        }

        // Auto-track API usage (lazy import — zero cost if tracker not loaded)
        import('@/shared/services/UsageTracker').then(m => m.UsageTracker.trackApiCall(path, init.method || 'GET', !response.ok)).catch(() => { });

        return response;
    },

    get(path: string, options?: RequestOptions) {
        return this.request(path, { ...options, method: 'GET' });
    },

    post(path: string, body?: any, options?: RequestOptions) {
        return this.request(path, {
            ...options,
            method: 'POST',
            body: body instanceof FormData ? body : (body ? JSON.stringify(body) : undefined),
        });
    },

    put(path: string, body?: any, options?: RequestOptions) {
        return this.request(path, {
            ...options,
            method: 'PUT',
            body: body instanceof FormData ? body : (body ? JSON.stringify(body) : undefined),
        });
    },

    patch(path: string, body?: any, options?: RequestOptions) {
        return this.request(path, {
            ...options,
            method: 'PATCH',
            body: body instanceof FormData ? body : (body ? JSON.stringify(body) : undefined),
        });
    },

    delete(path: string, options?: RequestOptions) {
        return this.request(path, { ...options, method: 'DELETE' });
    }
};

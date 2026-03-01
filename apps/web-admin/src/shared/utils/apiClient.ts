const API_URL = import.meta.env.VITE_API_URL;

interface RequestOptions extends RequestInit {
    params?: Record<string, string>;
}

export const apiClient = {
    async request(path: string, options: RequestOptions = {}) {
        const { params, ...init } = options;
        let url = `${API_URL}${path}`;

        if (params) {
            const searchParams = new URLSearchParams(params);
            url += `?${searchParams.toString()}`;
        }

        const userStr = localStorage.getItem('user');
        const userData = userStr ? JSON.parse(userStr) : null;
        const tenantId = userData?.tenantId;
        const token = localStorage.getItem('token');

        const isFormData = init.body instanceof FormData;
        const defaultOptions: RequestInit = {
            ...init,
            headers: {
                ...(!isFormData ? { 'Content-Type': 'application/json' } : {}),
                ...(token ? { 'Authorization': `Bearer ${token}` } : {}),
                ...(tenantId ? { 'X-Tenant-ID': tenantId } : {}),
                ...init.headers,
            },
            credentials: 'include',
        };

        let response = await fetch(url, defaultOptions);

        // Handle Token Refresh (401)
        const { AdminRegistry } = await import('prime-care-shared');
        const { ApiRegistry, RouteRegistry } = AdminRegistry;
        if (response.status === 401 && !path.includes(ApiRegistry.AUTH.REFRESH) && !path.includes(ApiRegistry.AUTH.LOGIN)) {
            try {
                // We don't want to import AdminRegistry here to avoid circular dependencies if possible, 
                // but since it's a shared package it should be fine.
                // Ideally ApiRegistry is imported directly.
                const { ApiRegistry } = await import('prime-care-shared');

                // Try refreshing using the HttpOnly refreshToken cookie
                const refreshResponse = await fetch(`${API_URL}${ApiRegistry.AUTH.REFRESH}`, {
                    method: 'POST',
                    credentials: 'include',
                });

                if (refreshResponse.ok) {
                    const data = await refreshResponse.json();
                    if (data.token) {
                        localStorage.setItem('token', data.token);
                    }

                    // Retry original request
                    // The new accessToken cookie (set by the backend) will be included automatically
                    const isFormDataRetry = init.body instanceof FormData;
                    const retryOptions: RequestInit = {
                        ...init,
                        headers: {
                            ...(!isFormDataRetry ? { 'Content-Type': 'application/json' } : {}),
                            ...(data.token ? { 'Authorization': `Bearer ${data.token}` } : {}),
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
                console.error('Refresh re-auth attempt failed', err);
            }
        }

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

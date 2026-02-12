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

        const defaultOptions: RequestInit = {
            ...init,
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json',
                ...init.headers,
            },
        };

        let response = await fetch(url, defaultOptions);

        // Handle Token Refresh (Phase 22 - Refresh Token Rotation)
        if (response.status === 401 && !path.includes('/auth/refresh')) {
            const refreshResponse = await fetch(`${API_URL}/v1/auth/refresh`, {
                method: 'POST',
                credentials: 'include',
            });

            if (refreshResponse.ok) {
                // Retry the original request
                response = await fetch(url, defaultOptions);
            } else {
                // Refresh failed, clear user and redirect to login
                localStorage.removeItem('user');
                window.location.href = '/login';
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
            body: body ? JSON.stringify(body) : undefined,
        });
    },

    put(path: string, body?: any, options?: RequestOptions) {
        return this.request(path, {
            ...options,
            method: 'PUT',
            body: body ? JSON.stringify(body) : undefined,
        });
    },

    patch(path: string, body?: any, options?: RequestOptions) {
        return this.request(path, {
            ...options,
            method: 'PATCH',
            body: body ? JSON.stringify(body) : undefined,
        });
    },

    delete(path: string, options?: RequestOptions) {
        return this.request(path, { ...options, method: 'DELETE' });
    }
};

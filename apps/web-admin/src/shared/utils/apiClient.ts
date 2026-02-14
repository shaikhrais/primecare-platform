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

        const token = localStorage.getItem('token');
        const defaultOptions: RequestInit = {
            ...init,
            headers: {
                'Content-Type': 'application/json',
                ...(token ? { 'Authorization': `Bearer ${token}` } : {}),
                ...init.headers,
            },
            credentials: 'include',
        };

        let response = await fetch(url, defaultOptions);

        // Handle Token Refresh
        if (response.status === 401 && !path.includes('/auth/refresh') && !path.includes('/auth/login')) {
            try {
                const refreshResponse = await fetch(`${API_URL}/v1/auth/refresh`, {
                    method: 'POST',
                    credentials: 'include',
                });

                if (refreshResponse.ok) {
                    const data = await refreshResponse.json();
                    localStorage.setItem('token', data.token);

                    // Retry original request with new token
                    const retryOptions = {
                        ...defaultOptions,
                        headers: {
                            ...defaultOptions.headers,
                            'Authorization': `Bearer ${data.token}`,
                        }
                    };
                    response = await fetch(url, retryOptions);
                } else {
                    // Refresh failed, logout
                    localStorage.removeItem('user');
                    localStorage.removeItem('token');

                    // Only redirect if not already on /login to prevent infinite boot loops
                    if (window.location.pathname !== '/login') {
                        window.location.href = '/login';
                    }
                }
            } catch (err) {
                console.error('Refresh token failed', err);
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

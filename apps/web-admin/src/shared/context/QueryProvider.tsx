/**
 * QueryProvider — TanStack React Query setup for PrimeCare
 *
 * Provides centralized caching, stale-while-revalidate, automatic refetching,
 * and query deduplication. Wraps the entire app at the top level.
 */
import React from 'react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { useUIStore } from '@/shared/stores';

const queryClient = new QueryClient({
    defaultOptions: {
        queries: {
            staleTime: 30_000,
            gcTime: 5 * 60_000,
            retry: (failureCount, error) => {
                // Don't retry 4xx errors (client errors)
                if (error && typeof error === 'object' && 'status' in error) {
                    const status = (error as { status: number }).status;
                    if (status >= 400 && status < 500) return false;
                }
                return failureCount < 2;
            },
            retryDelay: (attempt) => Math.min(1000 * 2 ** attempt, 10_000),
            refetchOnWindowFocus: false,
            refetchOnReconnect: true,
        },
        mutations: {
            retry: false,
            onError: (error) => {
                // Global mutation error → toast notification
                const message = error instanceof Error ? error.message : 'An unexpected error occurred';
                try {
                    useUIStore.getState().addToast({ type: 'error', title: 'Operation Failed', message });
                } catch { /* Store not available */ }
            },
        },
    },
});

// Export for use in hooks
export { queryClient };

interface QueryProviderProps {
    children: React.ReactNode;
}

export const QueryProvider: React.FC<QueryProviderProps> = ({ children }) => {
    return (
        <QueryClientProvider client={queryClient}>
            {children}
        </QueryClientProvider>
    );
};

export default QueryProvider;

/**
 * QueryProvider — TanStack React Query setup for PrimeCare
 *
 * Provides centralized caching, stale-while-revalidate, automatic refetching,
 * and query deduplication. Wraps the entire app at the top level.
 */
import React from 'react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

const queryClient = new QueryClient({
    defaultOptions: {
        queries: {
            staleTime: 30_000,       // Data is fresh for 30s (matches old CACHE_TTL)
            gcTime: 5 * 60_000,      // Garbage collect after 5 min
            retry: 2,                // Retry failed queries twice
            retryDelay: (attempt) => Math.min(800 * (attempt + 1), 5000),
            refetchOnWindowFocus: false,  // Don't auto-refetch on tab focus
            refetchOnReconnect: true,     // Refetch when coming back online
        },
        mutations: {
            retry: 0,                // Don't retry mutations
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

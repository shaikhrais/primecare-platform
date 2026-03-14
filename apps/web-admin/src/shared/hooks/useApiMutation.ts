/**
 * useApiMutation — TanStack Mutation hook with auto-invalidation
 *
 * Wraps apiClient for POST/PUT/PATCH/DELETE with:
 * - Automatic query cache invalidation on success
 * - Optimistic updates support
 * - Loading/error state management
 *
 * Usage:
 *   const createUser = useApiMutation<UserInput, User>('/v1/admin/users', {
 *       method: 'POST',
 *       invalidateKeys: [['admin', 'users']],
 *       onSuccess: (user) => showToast(`Created ${user.name}`),
 *   });
 *
 *   // In a form handler:
 *   createUser.mutate({ name: 'Jane', email: 'jane@...' });
 */
import { useMutation, useQueryClient, UseMutationOptions } from '@tanstack/react-query';
import { apiClient, ApiError } from '@/shared/utils/apiClient';

interface ApiMutationOptions<TInput, TResponse>
    extends Omit<UseMutationOptions<TResponse, ApiError, TInput>, 'mutationFn'> {
    /** HTTP method (defaults to POST) */
    method?: 'POST' | 'PUT' | 'PATCH' | 'DELETE';
    /** Query keys to invalidate on success */
    invalidateKeys?: string[][];
}

export function useApiMutation<TInput = any, TResponse = any>(
    path: string,
    options?: ApiMutationOptions<TInput, TResponse>
) {
    const queryClient = useQueryClient();
    const { method = 'POST', invalidateKeys, ...mutationOptions } = options || {};

    return useMutation<TResponse, ApiError, TInput>({
        mutationFn: async (input: TInput): Promise<TResponse> => {
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
        },
        onSuccess: (...args) => {
            // Auto-invalidate related queries
            if (invalidateKeys) {
                invalidateKeys.forEach(key => {
                    queryClient.invalidateQueries({ queryKey: key });
                });
            }
            // Call user's onSuccess if provided
            mutationOptions.onSuccess?.(...args);
        },
        ...mutationOptions,
    });
}

export default useApiMutation;

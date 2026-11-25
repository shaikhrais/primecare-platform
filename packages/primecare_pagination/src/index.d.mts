export interface PaginationInput {
  readonly page: number;
  readonly pageSize: number;
  readonly totalItems: number;
}
export interface PaginationState extends PaginationInput {
  readonly totalPages: number;
  readonly firstItem: number;
  readonly lastItem: number;
  readonly hasPrevious: boolean;
  readonly hasNext: boolean;
}
export function paginationState(input: PaginationInput): Readonly<PaginationState>;
export function movePagination(input: PaginationInput, direction: 'previous' | 'next'): Readonly<PaginationState>;

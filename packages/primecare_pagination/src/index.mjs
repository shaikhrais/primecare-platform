/** Pure view model for Fuse-inspired paging controls; this does not fetch records. */
export function paginationState({page, pageSize, totalItems}) {
  if (![page, pageSize, totalItems].every(Number.isSafeInteger) ||
      page < 1 || pageSize < 1 || totalItems < 0) {
    throw new RangeError('Invalid pagination input');
  }
  const totalPages = Math.ceil(totalItems / pageSize);
  const currentPage = Math.min(page, Math.max(totalPages, 1));
  const offset = (currentPage - 1) * pageSize;
  return Object.freeze({
    page: currentPage, pageSize, totalItems, totalPages,
    firstItem: totalItems === 0 ? 0 : offset + 1,
    lastItem: offset + Math.min(pageSize, totalItems - offset),
    hasPrevious: currentPage > 1, hasNext: currentPage < totalPages,
  });
}

/** Pure navigation. A host may use the next state to render controls. */
export function movePagination(state, direction) {
  if (direction !== 'previous' && direction !== 'next') {
    throw new RangeError('Invalid pagination direction');
  }
  const current = paginationState(state);
  const page = direction === 'previous'
    ? Math.max(1, current.page - 1)
    : current.hasNext ? current.page + 1 : current.page;
  return paginationState({...current, page});
}

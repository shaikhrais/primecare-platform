/// Existing declared operations inspected by production discovery 43535550518.
/// A failure boundary only: this does not bind handlers or authorize a request.
const _applicationWorkflowPaths = {
  '/v1/admin/erp/purchase-orders', // API 104
  '/v1/user/training/catalog', // API 279
  '/v1/user/training/my-progress', // API 280
  '/v1/ai/insights', // API 308; analytics, not authority for AI chat
  '/v1/ai/predictive', // API 309
  '/v1/ai/churn', // API 310
  '/v1/support/chat', // API 408; support membership remains undefined
  '/v1/psw/help-support', // API 794
  '/v1/premium/transactionledger', // API 1122; not general finance authority
};

bool isApplicationWorkflowPath(String path) {
  final uri = Uri.tryParse(path);
  if (uri == null) return false;
  // Resolve relative and absolute forms consistently, without performing I/O.
  final route = Uri.parse('https://api.invalid/').resolveUri(uri)
      .normalizePath().path.replaceFirst(RegExp(r'/+$'), '');
  return _applicationWorkflowPaths.contains(route);
}

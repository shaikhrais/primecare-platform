# Error Handling Definitions Report

- **Registered Error Specifications**: 3

| ID | Error Code | Error Message | Severity | User-Facing Message | Recovery Action |
|---|---|---|---|---|---|
| 1 | `ERR-401` | Unauthorized access | medium | Your session expired. Please log in again. | `re_authenticate` |
| 2 | `ERR-403` | Permission forbidden | high | You do not have permission to perform this action. | `show_alert` |
| 3 | `ERR-500` | Server failure | critical | A server error occurred. Please try again. | `retry_request` |
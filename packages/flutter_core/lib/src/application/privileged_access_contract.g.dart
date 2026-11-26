// Generated from registered elevation contracts; do not edit.
const temporaryAccessMaximumSeconds = 900;
const temporaryAccessAction = "tenant_security_summary";
const privilegedAccessEndpoints = <String, String>{
  "elevate": "/v1/auth/mfa/elevation",
  "revokeElevation": "/v1/auth/mfa/elevation/revoke",
  "requestSupport": "/v1/auth/mfa/support/request",
  "listSupport": "/v1/auth/mfa/support/requests",
  "approveSupport": "/v1/auth/mfa/support/approve",
  "revokeSupport": "/v1/auth/mfa/support/revoke",
  "summary": "/v1/auth/mfa/support/summary",
};

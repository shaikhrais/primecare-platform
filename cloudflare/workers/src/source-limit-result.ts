/** Provider results are untrusted at runtime, even with a typed binding.
 * Only an explicit boolean may allow or deny a request. Malformed results
 * throw into the handler's existing sanitized, no-store unavailable response.
 */
export function sourceLimitAllowed(result:unknown):boolean {
  if(!result || typeof result!=='object' || Array.isArray(result) ||
      typeof (result as {success?:unknown}).success!=='boolean') {
    throw new Error('Invalid source limiter result');
  }
  return (result as {success:boolean}).success;
}

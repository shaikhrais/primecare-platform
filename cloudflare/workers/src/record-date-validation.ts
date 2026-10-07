import {accountTimestamp} from './account-read-projection';
/** Existing read contracts require finite RFC3339 date-times. JavaScript's
 * permissive Date parser alone also accepts normalized calendar errors,
 * date-only strings and extended-year Date values that violate those contracts.
 */
export function validRecordTimestamp(value:unknown):boolean {
  try {accountTimestamp(value);return true;}catch {return false;}
}

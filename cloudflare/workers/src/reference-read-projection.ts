import {accountId} from './account-read-projection';
/** Project existing reference fields as usable UUID/text identifiers, without coercion. */
export function projectReferenceId(value:unknown,nullable=false):string|null {
 if(nullable&&value===null)return null;
 return accountId(value);
}

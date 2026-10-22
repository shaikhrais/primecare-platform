import {validateFlutterMfaReceipt} from './validate-flutter-mfa-receipt.mjs';
export const requiredAuthLifecycleChecks = [
  "ten unique saved recovery codes returned once",
  "saved codes persist only as unused context-bound hashes",
  "reload cannot redisplay saved codes",
  "replacement starts with limited challenge",
  "cancel retains working factor and current server session",
  "cancel removes replacement setup key",
  "fresh replacement abandons the previous pending factor",
  "abandoned replacement cannot grant authority",
  "new authenticator confirmation replaces factor",
  "replacement revokes old session and confirms new owned identity",
  "replacement leaves one hashed session and invalidates previous saved codes",
  "replacement reload retains authority without setup key",
  "owned session revoked before lost-factor recovery",
  "lost-factor recovery begins with password-verified limited challenge",
  "saved code grants only a new-factor challenge",
  "saved-code proof grants no browser or database session",
  "saved recovery code is atomically consumed once",
  "consumed password and saved-code proof cannot be replayed",
  "wrong recovered authenticator code grants no authority",
  "wrong new-factor proof creates no server session",
  "lost-factor recovery requires confirmation of new authenticator",
  "recovered browser authority matches owned hashed server session",
  "confirmed recovery invalidates all saved codes and replacement challenges",
  "five lifecycle security notices durably queued or acknowledged",
  "recovery reload preserves session without exposing setup key",
  "management response never grants session authority",
  "lifecycle proof material is not persisted",
  "fresh factor creates only scoped temporary elevation",
  "support request requires explicit target approval",
  "unapproved support reveals no aggregate",
  "target tenant administrator signs in through deployed Flutter",
  "tenant refresh lists only the exact scoped pending request",
  "wrong approval password denies grant while preserving valid administrator session",
  "fresh tenant password explicitly approves support",
  "approved support returns only exact synthetic tenant security counts",
  "localized aggregate values render in Flutter semantics",
  "support read has committed actor and target audit",
  "temporary elevation is hashed-session bound and at most fifteen minutes",
  "support never changes active actor role",
  "tenant administrator can revoke approved support",
  "revoked support cannot reveal a later aggregate",
  "requester explicitly ends temporary elevation",
  "ended elevation has no remaining support authority",
  "reload retains account session without temporary support state",
  "synthetic tenant administrator session is revoked",
  "temporary tenant support fixtures removed",
  "support cleanup exact fixture identity guard",
  "fresh owned proof accepted for recovery-codes",
  "fresh owned proof accepted for replacement"
];

export function validateAuthLifecycleReceipt(receipt,source){
 const result=validateFlutterMfaReceipt(receipt,source);
 for(const locale of receipt.results){
  if(!requiredAuthLifecycleChecks.every(check=>locale.checks.includes(check)))throw Error('Complete recovery and approved support proof required');
  for(const check of ['fresh owned proof accepted for recovery-codes','fresh owned proof accepted for replacement']){
   if(locale.checks.filter(value=>value===check).length!==2)throw Error('Both saved-code generations and both replacement initiations required');
  }
 }
 return {...result,apiCount:11,securityNotices:'durably-queued-or-transport-acknowledged',inboxDeliveryVerified:false,physicalDevicesVerified:false};
}

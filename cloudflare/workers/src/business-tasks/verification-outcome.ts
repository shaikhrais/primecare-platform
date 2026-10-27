/** Expected eligibility denials are successful tool receipts, not outages.
 * A missing verified phone does not establish that an account does not exist.
 * Only the canonical provider/account lookup may select this outcome.
 */
export function verificationFailure(reason:string,error:unknown,clientRead=false){
 const contactFailure=(error as Error)?.message==='Verified account contact required';
 if(!clientRead&&contactFailure&&reason==='no_verified_account_phone')return {
  auditReason:reason,
  result:{verified:false,codeRequested:false,status:'account_phone_not_verified',nextStep:'verify_account_phone_or_register_with_reception',businessActionApproved:false},
 };
 if(!clientRead&&contactFailure&&reason==='ambiguous_verified_account_phone')return {
  auditReason:reason,result:{verified:false,codeRequested:false,status:'account_selection_required',nextStep:'contact_reception',businessActionApproved:false},
 };
 const auditReason=contactFailure?reason:'verification_backend_failed';
 return {auditReason,error:clientRead?'Client information unavailable. Current account verification is required; no records were changed.':'Call verification could not be completed. Do not resend automatically; contact reception.'};
}

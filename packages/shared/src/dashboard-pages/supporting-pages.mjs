/** Supporting presentation only. No invented auth/payment/navigation behavior. */
export const supportingPageKinds=Object.freeze(['invoice','pricing','authentication','coming-soon','maintenance','error']);
export function supportingPageStatus(kind){
 if(!supportingPageKinds.includes(kind))throw Error('invalid_page');
 return ['coming-soon','maintenance','error'].includes(kind)?'static-'+kind:'unavailable';
}

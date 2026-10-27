/** Input formatting only; never establishes account ownership or verification.
 * Canadian/US national numbers default to +1. Other countries must supply an
 * explicit canonical E.164 number. Extensions and ambiguous strings are denied.
 */
export function normalizePhoneNumber(value){
 if(typeof value!=='string'||value.length>64||/[\u0000-\u001f\u007f]/.test(value))throw Error('Invalid phone number');
 const input=value.trim();
 if(/^\+[1-9][0-9]{6,14}$/.test(input))return input;
 if(!/^(?:\+?1[ .-]?)?(?:\([2-9][0-9]{2}\)|[2-9][0-9]{2})[ .-]?[2-9][0-9]{2}[ .-]?[0-9]{4}$/.test(input))throw Error('Invalid phone number');
 const digits=input.replace(/[()+ .-]/g,'');
 return digits.length===10?'+1'+digits:'+'+digits;
}

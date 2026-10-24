/** Authenticates only the configured provider service, never the caller. */
export function createVapiToolCredentialVerifier(options:{secret:string}):(request:Request)=>Promise<boolean>;

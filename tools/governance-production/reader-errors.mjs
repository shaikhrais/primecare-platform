/** Stable diagnostics only. Never return provider messages, SQL, URLs or credentials. */
const faults=new Set(['MISSING_DATABASE_URL','INVALID_DATABASE_URL','CONFLICTING_DATABASE_URLS','UNEXPECTED_DATABASE_TARGET','MANIFEST_MISMATCH','FIXTURE_NOT_AUTHORIZED','UNSUPPORTED_READER_OPERATION']);
const network=new Set(['ECONNREFUSED','ECONNRESET','ENOTFOUND','EAI_AGAIN','ETIMEDOUT','ERR_TLS_CERT_ALTNAME_INVALID','CERT_HAS_EXPIRED','UNABLE_TO_VERIFY_LEAF_SIGNATURE','DEPTH_ZERO_SELF_SIGNED_CERT']);
const postgres=new Set(['08000','08001','08003','08004','08006','08007','08P01','28000','28P01','3D000','42501','42P01','42703','53300','53400','57014','57P01','57P02','57P03','40001','40P01','25006','23505','23503','22P02']);
export class GovernanceReaderFault extends Error {
 constructor(code){if(!faults.has(code))throw Error('Invalid reader fault');super('Governance reader unavailable');this.code=code;}
}
export function safeReaderErrorCode(error){
 if(error instanceof GovernanceReaderFault)return error.code;
 // Prisma's PostgreSQL gateway can use generic code "error" for an account
 // restriction. Extract this known marker without exposing the rest of its text.
 if(typeof error?.message==='string'&&/\bplanLimitReached\b/.test(error.message.slice(0,8192)))return 'planLimitReached';
 if(typeof error?.code==='string'&&(network.has(error.code)||postgres.has(error.code)))return error.code;
 return 'unavailable';
}

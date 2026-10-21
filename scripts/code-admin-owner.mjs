import {createHash} from 'node:crypto';
import {readFileSync} from 'node:fs';
export const owner=JSON.parse(readFileSync(new URL('../tools/governance-production/code-admin-owner.json',import.meta.url),'utf8'));
export function validateCodeAdminOwner(value){
 const email=String(value??'').trim().toLowerCase();
 if(createHash('sha256').update(email).digest('hex')!==owner.emailSha256)throw Error('Configured Code Admin email differs from the approved owner');
 return email;
}
/** The registered owner is pending setup. Secrets alone cannot activate it. */
export function requireCodeAdminActivationReady(){
 if(owner.verificationStatus!=='activation-approved-with-mfa')throw Error('Code Admin activation remains disabled pending verified MFA setup');
}
export async function verifyCodeAdminOwnerRegistration(db){
 const pin=JSON.parse(readFileSync(new URL('../tools/governance-production/production-pin.json',import.meta.url),'utf8'));
 const schema='"'+pin.schema.replaceAll('"','""')+'"';
 const manifest=await db.query('SELECT manifest_sha256 FROM '+schema+'.govt_source_manifest');
 if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance authority mismatch');
 const binding=await db.query('SELECT definition FROM '+schema+'.govt_platform_hierarchy_policy WHERE id=$1',[owner.id]);
 if(binding.rows.length!==1)throw Error('Approved Code Admin owner is not registered');
 const registered=JSON.parse(binding.rows[0].definition);
 if(Object.keys(registered).length!==Object.keys(owner).length||Object.keys(owner).some(k=>registered[k]!==owner[k]))throw Error('Approved Code Admin owner binding differs');
}

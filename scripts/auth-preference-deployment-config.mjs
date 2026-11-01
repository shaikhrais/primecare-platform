import {preservedServiceConfig} from './preserved-service-config.mjs';
/** A code-only auth update: keep current key selection and cron schedules; preferences stay off. */
export function authPreferenceDeploymentConfig(settings,scheduleResult,{sourceFingerprint,activeKeyId,rotationFromKeyId}){
 const config=preservedServiceConfig(settings,'auth');
 if(!['DB_URL','MFA_ENCRYPTION_KEY','MFA_ENCRYPTION_KEY_V2'].every(name=>settings.bindings.some(b=>b.name===name&&b.type==='secret_text')))throw Error('Existing auth key bindings required');
 if(config.vars.PREFERENCE_SYNC_ENABLED==='1')throw Error('Preference runtime activation is outside this code-only release');
 if(!/^[a-f0-9]{64}$/.test(sourceFingerprint??'')||!['mfa-v1','mfa-v2'].includes(activeKeyId)||config.vars.MFA_ACTIVE_KEY_ID!==activeKeyId||(config.vars.MFA_ROTATION_FROM_KEY_ID??null)!==rotationFromKeyId)throw Error('Existing key-selection policy must match the tested source');
 if(!Array.isArray(scheduleResult?.schedules)||scheduleResult.schedules.length>20||scheduleResult.schedules.some(s=>typeof s.cron!=='string'||!s.cron.trim()||s.cron.length>100)||new Set(scheduleResult.schedules.map(s=>s.cron)).size!==scheduleResult.schedules.length)throw Error('Exact existing schedules required');
 config.triggers={crons:scheduleResult.schedules.map(s=>s.cron).sort()};
 config.vars.MFA_KEYRING_SOURCE_SHA256=sourceFingerprint;
 config.vars.PREFERENCE_SYNC_ENABLED='0';
 return config;
}

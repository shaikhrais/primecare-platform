// Candidate SQL, not mounted runtime code or production migration authority.
// Run quota on a dedicated autocommit connection BEFORE reader BEGIN.
export const reserveRead=`INSERT INTO public.help_reader_rate(tenant_id,user_id,attempts,reset_at)
 VALUES($1,$2,1,statement_timestamp()+interval '60 seconds')
 ON CONFLICT(tenant_id,user_id) DO UPDATE SET
 attempts=CASE WHEN help_reader_rate.reset_at<=statement_timestamp() THEN 1 ELSE LEAST(help_reader_rate.attempts+1,31) END,
 reset_at=CASE WHEN help_reader_rate.reset_at<=statement_timestamp() THEN statement_timestamp()+interval '60 seconds' ELSE help_reader_rate.reset_at END
 RETURNING attempts<=30 AS allowed,CASE WHEN attempts<=30 THEN 0 ELSE GREATEST(1,LEAST(60,CEIL(EXTRACT(EPOCH FROM reset_at-statement_timestamp()))::integer)) END AS retry_after_seconds`;
export const appendAudit=`INSERT INTO public.help_reader_audit(tenant_id,user_id,action,locale,returned) VALUES($1,$2,$3,$4,$5) RETURNING id,created_at,expires_at`;
// A dedicated scheduled worker must invoke this even when Help receives no traffic.
export const purgeAudit=`DELETE FROM public.help_reader_audit WHERE expires_at<=statement_timestamp() RETURNING id`;

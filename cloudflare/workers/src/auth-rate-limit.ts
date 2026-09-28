import type {Client} from 'pg';
import configuration from './auth-security-policy.json';

/** Atomic PostgreSQL counter shared across Worker instances; raw emails are never stored. */
export async function loginRateLimit(db: Client, subjectHash: string): Promise<number | null> {
  const {maxAttempts,windowSeconds}=configuration.login;
  const result=await db.query(`INSERT INTO auth_rate_limits(subject_hash,attempts,reset_at)
    VALUES($1,1,NOW()+($2 * INTERVAL '1 second'))
    ON CONFLICT(subject_hash) DO UPDATE SET
      attempts=CASE WHEN auth_rate_limits.reset_at<=NOW() THEN 1
        ELSE LEAST(auth_rate_limits.attempts+1,$3+1) END,
      reset_at=CASE WHEN auth_rate_limits.reset_at<=NOW() THEN NOW()+($2 * INTERVAL '1 second')
        ELSE auth_rate_limits.reset_at END
    RETURNING attempts,GREATEST(1,CEIL(EXTRACT(EPOCH FROM reset_at-NOW())))::int AS retry_after`,
    [subjectHash,windowSeconds,maxAttempts]);
  return Number(result.rows[0].attempts)>maxAttempts ? Number(result.rows[0].retry_after) : null;
}

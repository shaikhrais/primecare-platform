/** Durable at-least-once security notices. Never put proof material in this queue. */
export async function deliverMfaNotifications(db, send, limit = 10) {
  if (typeof send !== 'function' || !Number.isInteger(limit) || limit < 1 || limit > 10) throw Error('Invalid MFA notification processor');
  const lease = crypto.randomUUID();
  const claimed = await db.query(`WITH due AS (
    SELECT id FROM auth_mfa_notification_outbox WHERE
      (state='pending' AND available_at<=NOW()) OR (state='sending' AND lease_until<NOW())
    ORDER BY created_at,id FOR UPDATE SKIP LOCKED LIMIT $1)
    UPDATE auth_mfa_notification_outbox n SET state='sending',lease_token=$2,
      lease_until=NOW()+INTERVAL '2 minutes',attempts=LEAST(n.attempts,999999)+1
    FROM due WHERE n.id=due.id RETURNING n.id,n.recipient,n.event,n.locale,n.lease_token`, [limit,lease]);
  if (!Array.isArray(claimed.rows) || claimed.rows.length > limit) throw Error('Invalid MFA notification claim');
  const report = {claimed: claimed.rows.length, sent: 0, deferred: 0, superseded: 0};
  await Promise.all(claimed.rows.map(async notice => {
    let accepted = false;
    if (typeof notice.recipient === 'string' && notice.recipient.length <= 254 && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(notice.recipient) &&
        ['recovery_codes_issued','authenticator_recovery_started','authenticator_replaced'].includes(notice.event) &&
        ['en','fr','es'].includes(notice.locale) && notice.lease_token === lease) {
      let deadline;
      try {
        const acknowledgement = await Promise.race([
          send({id: notice.id, recipient: notice.recipient, event: notice.event, locale: notice.locale}),
          new Promise((_, reject) => {deadline = setTimeout(() => reject(Error('Notification transport timeout')), 30000);}),
        ]);
        accepted = typeof acknowledgement === 'string' && acknowledgement.trim() === acknowledgement &&
          acknowledgement.length > 0 && acknowledgement.length <= 500 && !/[\u0000-\u001f\u007f]/.test(acknowledgement);
      } catch { /* Keep a retryable durable record after transport failure. */ }
      finally {clearTimeout(deadline);}
    }
    const updated = accepted
      ? await db.query("UPDATE auth_mfa_notification_outbox SET state='sent',sent_at=NOW(),lease_until=NULL,lease_token=NULL WHERE id=$1 AND state='sending' AND lease_token=$2 RETURNING id", [notice.id,lease])
      : await db.query("UPDATE auth_mfa_notification_outbox SET state='pending',available_at=NOW()+LEAST(900,5*POWER(2,LEAST(attempts,8)))*INTERVAL '1 second',lease_until=NULL,lease_token=NULL WHERE id=$1 AND state='sending' AND lease_token=$2 RETURNING id", [notice.id,lease]);
    if (!Array.isArray(updated.rows) || updated.rows.length > 1) throw Error('Invalid MFA notification update');
    if (!updated.rows.length) report.superseded++;
    else if (accepted) report.sent++;
    else report.deferred++;
  }));
  return report;
}

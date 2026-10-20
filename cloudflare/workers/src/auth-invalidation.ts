import type {Client} from 'pg';
import {requiredRow} from './database-results';

/** Caller owns the transaction and the user lock. Never acknowledge partial invalidation. */
async function invalidate(db:Client,id:string,remove:string,verify:string) {
 await db.query(remove,[id]);
 if(requiredRow((await db.query(verify,[id])).rows).remaining!==false)
  throw Error('Authentication invalidation incomplete');
}
export const invalidateSessions=(db:Client,id:string)=>invalidate(db,id,
 'DELETE FROM auth_sessions WHERE user_id=$1',
 'SELECT EXISTS(SELECT 1 FROM auth_sessions WHERE user_id=$1) AS remaining');
export const invalidatePasswordResets=(db:Client,id:string)=>invalidate(db,id,
 'DELETE FROM auth_password_resets WHERE user_id=$1',
 'SELECT EXISTS(SELECT 1 FROM auth_password_resets WHERE user_id=$1) AS remaining');

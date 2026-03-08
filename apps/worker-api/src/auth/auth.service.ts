import { sign } from 'hono/jwt';
import { Role } from '../../generated/client/edge';

/**
 * R8: Hardened token generation with proper JWT claims.
 * - Added `iat` (issued at) for token age verification
 * - Added `iss` (issuer) for token origin validation
 * - Added `aud` (audience) for token scope binding
 * - Removed unused hashPassword import
 */

export const generateToken = async (
    user: { id: string; roles: Role[]; tenantId: string },
    secret: string,
    options: { activeRole?: Role, expiresInMinutes?: number, type?: string } = {}
) => {
    const { activeRole, expiresInMinutes = 60, type } = options;
    const now = Math.floor(Date.now() / 1000);

    const payload: any = {
        sub: user.id,
        roles: user.roles,
        activeRole: activeRole || user.roles[0],
        tenantId: user.tenantId,
        iat: now,                           // R8: When token was issued
        exp: now + (expiresInMinutes * 60),
        iss: 'primecare-api',               // R8: Issuer claim
        aud: 'primecare-web',               // R8: Audience claim
    };
    if (type) payload.type = type;

    return await sign(payload, secret);
};

/**
 * R8: Refresh tokens now include `type: 'refresh'` claim
 * to prevent refresh tokens from being used as access tokens.
 */
export const generateRefreshToken = async (userId: string, secret: string) => {
    const now = Math.floor(Date.now() / 1000);
    const payload = {
        sub: userId,
        type: 'refresh',                    // R8: Distinguishes from access tokens
        iat: now,
        exp: now + 60 * 60 * 24 * 7,        // 7 days
        iss: 'primecare-api',
        aud: 'primecare-web',
    };
    return await sign(payload, secret);
};

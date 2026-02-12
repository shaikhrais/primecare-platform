import { sign } from 'hono/jwt';
import { Role } from '../../generated/client/edge';

/**
 * Basic SHA-256 hashing.
 * Note: For production, consider using a more robust algorithm like Argon2 if supported by the environment.
 */
export async function hashPassword(password: string) {
    const msgUint8 = new TextEncoder().encode(password);
    const hashBuffer = await crypto.subtle.digest('SHA-256', msgUint8);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

export const generateToken = async (user: { id: string; roles: Role[]; tenantId: string }, secret: string, activeRole?: Role, expiresInMinutes: number = 60) => {
    const payload = {
        sub: user.id,
        roles: user.roles,
        activeRole: activeRole || user.roles[0],
        tenantId: user.tenantId,
        exp: Math.floor(Date.now() / 1000) + (expiresInMinutes * 60),
    };
    return await sign(payload, secret);
};

export const generateRefreshToken = async (userId: string, secret: string) => {
    const payload = {
        sub: userId,
        exp: Math.floor(Date.now() / 1000) + 60 * 60 * 24 * 7, // 7 days
    };
    return await sign(payload, secret);
};

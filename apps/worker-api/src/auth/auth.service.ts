import { sign } from 'hono/jwt';
import { Role } from '../../generated/client/edge';
import { hashPassword } from '../_shared/utils/crypto';

/**
 * Basic SHA-256 hashing.
 */
// Removed local hashPassword and using shared crypto utility

export const generateToken = async (user: { id: string; roles: Role[]; tenantId: string }, secret: string, options: { activeRole?: Role, expiresInMinutes?: number, type?: string } = {}) => {
    const { activeRole, expiresInMinutes = 60, type } = options;
    const payload: any = {
        sub: user.id,
        roles: user.roles,
        activeRole: activeRole || user.roles[0],
        tenantId: user.tenantId,
        exp: Math.floor(Date.now() / 1000) + (expiresInMinutes * 60),
    };
    if (type) payload.type = type;
    return await sign(payload, secret);
};

export const generateRefreshToken = async (userId: string, secret: string) => {
    const payload = {
        sub: userId,
        exp: Math.floor(Date.now() / 1000) + 60 * 60 * 24 * 7, // 7 days
    };
    return await sign(payload, secret);
};

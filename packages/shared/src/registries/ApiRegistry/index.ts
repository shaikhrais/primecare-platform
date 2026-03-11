import { TENANCY } from './tenancy';
import { PLATFORM } from './platform';

export const ApiRegistry = {
    AUTH: {
        LOGIN: '/v1/auth/login',
        REGISTER: '/v1/auth/register',
        FORGOT_PASSWORD: '/v1/auth/forgot-password',
        RESET_PASSWORD: '/v1/auth/reset-password',
        LOGOUT: '/v1/auth/logout',
        SWITCH_ROLE: '/v1/auth/switch-role',
        REFRESH: '/v1/auth/refresh',
        IMPERSONATE: '/v1/auth/impersonate',
    },
    USER: {
        PROFILE: '/v1/user/profile',
        MESSAGING_THREADS: '/v1/user/messaging/threads',
        MESSAGING_SEND: (threadId: string) => `/v1/user/messaging/threads/${threadId}/messages`,
        TRAINING_CATALOG: '/v1/user/training/catalog',
        TRAINING_PROGRESS: '/v1/user/training/my-progress',
    },
    PLATFORM,
    ...PLATFORM,
    TENANCY,

    // Legacy mapping
    MANAGER: TENANCY.MANAGER,
    CLIENT: TENANCY.CLIENT,
    PSW: TENANCY.PSW,
    RN: TENANCY.RN,
    STAFF: TENANCY.STAFF,
    COORDINATOR: TENANCY.COORDINATOR,
    SYSTEM: PLATFORM.SYSTEM,

    PUBLIC: {
        LEADS: '/v1/public/leads',
        SERVICES: '/v1/public/services',
        BLOG: '/v1/public/blog',
    },
    SUPPORT: {
        CHAT_HISTORY: '/v1/support/chat',
        TICKETS: '/v1/support/tickets',
    }
} as const;
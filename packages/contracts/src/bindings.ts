// Governance - Category: model | Purpose: <reference types="@cloudflare/workers-types" />
/// <reference types="@cloudflare/workers-types" />
export type Bindings = {
    DATABASE_URL: string;
    PRISMA_DATABASE_URL?: string;
    JWT_SECRET: string;
    DOCS_BUCKET: R2Bucket;
    STRIPE_SECRET_KEY: string;
    SENTRY_DSN?: string;
    SITE_URL?: string;
    CHAT_SERVER: DurableObjectNamespace;
    REALTIME_SYNC: DurableObjectNamespace;
    ENVIRONMENT?: string;
    API_VERSION?: string;
    OSM_CLIENT_ID?: string;
    OSM_CLIENT_SECRET?: string;
    OSM_REDIRECT_URI?: string;
    INTERNAL_API_KEY?: string;
};

export type Variables = {
    jwtPayload: {
        sub: string;
        email: string;
        roles: string[];
        activeRole: string;
        tenantId: string;
    };
    user: {
        id: string;
        role: string;
    };
    prisma: any;
    can: (action: string, resource: string, resourceId?: string) => Promise<boolean>;
    deviceId?: string | null;
    tenantId?: string;
    requestId?: string;
};

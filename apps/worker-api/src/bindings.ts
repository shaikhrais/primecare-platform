export type Bindings = {
    DATABASE_URL: string;
    JWT_SECRET: string;
    DOCS_BUCKET: R2Bucket;
    STRIPE_SECRET_KEY: string;
    SITE_URL?: string;
    CHAT_SERVER: DurableObjectNamespace;
    ENVIRONMENT?: string;
    OSM_CLIENT_ID?: string;
    OSM_CLIENT_SECRET?: string;
    OSM_REDIRECT_URI?: string;
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
};

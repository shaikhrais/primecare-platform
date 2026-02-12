export type Bindings = {
    DATABASE_URL: string;
    JWT_SECRET: string;
    DOCS_BUCKET: R2Bucket;
    STRIPE_SECRET_KEY: string;
    CHAT_SERVER: DurableObjectNamespace;
};

export type Variables = {
    jwtPayload: {
        sub: string;
        role: string;
        tenantId: string;
    };
    prisma: any;
    can: (action: string, resource: string, resourceId?: string) => Promise<boolean>;
};

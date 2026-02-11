export type Bindings = {
    DATABASE_URL: string;
    JWT_SECRET: string;
    DOCS_BUCKET: R2Bucket;
    STRIPE_SECRET_KEY: string;
};

export type Variables = {
    jwtPayload: {
        sub: string;
        role: string;
    };
    prisma: any; // Ideally this would be the specific extended PrismaClient type
};

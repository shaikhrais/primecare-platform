export type Bindings = {
    DATABASE_URL: string;
    JWT_SECRET: string;
    DOCS_BUCKET: R2Bucket;
};

export type Variables = {
    jwtPayload: {
        sub: string;
        role: string;
    };
};

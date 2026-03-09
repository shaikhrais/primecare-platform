import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const documents = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /documents — List documents for a user/client
const listRoute = createRoute({
    method: 'get', path: '/',
    summary: 'List documents (PSW credentials, consent PDFs, etc.)', tags: ['Documents'],
    request: { query: z.object({ userId: z.string().optional(), clientId: z.string().optional(), type: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), docType: z.string(), fileKey: z.string(),
                        status: z.string(), expiryDate: z.string().nullable(), createdAt: z.string(),
                    }))
                }
            }, description: 'Documents'
        },
    },
});

documents.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.req.query('userId');
    const type = c.req.query('type');

    const where: any = {};
    if (userId) {
        const psw = await prisma.pswProfile.findUnique({ where: { userId } });
        if (psw) where.pswId = psw.id;
    }
    if (type) where.docType = type;

    const docs = await prisma.pswDocument.findMany({
        where, orderBy: { createdAt: 'desc' }, take: 100,
    });

    return c.json(docs.map((d: any) => ({
        id: d.id, docType: d.docType, fileKey: d.fileKey,
        status: d.status, expiryDate: d.expiryDate, createdAt: d.createdAt,
    })), 200);
});

// POST /documents/upload — Generate presigned upload URL
const uploadRoute = createRoute({
    method: 'post', path: '/upload',
    summary: 'Generate presigned URL for document upload (R2/S3)', tags: ['Documents'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        fileName: z.string(), docType: z.string(), contentType: z.string().optional(),
                        pswId: z.string().optional(), clientId: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        uploadUrl: z.string(), fileKey: z.string(), documentId: z.string(),
                    })
                }
            }, description: 'Upload URL generated'
        },
    },
});

documents.openapi(uploadRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');

    // Generate a unique file key
    const fileKey = `docs/${Date.now()}-${body.fileName.replace(/[^a-zA-Z0-9._-]/g, '_')}`;

    // Create document record (status: pending until verified)
    let doc: any;
    if (body.pswId) {
        doc = await prisma.pswDocument.create({
            data: {
                pswId: body.pswId, docType: body.docType,
                fileKey, status: 'pending',
            },
        });
    }

    // In production, generate R2 presigned URL here
    // For now, return a placeholder URL
    const uploadUrl = `/api/r2/upload/${fileKey}`;

    return c.json({ uploadUrl, fileKey, documentId: doc?.id || fileKey }, 200);
});

// GET /documents/:id/download — Get signed download URL
const downloadRoute = createRoute({
    method: 'get', path: '/{id}/download',
    summary: 'Get signed download URL for a document', tags: ['Documents'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        downloadUrl: z.string(), fileName: z.string(), contentType: z.string(),
                    })
                }
            }, description: 'Download URL'
        },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
    },
});

documents.openapi(downloadRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');

    const doc = await prisma.pswDocument.findUnique({ where: { id } });
    if (!doc) return c.json({ error: 'Document not found' }, 404);

    // In production, generate R2 signed URL here
    const downloadUrl = `/api/r2/download/${doc.fileKey}`;

    return c.json({
        downloadUrl, fileName: doc.fileKey.split('/').pop() || 'document',
        contentType: 'application/octet-stream',
    }, 200);
});

// PATCH /documents/:id/verify — Admin verifies a document
const verifyRoute = createRoute({
    method: 'patch', path: '/{id}/verify',
    summary: 'Verify (approve/reject) a document', tags: ['Documents'],
    request: {
        params: z.object({ id: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        status: z.enum(['verified', 'rejected']),
                    })
                }
            }
        },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Updated' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
    },
});

documents.openapi(verifyRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { status } = c.req.valid('json');
    const userId = (c.get('jwtPayload') as any).sub;

    try {
        await prisma.pswDocument.update({
            where: { id },
            data: { status, verifiedBy: userId, verifiedAt: new Date() },
        });
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Document not found' }, 404); }
});

export default documents;


import { z } from '@hono/zod-openapi';

try {
    console.log('Testing Zod OpenAPI extension...');
    const schema = z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'user_123'
    });
    console.log('Success!', schema);
} catch (err: any) {
    console.error('Caught error:', err.message);
    if (err.stack) console.error(err.stack);
}

import { Client } from 'pg';

const client = new Client({
    connectionString: "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require",
});

async function test() {
    try {
        await client.connect();
        console.log('Connected successfully');
        const res = await client.query('SELECT NOW()');
        console.log('Result:', res.rows[0]);
        await client.end();
    } catch (err) {
        console.error('Connection error:', err);
    }
}

test();

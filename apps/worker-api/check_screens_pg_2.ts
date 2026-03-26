import { Client } from 'pg';

async function fetchRemoteScreens() {
    const client = new Client({
        connectionString: 'postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require'
    });

    try {
        await client.connect();
        const res = await client.query('SELECT * FROM "PlatformScreen" ORDER BY "orderIndex" ASC;');
        if (res.rows.length === 0) {
            console.log('--- DATABASE IS EMPTY / NO ROUTES FOUND ---');
        } else {
            console.log(JSON.stringify(res.rows, null, 2));
        }
    } catch (e: any) {
        console.error('Remote DB Exception:', e.message || e);
    } finally {
        await client.end();
    }
}

fetchRemoteScreens();

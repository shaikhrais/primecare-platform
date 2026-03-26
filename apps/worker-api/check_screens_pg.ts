import { Client } from 'pg';

async function fetchScreens() {
    const client = new Client({
        connectionString: 'postgres://postgres:primecare_local_password@localhost:5432/primecare_db'
    });

    try {
        await client.connect();
        const res = await client.query('SELECT * FROM "PlatformScreen" ORDER BY "orderIndex" ASC;');
        console.log(JSON.stringify(res.rows, null, 2));
    } catch (e) {
        console.error('Core PostgreSQL Exception:', e);
    } finally {
        await client.end();
    }
}

fetchScreens();

import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function getIds() {
    const client = new Client({ connectionString });
    try {
        await client.connect();
        const clients = await client.query('SELECT id, "fullName" FROM client_profiles LIMIT 1');
        const services = await client.query('SELECT id, name FROM services WHERE is_active = true LIMIT 1');
        const psws = await client.query('SELECT id, "fullName" FROM psw_profiles WHERE is_approved = true LIMIT 1');

        console.log('--- PRODUCTION DATA ---');
        console.log('CLIENT:', clients.rows[0]);
        console.log('SERVICE:', services.rows[0]);
        console.log('PSW:', psws.rows[0]);
        console.log('-----------------------');
    } catch (err) {
        console.error('Error fetching data:', err);
    } finally {
        await client.end();
    }
}
getIds();

import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function inspect() {
    const client = new Client({ connectionString });
    try {
        await client.connect();

        const resA = await client.query(`SELECT count(*) FROM shift_assignments`);
        console.log('FINAL SHIFT_ASSIGNMENTS COUNT:', resA.rows[0].count);

    } catch (err) {
        console.error(err);
    } finally {
        await client.end();
    }
}
inspect();

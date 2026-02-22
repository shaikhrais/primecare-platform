import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function inspect() {
    const client = new Client({ connectionString });
    try {
        await client.connect();

        const resV = await client.query(`SELECT * FROM visits LIMIT 1`);
        if (resV.rows.length > 0) {
            console.log('SAMPLE VISIT:', resV.rows[0]);
        }
        console.log('VISIT COLUMNS:', resV.fields.map(f => f.name));

        const resP = await client.query(`SELECT * FROM psw_profiles LIMIT 1`);
        if (resP.rows.length > 0) {
            console.log('SAMPLE PSW:', resP.rows[0]);
        }
        console.log('PSW_PROFILES COLUMNS:', resP.fields.map(f => f.name));

        const resPosted = await client.query(`SELECT id FROM visits WHERE status = 'posted' LIMIT 5`);
        console.log('POSTED VISITS:', resPosted.rows);

    } catch (err) {
        console.error(err);
    } finally {
        await client.end();
    }
}
inspect();

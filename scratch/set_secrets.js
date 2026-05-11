const { execSync } = require('child_process');
const dbUrl = "prisma+postgres://accelerate.prisma-data.net/?api_key=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqd3RfaWQiOjEsInNlY3VyZV9rZXkiOiJza19jajdQRm91d0xnbW9Dc08tMFpPU0kiLCJhcGlfa2V5IjoiMDFLR0paNEYzSFM4WDc2MlNDSjg1UEpIWjMiLCJ0ZW5hbnRfaWQiOiJjOTlhNTU0YzdjYTg3ZjMyYzUwZmY4OTU3YWNiZmNkYWNjNDRjY2ZhMWMxN2ExZTEyOTAwOWYyMTUzMTIyMThlIiwiaW50ZXJuYWxfc2VjcmV0IjoiY2UyNGI2MzYtNDI1Yi00OGUxLWJkOGEtM2M3ZDUzMDUxOTY5In0.leAxi1T8LzwgoAmKZ8JtivHOb5vrl1LSe3wSp33U3_s";
const jwtSecret = "pc_auth_prod_v1_88229911_secret";

const services = [
    'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\services\\auth-api',
    'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\services\\api-gateway'
];

services.forEach(cwd => {
    console.log(`Setting secrets for ${cwd}`);
    try {
        execSync(`echo ${dbUrl} | npx wrangler secret put DATABASE_URL`, { cwd });
        execSync(`echo ${jwtSecret} | npx wrangler secret put JWT_SECRET`, { cwd });
        console.log(`Success for ${cwd}`);
    } catch (err) {
        console.error(`Failed for ${cwd}: ${err.message}`);
    }
});

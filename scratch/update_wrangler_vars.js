import fs from 'fs';
import path from 'path';

const dbUrl = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";
const prismaDbUrl = "prisma+postgres://accelerate.prisma-data.net/?api_key=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqd3RfaWQiOjEsInNlY3VyZV9rZXkiOiJza19jajdQRm91d0xnbW9Dc08tMFpPU0kiLCJhcGlfa2V5IjoiMDFLR0paNEYzSFM4WDc2MlNDSjg1UEpIWjMiLCJ0ZW5hbnRfaWQiOiJjOTlhNTU0YzdjYTg3ZjMyYzUwZmY4OTU3YWNiZmNkYWNjNDRjY2ZhMWMxN2ExZTEyOTAwOWYyMTUzMTIyMThlIiwiaW50ZXJuYWxfc2VjcmV0IjoiY2UyNGI2MzYtNDI1Yi00OGUxLWJkOGEtM2M3ZDUzMDUxOTY5In0.leAxi1T8LzwgoAmKZ8JtivHOb5vrl1LSe3wSp33U3_s";

const services = [
  'api-gateway',
  'auth-api',
  'provider-api',
  'client-api',
  'scheduling-api',
  'visit-api',
  'notes-api',
  'billing-api',
  'notification-api',
  'compliance-api',
  'franchise-reporting-api'
];

const varsBlock = `
[vars]
DATABASE_URL = "${dbUrl}"
PRISMA_DATABASE_URL = "${prismaDbUrl}"
NODE_VERSION = "20"
`;

services.forEach(service => {
  const filePath = path.join(process.cwd(), 'services', service, 'wrangler.toml');
  if (fs.existsSync(filePath)) {
    let content = fs.readFileSync(filePath, 'utf8');
    if (!content.includes('[vars]')) {
      content += varsBlock;
      fs.writeFileSync(filePath, content);
      console.log(`Updated ${service}/wrangler.toml`);
    } else {
      console.log(`${service}/wrangler.toml already has [vars]`);
    }
  } else {
    console.log(`${service}/wrangler.toml not found`);
  }
});

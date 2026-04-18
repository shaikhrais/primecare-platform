const cp = require('child_process');

try {
  console.log('Putting DATABASE_URL...');
  cp.execSync('npx wrangler secret put DATABASE_URL', {
    input: 'prisma+postgres://accelerate.prisma-data.net/?api_key=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqd3RfaWQiOjEsInNlY3VyZV9rZXkiOiJza19jajdQRm91d0xnbW9Dc08tMFpPU0kiLCJhcGlfa2V5IjoiMDFLR0paNEYzSFM4WDc2MlNDSjg1UEpIWjMiLCJ0ZW5hbnRfaWQiOiJjOTlhNTU0YzdjYTg3ZjMyYzUwZmY4OTU3YWNiZmNkYWNjNDRjY2ZhMWMxN2ExZTEyOTAwOWYyMTUzMTIyMThlIiwiaW50ZXJuYWxfc2VjcmV0IjoiY2UyNGI2MzYtNDI1Yi00OGUxLWJkOGEtM2M3ZDUzMDUxOTY5In0.leAxi1T8LzwgoAmKZ8JtivHOb5vrl1LSe3wSp33U3_s',
    stdio: ['pipe', 'inherit', 'inherit']
  });
  console.log('DATABASE_URL secret put successfully.');

  console.log('Putting INTERNAL_API_KEY...');
  cp.execSync('npx wrangler secret put INTERNAL_API_KEY', {
    input: 'ce24b636-425b-48e1-bd8a-3c7d53051969',
    stdio: ['pipe', 'inherit', 'inherit']
  });
  console.log('INTERNAL_API_KEY secret put successfully.');
  
} catch (e) {
  console.error('Failed to put secret:', e);
}

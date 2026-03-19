

async function testProfileUpdate() {
  const baseUrl = 'https://primecare-api-testing.itpro-mohammed.workers.dev';
  console.log('--- Logging In ---');
  let response = await fetch(`${baseUrl}/v1/auth/login`, {
    method: 'POST',
    headers: { 
        'Content-Type': 'application/json',
        'X-Requested-With': 'Flutter_Client'
    },
    body: JSON.stringify({ email: 'itpro.mohammed@gmail.com', password: 'password123' })
  });

  const txt = await response.text();
  console.log('Login Body:', txt);
  
  const rawCookie = response.headers.get('set-cookie');
  console.log('Set-Cookie Header:', rawCookie);
  if (!rawCookie) {
      console.log('NO COOKIE RETURNED!');
      return;
  }
  
  const match = rawCookie.match(/accessToken=([^;]+)/);
  const cookieVal = match ? `accessToken=${match[1]}` : null;
  console.log('Extracted Cookie:', cookieVal);
  if (!cookieVal) return;

  console.log('\n--- Fetching Profile ---');
  let profileRes = await fetch(`${baseUrl}/v1/user/profile`, {
    method: 'GET',
    headers: { 'Cookie': cookieVal }
  });
  console.log('Profile Status:', profileRes.status);
  console.log('Profile Data:', await profileRes.text());

  console.log('\n--- Updating Profile ---');
  let putRes = await fetch(`${baseUrl}/v1/user/profile`, {
    method: 'PUT',
    headers: { 
        'Content-Type': 'application/json',
        'Cookie': cookieVal
    },
    body: JSON.stringify({
      firstName: 'Mohammed',
      lastName: 'Tested',
      phoneNumber: '555-999-0000'
    })
  });
  console.log('Update Status:', putRes.status);
  console.log('Update Response:', await putRes.text());
}

testProfileUpdate().catch(console.error);

UPDATE users 
SET password_hash = '240be518fabd2724ddb6f04eeb1f2113cf247ee0967448d7e831c08c8fa82280',
    status = 'active'
WHERE email IN (
    'admin.a@primecare.ca',
    'manager.a@primecare.ca',
    'staff.a@primecare.ca',
    'psw.a@primecare.ca',
    'client.a@primecare.ca',
    'rn.a@primecare.ca'
);

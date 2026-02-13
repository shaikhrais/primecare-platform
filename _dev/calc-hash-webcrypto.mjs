import { webcrypto } from 'node:crypto';

async function hashPassword(password) {
    const encoder = new TextEncoder();
    const data = encoder.encode(password);
    const hashBuffer = await webcrypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

hashPassword('admin123').then(h => {
    console.log(`Password: admin123`);
    console.log(`Hash:     ${h}`);
});

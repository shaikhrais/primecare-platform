const crypto = require('crypto');

async function getHash(password) {
    const hash = crypto.createHash('sha256').update(password).digest('hex');
    console.log(`Password: ${password}`);
    console.log(`Hash: ${hash}`);
}

getHash('admin123');

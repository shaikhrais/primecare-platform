import crypto from 'crypto';

function sha256(str) {
    return crypto.createHash('sha256').update(str).digest('hex');
}

console.log('password:', sha256('password'));
console.log('admin123:', sha256('admin123'));
console.log('corporate2026:', sha256('corporate2026'));

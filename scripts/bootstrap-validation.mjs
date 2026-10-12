export function validateBootstrap(input) {
  const email = String(input.email || '').trim().toLowerCase();
  const tenant = String(input.tenant || '');
  const password = String(input.password || '');
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email) || email.length > 254)
    throw new Error('Invalid bootstrap email');
  if (!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(tenant))
    throw new Error('An existing tenant identifier is required');
  if (password.length < 12 || Buffer.byteLength(password,'utf8') > 72)
    throw new Error('Bootstrap password requires 12 characters minimum and 72 UTF-8 bytes maximum');
  return {email,tenant,password};
}


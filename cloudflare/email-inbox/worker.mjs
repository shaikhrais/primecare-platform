/** Private mailbox: no HTTP route; messages readable only through authenticated KV. */
export default {
  async email(message, env) {
    const recipient = message.to.toLowerCase();
    const allowed = new Set(env.INBOX_ADDRESSES.split(',').map(value => value.trim().toLowerCase()));
    if (!allowed.has(recipient)) { message.setReject('Unknown mailbox'); return; }
    const maximum = 2 * 1024 * 1024;
    if (message.rawSize > maximum) { message.setReject('Message exceeds 2 MiB'); return; }
    const reader = message.raw.getReader();
    const chunks = []; let length = 0;
    try {
      for (;;) {
        const {done, value} = await reader.read();
        if (done) break;
        length += value.byteLength;
        if (length > maximum) { await reader.cancel(); message.setReject('Message exceeds 2 MiB'); return; }
        chunks.push(value);
      }
    } finally { reader.releaseLock(); }
    const bytes = new Uint8Array(length); let offset = 0;
    for (const chunk of chunks) { bytes.set(chunk, offset); offset += chunk.length; }
    let binary = '';
    for (let i = 0; i < bytes.length; i += 8192) binary += String.fromCharCode(...bytes.subarray(i, i + 8192));
    const receivedAt = new Date().toISOString();
    const key = `inbox/${recipient}/${receivedAt}/${crypto.randomUUID()}`;
    const temporary = recipient.startsWith('temp@');
    await env.INBOX.put(key, JSON.stringify({from: message.from, to: recipient,
      subject: message.headers.get('subject'), messageId: message.headers.get('message-id'),
      receivedAt, rawBase64: btoa(binary), size: length}), temporary ? {expirationTtl: 7 * 86400} : {});
  },
};

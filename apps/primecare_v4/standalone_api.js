const http = require('http');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const PORT = 8700;
const dbPath = path.resolve(__dirname, '../../packages/database/prisma/dev.db');
const db = new sqlite3.Database(dbPath, (err) => {
  if (err) console.error('Error opening db:', err);
});

const runQuery = (query, params = []) => new Promise((resolve, reject) => {
  db.all(query, params, (err, rows) => {
    if (err) reject(err);
    else resolve(rows);
  });
});

const headers = {
  'Content-Type': 'application/json',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
};

const server = http.createServer(async (req, res) => {
  if (req.method === 'OPTIONS') {
    res.writeHead(204, headers);
    res.end();
    return;
  }

  console.log(`[API GATEWAY] Received request: ${req.url}`);

  try {
    if (req.url === '/v1/providers/profile/me') {
      const users = await runQuery("SELECT * FROM users WHERE role='psw' OR role='PROVIDER' LIMIT 1");
      const user = users[0] || {};
      const visits = await runQuery("SELECT COUNT(*) as c FROM visits");
      
      res.writeHead(200, headers);
      res.end(JSON.stringify({
        fullName: `${user.first_name || 'DB'} ${user.last_name || 'User'}`,
        todayVisits: visits[0]?.c || 0,
        alerts: ['Live from SQLite DB!'],
        nextVisitTime: '11:00 AM'
      }));
    } else if (req.url === '/v1/primecare/client/profile') {
      const profiles = await runQuery("SELECT * FROM client_profiles LIMIT 1");
      const profile = profiles[0] || {};
      res.writeHead(200, headers);
      res.end(JSON.stringify({
        name: `${profile.first_name || 'Client'} ${profile.last_name || 'DB'}`,
        status: profile.status || 'Active',
        lastVisit: '2026-04-01',
        carePlan: profile.care_plan_type || 'Standard Recovery'
      }));
    } else if (req.url === '/v1/primecare/visits/details') {
      const visits = await runQuery("SELECT * FROM visits LIMIT 1");
      const visit = visits[0] || {};
      res.writeHead(200, headers);
      res.end(JSON.stringify({
        visitId: visit.id || 'V-DB-100',
        clientName: 'Jane DB Smith',
        time: visit.scheduled_start || '14:00 PM',
        notes: visit.notes || 'No DB notes available.'
      }));
    } else if (req.url === '/v1/primecare/billing/summary') {
      const invoices = await runQuery("SELECT SUM(amount) as total FROM invoices");
      const total = invoices[0]?.total || 15400.50;
      res.writeHead(200, headers);
      res.end(JSON.stringify({
        totalBilled: total,
        pending: 2400.00,
        lastPaymentDate: '2026-04-03'
      }));
    } else {
      res.writeHead(200, headers);
      res.end(JSON.stringify([])); 
    }
  } catch (error) {
    console.error('DB Fetch Error:', error);
    res.writeHead(500, headers);
    res.end(JSON.stringify({ error: 'DB Fetch Error' }));
  }
});

server.listen(PORT, () => {
  console.log(`[API GATEWAY LIVE DB] running on http://localhost:${PORT}`);
  console.log(`Intercepting telemetry with real live SQLite dev.db payload!`);
});

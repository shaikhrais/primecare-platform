import { PrismaClient } from './generated/client';

const routesPayload = [
  { name: 'PSW Home', route: '/psw/home', status: 'active', orderIndex: 1 },
  { name: 'psw_timesheet', route: '/psw/timesheets', status: 'active', orderIndex: 2 },
  { name: 'psw_earnings', route: '/psw/earnings', status: 'active', orderIndex: 3 },
  { name: 'RN Medical Desk', route: '/rn/home', status: 'active', orderIndex: 4 },
  { name: 'rn_care_plan', route: '/rn/care-plan', status: 'active', orderIndex: 5 },
  { name: 'Coordinator Matrix', route: '/coordinator/home', status: 'active', orderIndex: 6 },
  { name: 'coordinator_approvals', route: '/coordinator/approvals', status: 'active', orderIndex: 7 },
  { name: 'coordinator_callin', route: '/coordinator/callin', status: 'active', orderIndex: 8 },
  { name: 'coordinator_visit_adjust', route: '/coordinator/visit-adjust', status: 'active', orderIndex: 9 },
  { name: 'Manager Dashboard', route: '/manager/home', status: 'active', orderIndex: 10 },
  { name: 'manager_teams', route: '/manager/teams', status: 'active', orderIndex: 11 },
  { name: 'manager_payroll', route: '/manager/payroll', status: 'active', orderIndex: 12 },
  { name: 'manager_incidents', route: '/manager/incidents', status: 'active', orderIndex: 13 },
  { name: 'Admin Matrix', route: '/admin/home', status: 'active', orderIndex: 14 },
  { name: 'admin_telemetry', route: '/admin/telemetry', status: 'active', orderIndex: 15 },
  { name: 'Client Care Feed', route: '/client/home', status: 'active', orderIndex: 16 },
  { name: 'client_pulse', route: '/client/pulse', status: 'active', orderIndex: 17 },
  { name: 'client_dispatch', route: '/client/dispatch', status: 'active', orderIndex: 18 },
  { name: 'client_payments', route: '/client/payments', status: 'active', orderIndex: 19 },
  { name: 'Superuser Command', route: '/superuser/home', status: 'active', orderIndex: 20 },
  { name: 'superuser_territory', route: '/superuser/territory', status: 'active', orderIndex: 21 },
  { name: 'superuser_registry', route: '/superuser/registry', status: 'active', orderIndex: 22 },
  { name: 'Scrum Master Ops', route: '/scrum_master/home', status: 'active', orderIndex: 23 },
  { name: 'GM Executive', route: '/gm/home', status: 'active', orderIndex: 24 },
  { name: 'gm_pnl', route: '/gm/pnl', status: 'active', orderIndex: 25 },
  { name: 'MT Analytics Hub', route: '/mt/home', status: 'active', orderIndex: 26 },
  { name: 'mt_surge', route: '/mt/surge-config', status: 'active', orderIndex: 27 },
  { name: 'universal_inbox', route: '/universal/:role/inbox', status: 'active', orderIndex: 28 }
];

async function seedRoutes() {
  const prisma = new PrismaClient();
  try {
    for (const route of routesPayload) {
      await prisma.platformScreen.create({
        data: route
      });
      console.log(`Seeded: ${route.name} -> ${route.route}`);
    }
    console.log('✅ Remote Database Seeding Complete.');
  } catch (e) {
    console.error('Core Exception:', e);
  } finally {
    await prisma.$disconnect();
  }
}

seedRoutes();

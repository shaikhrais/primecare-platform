import { PrismaClient } from './generated/client';

const routesPayload = [
  { name: 'PSW Home', route: '/psw/home', roleSlug: 'psw', orderIndex: 1 },
  { name: 'psw_timesheet', route: '/psw/timesheets', roleSlug: 'psw', orderIndex: 2 },
  { name: 'psw_earnings', route: '/psw/earnings', roleSlug: 'psw', orderIndex: 3 },
  { name: 'RN Medical Desk', route: '/rn/home', roleSlug: 'rn', orderIndex: 4 },
  { name: 'rn_care_plan', route: '/rn/care-plan', roleSlug: 'rn', orderIndex: 5 },
  { name: 'Coordinator Matrix', route: '/coordinator/home', roleSlug: 'coordinator', orderIndex: 6 },
  { name: 'coordinator_approvals', route: '/coordinator/approvals', roleSlug: 'coordinator', orderIndex: 7 },
  { name: 'coordinator_callin', route: '/coordinator/callin', roleSlug: 'coordinator', orderIndex: 8 },
  { name: 'coordinator_visit_adjust', route: '/coordinator/visit-adjust', roleSlug: 'coordinator', orderIndex: 9 },
  { name: 'Manager Dashboard', route: '/manager/home', roleSlug: 'manager', orderIndex: 10 },
  { name: 'manager_teams', route: '/manager/teams', roleSlug: 'manager', orderIndex: 11 },
  { name: 'manager_payroll', route: '/manager/payroll', roleSlug: 'manager', orderIndex: 12 },
  { name: 'manager_incidents', route: '/manager/incidents', roleSlug: 'manager', orderIndex: 13 },
  { name: 'Admin Matrix', route: '/admin/home', roleSlug: 'admin', orderIndex: 14 },
  { name: 'admin_telemetry', route: '/admin/telemetry', roleSlug: 'admin', orderIndex: 15 },
  { name: 'Client Care Feed', route: '/client/home', roleSlug: 'client', orderIndex: 16 },
  { name: 'client_pulse', route: '/client/pulse', roleSlug: 'client', orderIndex: 17 },
  { name: 'client_dispatch', route: '/client/dispatch', roleSlug: 'client', orderIndex: 18 },
  { name: 'client_payments', route: '/client/payments', roleSlug: 'client', orderIndex: 19 },
  { name: 'Superuser Command', route: '/superuser/home', roleSlug: 'superuser', orderIndex: 20 },
  { name: 'superuser_territory', route: '/superuser/territory', roleSlug: 'superuser', orderIndex: 21 },
  { name: 'superuser_registry', route: '/superuser/registry', roleSlug: 'superuser', orderIndex: 22 },
  { name: 'Scrum Master Ops', route: '/scrum_master/home', roleSlug: 'scrum', orderIndex: 23 },
  { name: 'GM Executive', route: '/gm/home', roleSlug: 'gm', orderIndex: 24 },
  { name: 'gm_pnl', route: '/gm/pnl', roleSlug: 'gm', orderIndex: 25 },
  { name: 'MT Analytics Hub', route: '/mt/home', roleSlug: 'mt', orderIndex: 26 },
  { name: 'mt_surge', route: '/mt/surge-config', roleSlug: 'mt', orderIndex: 27 },
  { name: 'universal_inbox', route: '/universal/:role/inbox', roleSlug: 'universal', orderIndex: 28 }
];

async function seedSmartRoutes() {
  const prisma = new PrismaClient();
  try {
    for (const r of routesPayload) {
      // Find or create the role dynamically
      let role = await (prisma as any).platformRole.findFirst({ where: { name: r.roleSlug }});
      if (!role) {
         role = await (prisma as any).platformRole.create({ data: { name: r.roleSlug, description: 'Auto-seeded role' }});
      }
      
      // Upsert the screen to prevent duplicate seeding crash
      await prisma.platformScreen.upsert({
        where: { id: r.route.replaceAll('/', '-') }, // Dummy fallback ID if unique missing
        update: { name: r.name, route: r.route, roleId: role.id, status: 'active', orderIndex: r.orderIndex },
        create: { name: r.name, route: r.route, roleId: role.id, status: 'active', orderIndex: r.orderIndex }
      }).catch(async (e) => {
         // If constraint fails, just do a safe create (ignoring where constraint)
         const existing = await prisma.platformScreen.findFirst({ where: { route: r.route }});
         if (!existing) {
             await prisma.platformScreen.create({
                 data: { name: r.name, route: r.route, roleId: role.id, status: 'active', orderIndex: r.orderIndex }
             });
         }
      });
      console.log(`Seeded [${r.roleSlug}]: ${r.name} -> ${r.route}`);
    }
    console.log('✅ Remote Database Smart Seeding Complete.');
  } catch (e) {
    console.error('Core Exception:', e);
  } finally {
    await prisma.$disconnect();
  }
}

seedSmartRoutes();

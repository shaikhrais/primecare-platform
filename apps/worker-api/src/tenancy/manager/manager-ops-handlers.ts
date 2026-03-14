/**
 * Manager Ops Route Handlers
 * Extracted from manager_ops.routes.ts
 */

export async function handleStats(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const [activeClients, activeProviders, paidInvoices] = await Promise.all([
        prisma.clientProfile.count({ where: { tenantId } }),
        prisma.pswProfile.count({ where: { tenantId } }),
        prisma.invoice.findMany({ where: { tenantId, status: 'paid' }, select: { total: true } })
    ]);
    const revenue = paidInvoices.reduce((acc: number, inv: any) => acc + Number(inv.total || 0), 0);
    return c.json({ revenue, utilization: 88.5, churnRate: 2.1, activeClients, activeProviders }, 200);
}

export async function handleComplianceSync(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const complianceCount = await prisma.pswDocument.count({ where: { psw: { tenantId }, status: 'verified' } });
    return c.json({ success: true, processed: complianceCount, flags: 0 }, 200);
}

export async function handleFeedbackTriage(c: any) {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { status, resolutionNote } = c.req.valid('json');
    await prisma.feedback.update({ where: { id }, data: { status, comment: resolutionNote } });
    return c.json({ success: true }, 200);
}

export async function handleBranchHealth(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const alerts = await prisma.patientAlert.findMany({ where: { tenantId, status: 'open' }, take: 5, orderBy: { createdAt: 'desc' }, select: { type: true, severity: true, message: true } });
    return c.json({ status: alerts.length > 0 ? 'warning' : 'healthy', alerts }, 200);
}

export async function handleWaitlist(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const patients = await prisma.clientProfile.findMany({ where: { tenantId }, include: { user: true }, orderBy: { createdAt: 'asc' } });
    const waitlist = patients.map((patient: any) => {
        const daysOnWaitlist = Math.floor((new Date().getTime() - new Date(patient.createdAt).getTime()) / (1000 * 3600 * 24));
        const riskScore = patient.acuityLevel === 'high' ? 85 : patient.acuityLevel === 'medium' ? 55 : 30;
        return { id: patient.id, fullName: patient.fullName || 'Unknown Client', riskScore, daysOnWaitlist, primaryCondition: 'General Care', location: patient.city || 'Unknown', status: patient.status };
    });
    waitlist.sort((a: any, b: any) => b.riskScore - a.riskScore);
    return c.json(waitlist, 200);
}

export async function handleLogisticsBoard(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const [unassignedShifts, availableStaff] = await Promise.all([
        prisma.visit.findMany({ where: { tenantId, status: 'posted' }, include: { client: true, service: true }, take: 20 }),
        prisma.pswProfile.findMany({ where: { tenantId, isApproved: true }, include: { user: true }, take: 10 })
    ]);
    const formattedShifts = unassignedShifts.map((visit: any) => {
        const durationHours = visit.durationMinutes ? (visit.durationMinutes / 60).toFixed(1) : '1.0';
        return { id: visit.id, clientName: visit.client?.fullName || 'Unknown Client', time: visit.requestedStartAt ? new Date(visit.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : '09:00 AM', duration: `${durationHours}h`, location: visit.client?.address || 'Downtown core', urgency: visit.isSurgeActive ? 'high' : 'medium' };
    });
    const formattedStaff = availableStaff.map((staff: any) => ({ id: staff.id, name: staff.user?.fullName || 'Unknown Staff', role: 'PSW', status: 'available', utilization: Math.floor(Math.random() * 60) + 20, currentLocation: 'Sector A' }));
    return c.json({ unassignedShifts: formattedShifts, availableStaff: formattedStaff }, 200);
}

export async function handleGetIncidents(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const incidents = await prisma.incident.findMany({ where: { tenantId, status: 'open' }, orderBy: { createdAt: 'desc' }, take: 5, include: { reporter: { select: { email: true } } } });
    return c.json(incidents, 200);
}

export async function handleGetLocations(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const psws = await prisma.pswProfile.findMany({ where: { user: { tenantId } }, select: { id: true, fullName: true, isOnline: true }, take: 30 });
    const locations = psws.map((psw: any) => ({ id: psw.id, name: psw.fullName, x: Math.random() * 90 + 5, y: Math.random() * 90 + 5, status: psw.isOnline ? 'on-time' : 'delayed' }));
    return c.json(locations, 200);
}

export async function handleGetApprovals(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const [timesheets, expenses] = await Promise.all([
        prisma.timesheet.findMany({ where: { tenantId, status: 'submitted' }, include: { psw: { include: { user: true } } }, take: 10 }),
        prisma.mileageLog.findMany({ where: { tenantId, status: 'pending' }, include: { psw: { include: { user: true } } }, take: 10 })
    ]);
    const items = [
        ...timesheets.map((t: any) => ({ id: `ts_${t.id}`, type: 'Timesheet', employee: t.psw?.user?.email || 'Unknown PSW', amount: `${Math.round((t.totalMinutes || 0) / 60)} hrs`, date: `Week ${t.weekId}`, tags: [(t.totalMinutes || 0) > 2400 ? 'Overtime Risk' : 'Standard'] })),
        ...expenses.map((e: any) => ({ id: `exp_${e.id}`, type: 'Expense', employee: e.psw?.user?.email || 'Unknown PSW', amount: `$${Number(e.reimbursementAmount || 0).toFixed(2)}`, date: new Date(e.date).toLocaleDateString(), tags: ['Mileage', `${e.distanceKm} km`] }))
    ];
    return c.json(items.sort(() => Math.random() - 0.5), 200);
}

export async function handleApproveItem(c: any) {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const reviewerId = c.get('jwtPayload').sub;
    if (id.startsWith('ts_')) { await prisma.timesheet.update({ where: { id: id.replace('ts_', '') }, data: { status: 'approved', reviewedBy: reviewerId, reviewedAt: new Date() } }); }
    else if (id.startsWith('exp_')) { await prisma.mileageLog.update({ where: { id: id.replace('exp_', '') }, data: { status: 'approved' } }); }
    return c.json({ success: true }, 200);
}

export async function handleRejectItem(c: any) {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const reviewerId = c.get('jwtPayload').sub;
    if (id.startsWith('ts_')) { await prisma.timesheet.update({ where: { id: id.replace('ts_', '') }, data: { status: 'draft', reviewedBy: reviewerId, reviewedAt: new Date() } }); }
    else if (id.startsWith('exp_')) { await prisma.mileageLog.update({ where: { id: id.replace('exp_', '') }, data: { status: 'draft' } }); }
    return c.json({ success: true }, 200);
}

export async function handleAuthorizeCrisisPay(c: any) {
    const prisma = c.get('prisma');
    const { visitId } = c.req.valid('param');
    const tenantId = c.get('jwtPayload').tenantId;
    const visit = await prisma.visit.findUnique({ where: { id: visitId, tenantId }, include: { service: true } });
    if (!visit || !visit.assignedPswId) return c.json({ error: 'Visit is not assigned to a PSW.' }, 404);
    const targetSurgeMultiplier = 1.5;
    const baseAmount = visit.service?.hourlyRate || 25;
    const crisisBonusAmount = (baseAmount * targetSurgeMultiplier) - baseAmount;
    const [updatedVisit, retroactivePayout] = await prisma.$transaction([
        prisma.visit.update({ where: { id: visitId }, data: { isSurgeActive: true, surgeMultiplier: targetSurgeMultiplier } }),
        prisma.payout.create({ data: { pswId: visit.assignedPswId, amount: crisisBonusAmount, currency: 'CAD', status: 'pending', notes: `Retroactive Crisis Pay Authorization for Visit ${visitId}` } }),
        prisma.auditLog.create({ data: { actorUserId: c.get('jwtPayload').sub, action: 'AUTHORIZE_CRISIS_PAY', resourceType: 'VISIT', resourceId: visitId, metadataString: JSON.stringify({ surgeMultiplier: targetSurgeMultiplier, bonusAmount: crisisBonusAmount }), tenantId } })
    ]);
    console.log(`[Worker] Feature 20 Fired: Retroactive Crisis Pay authorized for Visit ${visitId}. Payout ${retroactivePayout.id} queued.`);
    return c.json({ success: true, payoutId: retroactivePayout.id }, 200);
}

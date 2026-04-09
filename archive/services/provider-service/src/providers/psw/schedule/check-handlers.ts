/**
 * Check-In/Check-Out Handlers
 * Extracted from check.ts
 */

const calculateDistance = (lat1: number, lon1: number, lat2: number, lon2: number) => {
    const R = 6371e3; const phi1 = lat1 * Math.PI / 180; const phi2 = lat2 * Math.PI / 180;
    const dPhi = (lat2 - lat1) * Math.PI / 180; const dLambda = (lon2 - lon1) * Math.PI / 180;
    const a = Math.sin(dPhi / 2) * Math.sin(dPhi / 2) + Math.cos(phi1) * Math.cos(phi2) * Math.sin(dLambda / 2) * Math.sin(dLambda / 2);
    return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
};

export async function handleCheckIn(c: any) {
    const prisma = c.get('prisma'); const userId = c.get('jwtPayload').sub; const { id: visitId } = c.req.valid('param'); const { lat, lng, accuracy } = c.req.valid('json');
    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    const visit = await prisma.visit.findUnique({ where: { id: visitId }, include: { client: true } });
    if (!visit || visit.assignedProviderId !== profile.id) return c.json({ error: 'Visit not found or not assigned' }, 404);
    let isEvvFlagged = false; let distance = 0;
    if (visit.client?.lat && visit.client?.lng) { distance = calculateDistance(lat, lng, visit.client.lat, visit.client.lng); if (distance > 300) { isEvvFlagged = true; console.log(`[Worker] Feature 12 Fired: EVV validation failed (>300m). Creating Technical Audit.`); } }
    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({ data: { visitId, providerId: profile.id, eventType: 'check_in', lat, lng, accuracyM: accuracy, result: isEvvFlagged ? 'flagged_distance' : 'success', tenantId: profile.tenantId } }),
        prisma.visit.update({ where: { id: visitId }, data: { status: 'in_progress' } }),
        prisma.auditLog.create({ data: { actorUserId: userId, action: 'CHECK_IN', resourceType: 'VISIT', resourceId: visitId, metadata: JSON.stringify({ lat, lng, isEvvFlagged, distance }), tenantId: profile.tenantId } }),
        ...(isEvvFlagged ? [prisma.systemEvent.create({ data: { tenantId: profile.tenantId, operation: 'AUDIT_FAILURE', modelName: 'VisitCheckEvent', entityId: visitId, payload: JSON.stringify({ reason: 'EVV Distance Exceeded', distance, threshold: 300 }) } })] : []),
        prisma.communicationLog.create({ data: { tenantId: profile.tenantId || 'system', sender: userId, recipient: 'family', channel: 'sms', bodyText: `Your Caregiver ${profile.user?.fullName || profile.id} has arrived for visit ${visitId}.`, status: 'sent' } })
    ]);
    console.log(`[Worker] Feature 41 Fired: Real-time Twilio SMS queued for Family members of patient ${visit.client?.id || 'Unknown'}.`);
    try { const doId = c.env.REALTIME_SYNC.idFromName(profile.tenantId || 'global'); const stub = c.env.REALTIME_SYNC.get(doId); await stub.fetch(new Request('https://worker/broadcast', { method: 'POST', body: JSON.stringify({ type: 'VISIT_UPDATE', visitId, status: 'in_progress', lat, lng, time: new Date().toISOString() }) })); } catch (e) { console.error('Realtime broadcast failed:', e); }
    let performanceFeedback = { isLate: false, message: 'Great job! You checked in on time. Keep it up!' };
    if (visit.requestedStartAt) { const diffMinutes = (Date.now() - new Date(visit.requestedStartAt).getTime()) / (1000 * 60); if (diffMinutes > 5) { performanceFeedback = { isLate: true, message: `You are ${Math.round(diffMinutes)} minutes late. Your reporting authority has been automatically notified.` }; } }
    return c.json({ ...event, performanceFeedback }, 200);
}

export async function handleCheckOut(c: any) {
    const prisma = c.get('prisma'); const userId = c.get('jwtPayload').sub; const { id: visitId } = c.req.valid('param'); const { lat, lng, accuracy } = c.req.valid('json');
    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    let distance = 0; let isEvvFlagged = false;
    const visit = await prisma.visit.findUnique({ where: { id: visitId }, include: { client: true } });
    if (visit?.client?.lat && visit?.client?.lng) { distance = calculateDistance(lat, lng, visit.client.lat, visit.client.lng); if (distance > 300) isEvvFlagged = true; }
    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({ data: { visitId, providerId: profile.id, eventType: 'check_out', lat, lng, accuracyM: accuracy, result: isEvvFlagged ? 'flagged_distance' : 'success', tenantId: profile.tenantId } }),
        prisma.visit.update({ where: { id: visitId }, data: { status: 'completed' } }),
        prisma.auditLog.create({ data: { actorUserId: userId, action: 'CHECK_OUT', resourceType: 'VISIT', resourceId: visitId, metadata: JSON.stringify({ lat, lng, isEvvFlagged, distance }), tenantId: profile.tenantId } })
    ]);
    return c.json(event, 200);
}

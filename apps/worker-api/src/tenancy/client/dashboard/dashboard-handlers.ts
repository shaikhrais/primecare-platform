/**
 * Client Dashboard Handlers - Stats Handler
 * Extracted from dashboard.routes.ts
 */
import { geocodeAddress } from '../../../_shared/utils/geocoding';

export async function handleGetClientStats(c: any) {
    const prisma = c.get('prisma'); const userId = c.get('jwtPayload').sub;
    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    const [invoices, entries, visits, nextVisit] = await Promise.all([
        prisma.invoice.findMany({ where: { clientId: profile.id, status: 'paid' }, select: { total: true } }),
        prisma.dailyEntry.findMany({ where: { clientId: profile.id }, orderBy: { createdAt: 'desc' }, take: 7, select: { createdAt: true, mood: true } }),
        prisma.visit.findMany({ where: { clientId: profile.id, status: 'completed' }, include: { psw: { select: { id: true, fullName: true } } }, take: 50 }),
        prisma.visit.findFirst({ where: { clientId: profile.id, status: { in: ['scheduled', 'en_route'] }, requestedStartAt: { gte: new Date() } }, orderBy: { requestedStartAt: 'asc' }, include: { psw: { include: { user: true } }, service: true } })
    ]);
    const totalBudget = 5000; const usedBudget = invoices.reduce((acc: number, inv: any) => acc + (Number(inv.total) || 0), 0);
    const spendingData = [{ name: 'Used', value: usedBudget }, { name: 'Remaining', value: Math.max(0, totalBudget - usedBudget) }];
    const wellnessData = entries.reverse().map((e: any) => ({ day: new Date(e.createdAt).toLocaleDateString('en-US', { weekday: 'short' }), mood: e.mood || 0, energy: Math.floor(Math.random() * 3) + (e.mood ? e.mood - 1 : 5) }));
    const pswCounts: Record<string, number> = {}; visits.forEach((v: any) => { if (v.psw?.id) pswCounts[v.psw.id] = (pswCounts[v.psw.id] || 0) + 1; });
    const totalVisits = visits.length || 1; const primaryCount = Object.values(pswCounts).reduce((acc, count) => acc + (count / totalVisits >= 0.3 ? count : 0), 0);
    const continuityData = [{ name: 'Primary Caregivers', value: Math.round((primaryCount / totalVisits) * 100) }, { name: 'Relief Staff', value: Math.round(((totalVisits - primaryCount) / totalVisits) * 100) }];
    const nextVisitFormatted = nextVisit ? { id: nextVisit.id, workerName: nextVisit.psw?.fullName || 'Unassigned', workerRole: nextVisit.service?.name || 'Personal Support Worker', arrivalTime: new Date(nextVisit.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }), bio: nextVisit.psw?.user?.bio || 'Looking forward to our visit today!', imageUrl: nextVisit.psw?.user?.avatarUrl || `https://ui-avatars.com/api/?name=${encodeURIComponent(nextVisit.psw?.fullName || 'U')}` } : null;
    return c.json({ budget: spendingData, wellness: wellnessData.length > 0 ? wellnessData : [{ day: 'N/A', mood: 0, energy: 0 }], continuity: continuityData, nextVisit: nextVisitFormatted }, 200);
}

export async function handleUpdateProfile(c: any) {
    const prisma = c.get('prisma'); const payload = c.get('jwtPayload');
    if (!payload) return c.json({ error: 'Unauthorized' }, 401);
    const data = c.req.valid('json'); const can = c.get('can');
    const profileExists = await prisma.clientProfile.findUnique({ where: { userId: payload.sub } });
    if (!profileExists) return c.json({ error: 'Profile not found' }, 404);
    if (!(await can('update', 'ClientProfile', profileExists.id))) return c.json({ error: 'Forbidden' }, 403);
    let lat = profileExists.lat; let lng = profileExists.lng;
    if (data.addressLine1 && data.addressLine1 !== profileExists.addressLine1) { const fullAddress = `${data.addressLine1}, ${data.city || profileExists.city || ''}, ${data.province || profileExists.province || ''}`; const geo = await geocodeAddress(fullAddress); if (geo) { lat = geo.lat; lng = geo.lng; } }
    const profile = await prisma.clientProfile.update({ where: { userId: payload.sub }, data: { fullName: data.fullName, addressLine1: data.addressLine1, city: data.city, province: data.province, postalCode: data.postalCode, emergencyName: data.emergencyName, emergencyPhone: data.emergencyPhone, lat, lng } });
    return c.json(profile, 200);
}

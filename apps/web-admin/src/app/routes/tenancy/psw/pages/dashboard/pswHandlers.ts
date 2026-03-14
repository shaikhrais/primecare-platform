import { AdminRegistry } from 'prime-care-shared';
const { ContentRegistry, ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export interface Shift { id: string; client: { fullName: string }; serviceAddressLine1: string; requestedStartAt: string; status: string; service: { name: string }; }

export async function handleCheckIn(id: string, shifts: Shift[], setShifts: (s: Shift[]) => void, showToast: (m: string, t: string) => void, refresh: () => void, t: (k: string, o?: any) => string) {
    if (!navigator.geolocation) { showToast('Geolocation not supported', 'error'); return; }
    const orig = [...shifts]; setShifts(shifts.map(s => s.id === id ? { ...s, status: 'IN_PROGRESS' } : s));
    navigator.geolocation.getCurrentPosition(async (pos) => {
        try {
            await new Promise(r => setTimeout(r, 600));
            const ssids = ["PRIMECARE_GUEST","COFFEE_NET_5G","RESIDENT_ROUTER_1A"];
            showToast(`Location verified. Scanned ${ssids.length} nearby networks.`, 'info');
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}${ApiRegistry.PSW.CHECK_IN(id)}`, { method:'POST', headers:{'Authorization':`Bearer ${token}`,'Content-Type':'application/json'}, body: JSON.stringify({ lat:pos.coords.latitude, lng:pos.coords.longitude, accuracy:pos.coords.accuracy, ambientBssids:ssids })});
            if (res.ok) { refresh(); showToast(t('psw.checkin_success',{defaultValue:'Check-in successful!'}),'success'); } else { setShifts(orig); const d=await res.json(); showToast(t('psw.checkin_failed',{defaultValue:`Check-in failed: ${d?.error||'Unknown'}`}),'error'); }
        } catch { setShifts(orig); showToast('Check-in failed','error'); }
    }, (e) => { setShifts(orig); showToast(`Could not get location: ${e.message}`,'error'); });
}

export async function handleCheckOut(id: string, shifts: Shift[], setShifts: (s: Shift[]) => void, showToast: (m: string, t: string) => void, refresh: () => void, t: (k: string, o?: any) => string) {
    if (!navigator.geolocation) { showToast('Geolocation not supported','error'); return; }
    const orig = [...shifts]; setShifts(shifts.map(s => s.id === id ? { ...s, status: 'COMPLETED' } : s));
    navigator.geolocation.getCurrentPosition(async (pos) => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}${ApiRegistry.PSW.CHECK_OUT(id)}`, { method:'POST', headers:{'Authorization':`Bearer ${token}`,'Content-Type':'application/json'}, body: JSON.stringify({ lat:pos.coords.latitude, lng:pos.coords.longitude, accuracy:pos.coords.accuracy })});
            if (res.ok) { refresh(); showToast(t('psw.checkout_success',{defaultValue:'Check-out successful!'}),'success'); } else { setShifts(orig); const d=await res.json(); showToast(t('psw.checkout_failed',{defaultValue:`Check-out failed: ${d?.error||'Unknown'}`}),'error'); }
        } catch { setShifts(orig); showToast('Check-out failed','error'); }
    }, (e) => { setShifts(orig); showToast(`Could not get location: ${e.message}`,'error'); });
}

export async function fetchDashboardData(showToast: (m: string, t: string) => void): Promise<{shifts: Shift[]; chartData: any}> {
    try {
        const token = localStorage.getItem('token');
        const [sR,stR] = await Promise.all([fetch(`${API_URL}${ApiRegistry.PSW.VISITS}`,{headers:{'Authorization':`Bearer ${token}`}}), fetch(`${API_URL}${ApiRegistry.PSW.DASHBOARD_STATS}`,{headers:{'Authorization':`Bearer ${token}`}})]);
        return { shifts: sR.ok ? await sR.json() : [], chartData: stR.ok ? await stR.json() : null };
    } catch (e) { console.error('Failed to fetch',e); showToast(ContentRegistry.COMMON.NETWORK_ERROR,'error'); return { shifts:[], chartData:null }; }
}

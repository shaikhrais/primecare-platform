import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

interface CreateShiftModalProps {
    isOpen: boolean;
    onClose: () => void;
    mode?: 'shift' | 'assign';
}

export const CreateShiftModal: React.FC<CreateShiftModalProps> = ({ isOpen, onClose, mode = 'shift' }) => {
    const { showToast } = useNotification();
    const [loading, setLoading] = useState(false);
    const [clients, setClients] = useState<any[]>([]);
    const [staff, setStaff] = useState<any[]>([]);
    const [services, setServices] = useState<any[]>([]);

    const [form, setForm] = useState({
        clientId: '',
        staffId: '',
        serviceId: '',
        date: new Date().toISOString().split('T')[0],
        startTime: '09:00',
        endTime: '13:00',
        notes: '',
        priority: 'normal' as 'normal' | 'urgent',
    });

    useEffect(() => {
        if (isOpen) {
            fetchData();
            setForm({
                clientId: '', staffId: '', serviceId: '',
                date: new Date().toISOString().split('T')[0],
                startTime: '09:00', endTime: '13:00', notes: '', priority: 'normal',
            });
        }
    }, [isOpen]);

    const fetchData = async () => {
        try {
            const [c, u, s] = await Promise.all([
                apiClient.get('/v1/staff/customers'),
                apiClient.get('/v1/admin/users'),
                apiClient.get('/v1/admin/services'),
            ]);
            if (c.ok) setClients(await c.json());
            if (u.ok) { const users = await u.json(); setStaff(users.filter((u: any) => u.roles?.includes('psw') || u.roles?.includes('rn'))); }
            if (s.ok) setServices(await s.json());
        } catch (e) { console.error('Failed to fetch shift modal data', e); }
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            const payload = {
                clientId: form.clientId || undefined,
                assignedUserId: form.staffId || undefined,
                serviceId: form.serviceId || undefined,
                scheduledDate: form.date,
                startTime: form.startTime,
                endTime: form.endTime,
                notes: form.notes,
                priority: form.priority,
            };
            const res = await apiClient.post('/v1/admin/shifts', payload);
            if (res.ok) {
                showToast(mode === 'assign' ? 'Staff assigned successfully!' : 'Shift created successfully!', 'success');
                onClose();
            } else {
                const err = await res.json();
                showToast(err.error || 'Failed to create shift', 'error');
            }
        } catch { showToast('Network error creating shift', 'error'); }
        finally { setLoading(false); }
    };

    if (!isOpen) return null;

    const labelStyle = { display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '4px' } as const;
    const inputStyle = { width: '100%', boxSizing: 'border-box' as const, padding: '10px 12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' };

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }} data-cy="modal-create-shift">
            <div style={{ backgroundColor: 'white', padding: '28px', borderRadius: '16px', maxWidth: '520px', width: '90%', maxHeight: '90vh', overflowY: 'auto', position: 'relative' }}>
                <button onClick={onClose} style={{ position: 'absolute', top: '16px', right: '16px', background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer', color: '#94A3B8' }}>&times;</button>
                <h3 style={{ marginTop: 0, fontSize: '1.25rem', fontWeight: 800, color: '#0F172A' }}>
                    {mode === 'assign' ? '👥 Assign Staff to Shift' : '⏱️ Create New Shift'}
                </h3>
                <p style={{ color: '#94A3B8', fontSize: '0.8rem', margin: '4px 0 20px' }}>
                    {mode === 'assign' ? 'Select a staff member and assign to a shift' : 'Schedule a new shift for client care'}
                </p>

                <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    {mode === 'assign' && (
                        <div>
                            <label style={labelStyle}>Staff Member *</label>
                            <select value={form.staffId} onChange={e => setForm(p => ({ ...p, staffId: e.target.value }))} style={inputStyle} required>
                                <option value="">Select staff...</option>
                                {staff.map(s => <option key={s.id} value={s.id}>{s.fullName || s.email}</option>)}
                            </select>
                        </div>
                    )}

                    <div>
                        <label style={labelStyle}>Client</label>
                        <select value={form.clientId} onChange={e => setForm(p => ({ ...p, clientId: e.target.value }))} style={inputStyle}>
                            <option value="">Select client (optional)...</option>
                            {clients.map(c => <option key={c.id} value={c.id}>{c.fullName || c.user?.fullName || c.user?.email}</option>)}
                        </select>
                    </div>

                    <div>
                        <label style={labelStyle}>Service</label>
                        <select value={form.serviceId} onChange={e => setForm(p => ({ ...p, serviceId: e.target.value }))} style={inputStyle}>
                            <option value="">Select service...</option>
                            {services.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                        </select>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '12px' }}>
                        <div>
                            <label style={labelStyle}>Date *</label>
                            <input type="date" value={form.date} onChange={e => setForm(p => ({ ...p, date: e.target.value }))} style={inputStyle} required />
                        </div>
                        <div>
                            <label style={labelStyle}>Start *</label>
                            <input type="time" value={form.startTime} onChange={e => setForm(p => ({ ...p, startTime: e.target.value }))} style={inputStyle} required />
                        </div>
                        <div>
                            <label style={labelStyle}>End *</label>
                            <input type="time" value={form.endTime} onChange={e => setForm(p => ({ ...p, endTime: e.target.value }))} style={inputStyle} required />
                        </div>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
                        <div>
                            <label style={labelStyle}>Priority</label>
                            <select value={form.priority} onChange={e => setForm(p => ({ ...p, priority: e.target.value as any }))} style={inputStyle}>
                                <option value="normal">Normal</option>
                                <option value="urgent">Urgent</option>
                            </select>
                        </div>
                        {mode !== 'assign' && (
                            <div>
                                <label style={labelStyle}>Assign Staff</label>
                                <select value={form.staffId} onChange={e => setForm(p => ({ ...p, staffId: e.target.value }))} style={inputStyle}>
                                    <option value="">Open (unassigned)</option>
                                    {staff.map(s => <option key={s.id} value={s.id}>{s.fullName || s.email}</option>)}
                                </select>
                            </div>
                        )}
                    </div>

                    <div>
                        <label style={labelStyle}>Notes</label>
                        <textarea value={form.notes} onChange={e => setForm(p => ({ ...p, notes: e.target.value }))} placeholder="Optional shift notes..." rows={3} style={{ ...inputStyle, resize: 'vertical' as const }} />
                    </div>

                    <div style={{ display: 'flex', gap: '12px', marginTop: '4px' }}>
                        <button type="button" onClick={onClose} disabled={loading} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', background: 'white', color: '#64748B', fontWeight: 600, cursor: 'pointer' }}>Cancel</button>
                        <button type="submit" disabled={loading} data-cy="btn-submit-shift" style={{ flex: 2, padding: '12px', borderRadius: '8px', border: 'none', background: loading ? '#94A3B8' : '#004d40', color: 'white', fontWeight: 700, cursor: 'pointer' }}>
                            {loading ? 'Creating...' : (mode === 'assign' ? 'Assign Staff' : 'Create Shift')}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default CreateShiftModal;

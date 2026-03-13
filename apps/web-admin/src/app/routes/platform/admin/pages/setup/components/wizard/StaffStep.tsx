import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface StaffStepProps {
    data: any;
    setData: (data: any) => void;
    onBack: () => void;
    onSubmit: (e: React.FormEvent) => void;
    loading: boolean;
}

export const StaffStep: React.FC<StaffStepProps> = ({ data, setData, onBack, onSubmit, loading }) => {
    const { t } = useTranslation();

    return (
        <form data-cy="form-admin.staff-step" onSubmit={onSubmit}>
            <h2 data-cy="h2-admin.staff-step-0" style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>{t(ContentRegistry.SETUP_WIZARD.HEADERS.STEP_2)}</h2>
            <div style={{ display: 'grid', gap: '1.5rem' }}>
                <div>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Full Name</label>
                    <input data-cy="input-admin.staff-step-0" placeholder="e.g. Jane Doe" value={data.fullName} onChange={e => setData({ ...data, fullName: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                </div>
                <div>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Email Address</label>
                    <input data-cy="input-admin.staff-step-1" type="email" value={data.email} onChange={e => setData({ ...data, email: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                </div>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Role</label>
                        <select data-cy="select-admin.staff-step-0" value={data.role} onChange={e => setData({ ...data, role: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}>
                            <option value="psw">PSW</option>
                            <option value="rn">RN</option>
                        </select>
                    </div>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>SIN (For Payroll)</label>
                        <input data-cy="input-admin.staff-step-2" value={data.sin} onChange={e => setData({ ...data, sin: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                    </div>
                </div>
            </div>
            <div style={{ display: 'flex', gap: '1rem', marginTop: '2.5rem' }}>
                <button data-cy="btn-admin.staff-step-0" type="button" onClick={onBack} style={{ flex: 1, padding: '1rem', background: '#f3f4f6', fontWeight: '600', borderRadius: '0.75rem', border: '1px solid #d1d5db', cursor: 'pointer' }}>{t(ContentRegistry.SETUP_WIZARD.BUTTONS.BACK)}</button>
                <button data-cy="btn-admin.staff-step-1" type="submit" disabled={loading} style={{ flex: 2, padding: '1rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '0.75rem', border: 'none', cursor: 'pointer' }}>
                    {loading ? 'Saving...' : t(ContentRegistry.SETUP_WIZARD.BUTTONS.NEXT)}
                </button>
            </div>
        </form>
    );
};

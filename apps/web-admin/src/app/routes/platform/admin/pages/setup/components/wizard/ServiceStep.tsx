import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface ServiceStepProps {
    data: any;
    setData: (data: any) => void;
    onSubmit: (e: React.FormEvent) => void;
    loading: boolean;
}

export const ServiceStep: React.FC<ServiceStepProps> = ({ data, setData, onSubmit, loading }) => {
    const { t } = useTranslation();

    return (
        <form data-cy="form-admin.service-step" onSubmit={onSubmit}>
            <h2 data-cy="h2-admin.service-step-0" style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>{t(ContentRegistry.SETUP_WIZARD.HEADERS.STEP_1)}</h2>
            <div style={{ display: 'grid', gap: '1.5rem' }}>
                <div>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Service Name</label>
                    <input data-cy="input-admin.service-step-0" placeholder="e.g. Senior Daily Care" value={data.name} onChange={e => setData({ ...data, name: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                </div>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Hourly Rate ($)</label>
                        <input data-cy="input-admin.service-step-1" type="number" value={data.hourlyRate} onChange={e => setData({ ...data, hourlyRate: parseFloat(e.target.value) })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                    </div>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Category</label>
                        <select data-cy="select-admin.service-step-0" value={data.category} onChange={e => setData({ ...data, category: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}>
                            <option>Senior Care</option>
                            <option>Foot Care</option>
                            <option>Consulting</option>
                            <option>Training</option>
                        </select>
                    </div>
                </div>
                <div>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Description</label>
                    <textarea data-cy="textarea-admin.service-step" rows={3} value={data.description} onChange={e => setData({ ...data, description: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} />
                </div>
            </div>
            <button data-cy="btn-admin.service-step-0" type="submit" disabled={loading} style={{ width: '100%', marginTop: '2.5rem', padding: '1rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '0.75rem', border: 'none', cursor: 'pointer' }}>
                {loading ? 'Saving...' : t(ContentRegistry.SETUP_WIZARD.BUTTONS.NEXT)}
            </button>
        </form>
    );
};

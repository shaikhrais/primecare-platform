import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useNotification } from '@/shared/context/NotificationContext';

const { ApiRegistry } = AdminRegistry;

interface InlineCreateProps {
    onSuccess: (newId: string) => void;
    onCancel: () => void;
}

export const InlineCreateClient: React.FC<InlineCreateProps> = ({ onSuccess, onCancel }) => {
    const { showToast } = useNotification();
    const [name, setName] = useState('');

    const mutation = useApiMutation(ApiRegistry.ADMIN.USERS, {
        onSuccess: (data: any) => {
            showToast('Client created successfully!', 'success');
            onSuccess(data.clientProfile.id);
        },
        onError: () => {
            showToast('Failed to create client', 'error');
        },
    });

    const loading = mutation.isPending;

    const handleSubmit = async (e?: React.FormEvent | React.MouseEvent) => {
        if (e) e.preventDefault();
        const dummyEmail = `${name.replace(/\s+/g, '.').toLowerCase()}.${Date.now()}@mock-client.com`;
        mutation.mutate({
            email: dummyEmail,
            password: 'TempPassword123!',
            roles: ['client'],
            profile: { fullName: name, status: 'active' }
        });
    };

    return (
        <div data-cy="inline.client.container" style={{ padding: '1rem', backgroundColor: '#f0fdf4', border: '1px solid #bbf7d0', borderRadius: '0.5rem', marginBottom: '1rem' }}
             onKeyDown={(e) => { if (e.key === 'Enter') handleSubmit(); }}>
            <h4 style={{ margin: '0 0 0.5rem 0', fontSize: '0.875rem', color: '#166534' }}>Quick Create: Client</h4>
            <input 
                data-cy="inline.client.name"
                type="text" required placeholder="Full Name" value={name} onChange={e => setName(e.target.value)} disabled={loading}
                style={{ width: '100%', padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', marginBottom: '0.5rem' }} 
            />
            <div style={{ display: 'flex', gap: '0.5rem' }}>
                <button data-cy="inline.client.cancel" type="button" onClick={onCancel} disabled={loading} style={{ flex: 1, padding: '0.5rem', background: 'transparent', border: '1px solid #d1d5db', borderRadius: '0.375rem', cursor: 'pointer' }}>Cancel</button>
                <button data-cy="inline.client.save" type="button" onClick={handleSubmit} disabled={loading || !name} style={{ flex: 1, padding: '0.5rem', background: '#16a34a', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontWeight: 'bold' }}>Save</button>
            </div>
        </div>
    );
};

export const InlineCreateService: React.FC<InlineCreateProps> = ({ onSuccess, onCancel }) => {
    const { showToast } = useNotification();
    const [name, setName] = useState('');
    const [rate, setRate] = useState('50.00');

    const mutation = useApiMutation(ApiRegistry.ADMIN.SERVICES, {
        onSuccess: (data: any) => {
            showToast('Service created successfully!', 'success');
            onSuccess(data.id);
        },
        onError: () => {
            showToast('Failed to create service', 'error');
        },
    });

    const loading = mutation.isPending;

    const handleSubmit = async (e?: React.FormEvent | React.MouseEvent) => {
        if (e) e.preventDefault();
        mutation.mutate({
            name,
            slug: name.toLowerCase().replace(/\s+/g, '-'),
            baseRateHourly: parseFloat(rate)
        });
    };

    return (
        <div data-cy="inline.service.container" style={{ padding: '1rem', backgroundColor: '#eff6ff', border: '1px solid #bfdbfe', borderRadius: '0.5rem', marginBottom: '1rem' }}
             onKeyDown={(e) => { if (e.key === 'Enter') handleSubmit(); }}>
            <h4 style={{ margin: '0 0 0.5rem 0', fontSize: '0.875rem', color: '#1e40af' }}>Quick Create: Service</h4>
            <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '0.5rem' }}>
                <input 
                    data-cy="inline.service.name"
                    type="text" required placeholder="Service Name (e.g. RN Shift)" value={name} onChange={e => setName(e.target.value)} disabled={loading}
                    style={{ flex: 2, padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }} 
                />
                <input 
                    data-cy="inline.service.rate"
                    type="number" min="0" step="0.01" required placeholder="Hourly Rate" value={rate} onChange={e => setRate(e.target.value)} disabled={loading}
                    style={{ flex: 1, padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }} 
                />
            </div>
            <div style={{ display: 'flex', gap: '0.5rem' }}>
                <button data-cy="inline.service.cancel" type="button" onClick={onCancel} disabled={loading} style={{ flex: 1, padding: '0.5rem', background: 'transparent', border: '1px solid #d1d5db', borderRadius: '0.375rem', cursor: 'pointer' }}>Cancel</button>
                <button data-cy="inline.service.save" type="button" onClick={handleSubmit} disabled={loading || !name} style={{ flex: 1, padding: '0.5rem', background: '#2563eb', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontWeight: 'bold' }}>Save</button>
            </div>
        </div>
    );
};

export const InlineCreatePsw: React.FC<InlineCreateProps> = ({ onSuccess, onCancel }) => {
    const { showToast } = useNotification();
    const [name, setName] = useState('');

    const mutation = useApiMutation(ApiRegistry.ADMIN.USERS, {
        onSuccess: (data: any) => {
            showToast('Caregiver created successfully!', 'success');
            onSuccess(data.id);
        },
        onError: () => {
            showToast('Failed to create caregiver', 'error');
        },
    });

    const loading = mutation.isPending;

    const handleSubmit = async (e?: React.FormEvent | React.MouseEvent) => {
        if (e) e.preventDefault();
        const dummyEmail = `${name.replace(/\s+/g, '.').toLowerCase()}.${Date.now()}@mock-psw.com`;
        mutation.mutate({
            email: dummyEmail,
            password: 'TempPassword123!',
            roles: ['psw'],
            profile: { fullName: name, status: 'active' }
        });
    };

    return (
        <div data-cy="inline.psw.container" style={{ padding: '1rem', backgroundColor: '#faf5ff', border: '1px solid #e9d5ff', borderRadius: '0.5rem', marginBottom: '1rem' }}
             onKeyDown={(e) => { if (e.key === 'Enter') handleSubmit(); }}>
            <h4 style={{ margin: '0 0 0.5rem 0', fontSize: '0.875rem', color: '#6b21a8' }}>Quick Create: Caregiver (PSW)</h4>
            <input 
                data-cy="inline.psw.name"
                type="text" required placeholder="Full Name" value={name} onChange={e => setName(e.target.value)} disabled={loading}
                style={{ width: '100%', padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', marginBottom: '0.5rem' }} 
            />
            <div style={{ display: 'flex', gap: '0.5rem' }}>
                <button data-cy="inline.psw.cancel" type="button" onClick={onCancel} disabled={loading} style={{ flex: 1, padding: '0.5rem', background: 'transparent', border: '1px solid #d1d5db', borderRadius: '0.375rem', cursor: 'pointer' }}>Cancel</button>
                <button data-cy="inline.psw.save" type="button" onClick={handleSubmit} disabled={loading || !name} style={{ flex: 1, padding: '0.5rem', background: '#9333ea', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontWeight: 'bold' }}>Save</button>
            </div>
        </div>
    );
};

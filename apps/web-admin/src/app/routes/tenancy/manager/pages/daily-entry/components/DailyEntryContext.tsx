import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface DailyEntryContextProps {
    clients: any[];
    selectedClient: string;
    setSelectedClient: (id: string) => void;
    setIsDirty: (dirty: boolean) => void;
}

export const DailyEntryContext: React.FC<DailyEntryContextProps> = ({
    clients,
    selectedClient,
    setSelectedClient,
    setIsDirty
}) => {
    return (
        <div style={{ width: '300px', background: 'var(--bg-elev)', padding: '24px', borderRadius: '16px', border: '1px solid var(--line)' }}>
            <h2 style={{ fontSize: '1.2rem', marginBottom: '20px' }}>{ContentRegistry.DAILY_ENTRY.LEFT_PANEL_TITLE}</h2>

            <div style={{ marginBottom: '20px' }}>
                <label style={{ display: 'block', marginBottom: '8px', fontWeight: 600 }}>{ContentRegistry.DAILY_ENTRY.CLIENT_LABEL}</label>
                <select
                    data-cy="form.daily.client"
                    style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg-input)', color: 'var(--text)' }}
                    value={selectedClient}
                    onChange={(e) => {
                        setSelectedClient(e.target.value);
                        setIsDirty(true);
                    }}
                >
                    <option value="">{ContentRegistry.DAILY_ENTRY.CLIENT_PLACEHOLDER}</option>
                    {clients.map(c => <option key={c.id} value={c.id}>{c?.fullName || 'Unknown Client'}</option>)}
                </select>
            </div>

            <div style={{ marginTop: 'auto', padding: '16px', background: 'rgba(33, 150, 243, 0.1)', borderRadius: '8px', border: '1px solid rgba(33, 150, 243, 0.3)' }}>
                <h4 style={{ margin: '0 0 8px 0', color: '#2196f3' }}>{ContentRegistry.DAILY_ENTRY.TIP_TITLE}</h4>
                <p style={{ margin: 0, fontSize: '0.9rem', opacity: 0.8 }}>
                    {ContentRegistry.DAILY_ENTRY.TIP_CONTENT}
                </p>
            </div>
        </div>
    );
};

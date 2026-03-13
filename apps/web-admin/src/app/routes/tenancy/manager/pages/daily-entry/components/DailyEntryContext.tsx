import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { InlineCreateClient } from '@/shared/components/modals/components/InlineCreationForms';
import { apiClient } from '@/shared/utils/apiClient';

const { ContentRegistry } = AdminRegistry;

interface DailyEntryContextProps {
    clients: any[];
    selectedClient: string;
    setSelectedClient: (id: string) => void;
    setIsDirty: (dirty: boolean) => void;
    onRefreshClients?: () => void;
}

export const DailyEntryContext: React.FC<DailyEntryContextProps> = ({
    clients,
    selectedClient,
    setSelectedClient,
    setIsDirty,
    onRefreshClients
}) => {
    const [isCreatingClient, setIsCreatingClient] = useState(false);
    return (
        <div style={{ width: '300px', background: 'var(--bg-elev)', padding: '24px', borderRadius: '16px', border: '1px solid var(--line)' }}>
            <h2 style={{ fontSize: '1.2rem', marginBottom: '20px' }}>{ContentRegistry.DAILY_ENTRY.LEFT_PANEL_TITLE}</h2>

            <div style={{ marginBottom: '20px' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
                    <label style={{ fontWeight: 600 }}>{ContentRegistry.DAILY_ENTRY.CLIENT_LABEL}</label>
                    {!isCreatingClient && (
                        <button
                            data-cy="btn-create-client-inline"
                            type="button"
                            onClick={() => setIsCreatingClient(true)}
                            style={{ fontSize: '0.75rem', color: '#2563eb', fontWeight: '600', background: 'none', border: 'none', cursor: 'pointer' }}
                        >
                            + Create New
                        </button>
                    )}
                </div>
                {isCreatingClient ? (
                    <InlineCreateClient
                        onCancel={() => setIsCreatingClient(false)}
                        onSuccess={(newId) => {
                            setSelectedClient(newId);
                            setIsCreatingClient(false);
                            setIsDirty(true);
                            onRefreshClients?.();
                        }}
                    />
                ) : (
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
                )}
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

import React from 'react';

interface SharedProps {
    disabled?: boolean;
}

interface ClientServiceFieldsProps extends SharedProps {
    clientId: string;
    serviceId: string;
    clients: any[];
    services: any[];
    onClientChange: (e: React.ChangeEvent<HTMLSelectElement>) => void;
    onServiceChange: (e: React.ChangeEvent<HTMLSelectElement>) => void;
    fixedClientName?: string;
}

export const ClientServiceFields: React.FC<ClientServiceFieldsProps> = ({
    clientId, serviceId, clients, services, onClientChange, onServiceChange, fixedClientName, disabled
}) => {
    return (
        <>
            <div>
                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Client</label>
                {fixedClientName ? (
                    <div style={{ padding: '0.75rem', backgroundColor: '#f9fafb', borderRadius: '0.5rem', border: '1px solid #d1d5db', fontWeight: '600' }}>
                        {fixedClientName}
                    </div>
                ) : (
                    <select
                        data-cy="inp-client-id"
                        required
                        value={clientId}
                        onChange={onClientChange}
                        disabled={disabled}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    >
                        <option value="">Select a client</option>
                        {clients.map(c => (
                            <option key={c.id} value={c.id}>{c.fullName}</option>
                        ))}
                    </select>
                )}
            </div>

            <div>
                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Service Type</label>
                <select
                    data-cy="inp-service-id"
                    required
                    value={serviceId}
                    onChange={onServiceChange}
                    disabled={disabled}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                >
                    <option value="">Select a service</option>
                    {services.map(s => (
                        <option key={s.id} value={s.id}>{s.name}</option>
                    ))}
                </select>
            </div>
        </>
    );
};

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
    onCreateClient?: () => void;
    onCreateService?: () => void;
    isCreatingClient?: boolean;
    isCreatingService?: boolean;
    inlineClientForm?: React.ReactNode;
    inlineServiceForm?: React.ReactNode;
}

export const ClientServiceFields: React.FC<ClientServiceFieldsProps> = ({
    clientId, serviceId, clients, services, onClientChange, onServiceChange, fixedClientName, disabled,
    onCreateClient, onCreateService, isCreatingClient, isCreatingService, inlineClientForm, inlineServiceForm
}) => {
    return (
        <>
            <div>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
                    <label style={{ fontSize: '0.875rem', fontWeight: '500' }}>Client</label>
                    {onCreateClient && (
                        <button data-cy="btn-create-client-inline" type="button" onClick={onCreateClient} disabled={disabled} style={{ background: 'none', border: 'none', color: '#004d40', fontSize: '0.75rem', fontWeight: 'bold', cursor: 'pointer' }}>
                            + Create Client
                        </button>
                    )}
                </div>
                {fixedClientName ? (
                    <div style={{ padding: '0.75rem', backgroundColor: '#f9fafb', borderRadius: '0.5rem', border: '1px solid #d1d5db', fontWeight: '600' }}>
                        {fixedClientName}
                    </div>
                ) : isCreatingClient ? (
                    inlineClientForm
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
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
                    <label style={{ fontSize: '0.875rem', fontWeight: '500' }}>Service Type</label>
                    {onCreateService && !isCreatingService && (
                        <button data-cy="btn-create-service-inline" type="button" onClick={onCreateService} disabled={disabled} style={{ background: 'none', border: 'none', color: '#004d40', fontSize: '0.75rem', fontWeight: 'bold', cursor: 'pointer' }}>
                            + Create Service
                        </button>
                    )}
                </div>
                {isCreatingService ? (
                    inlineServiceForm
                ) : (
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
                )}
            </div>
        </>
    );
};

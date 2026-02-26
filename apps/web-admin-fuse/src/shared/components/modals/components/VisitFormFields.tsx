import React from 'react';

// Interfaces for props
interface SharedProps {
    disabled?: boolean;
}

interface User {
    id: string;
    fullName?: string;
    email: string;
    roles: string[];
    pswProfile?: { id: string; fullName: string; };
}

// --- Client & Service Selection ---
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

// --- Date & Time ---
interface DateTimeFieldsProps extends SharedProps {
    requestedStartAt: string;
    durationMinutes: number;
    onStartChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
    onDurationChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const DateTimeFields: React.FC<DateTimeFieldsProps> = ({
    requestedStartAt, durationMinutes, onStartChange, onDurationChange, disabled
}) => {
    return (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
            <div>
                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Date & Time</label>
                <input
                    data-cy="inp-start-at"
                    type="datetime-local"
                    required
                    value={requestedStartAt}
                    onChange={onStartChange}
                    disabled={disabled}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                />
            </div>
            <div>
                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Duration (min)</label>
                <input
                    data-cy="inp-duration"
                    type="number"
                    required
                    min="30"
                    step="15"
                    value={durationMinutes}
                    onChange={onDurationChange}
                    disabled={disabled}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                />
            </div>
        </div>
    );
};

// --- Assignment & PSW ---
interface AssignmentFieldsProps extends SharedProps {
    assignmentType: 'open' | 'direct';
    assignedPswId: string;
    psws: any[];
    onTypeChange: (type: 'open' | 'direct') => void;
    onPswChange: (e: React.ChangeEvent<HTMLSelectElement>) => void;
}

export const AssignmentFields: React.FC<AssignmentFieldsProps> = ({
    assignmentType, assignedPswId, psws, onTypeChange, onPswChange, disabled
}) => {
    return (
        <>
            <div>
                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Shift Type</label>
                <div style={{ display: 'flex', gap: '1rem' }}>
                    <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer' }}>
                        <input
                            type="radio"
                            name="assignmentType"
                            value="open"
                            checked={assignmentType === 'open'}
                            onChange={() => onTypeChange('open')}
                            disabled={disabled}
                        />
                        Open Shift (Any PSW)
                    </label>
                    <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer' }}>
                        <input
                            type="radio"
                            name="assignmentType"
                            value="direct"
                            checked={assignmentType === 'direct'}
                            onChange={() => onTypeChange('direct')}
                            disabled={disabled}
                        />
                        Direct Assign
                    </label>
                </div>
            </div>

            {assignmentType === 'direct' && (
                <div>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Select PSW</label>
                    <select
                        data-cy="inp-psw-id"
                        required={assignmentType === 'direct'}
                        value={assignedPswId}
                        onChange={onPswChange}
                        disabled={disabled}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    >
                        <option value="">Select a caregiver</option>
                        {psws.map(psw => (
                            <option key={psw.id} value={psw.pswProfile?.id || psw.id}>
                                {psw.pswProfile?.fullName || psw.email}
                            </option>
                        ))}
                    </select>
                </div>
            )}
        </>
    );
};

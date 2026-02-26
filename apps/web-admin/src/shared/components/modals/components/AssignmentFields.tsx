import React from 'react';

interface SharedProps {
    disabled?: boolean;
}

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

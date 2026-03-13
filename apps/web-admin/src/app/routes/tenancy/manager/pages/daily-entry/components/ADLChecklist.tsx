import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface ADLChecklistProps {
    adl: any;
    setAdl: (adl: any) => void;
    setIsDirty: (dirty: boolean) => void;
}

export const ADLChecklist: React.FC<ADLChecklistProps> = ({ adl, setAdl, setIsDirty }) => {
    return (
        <div>
            <h3 data-cy="h3-manager.a-d-l-checklist-0" style={{ borderBottom: '2px solid var(--line)', paddingBottom: '8px', marginBottom: '16px' }}>{ContentRegistry.DAILY_ENTRY.ADL_TITLE}</h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {Object.keys(adl).map(key => (
                    <label key={key} style={{ display: 'flex', alignItems: 'center', gap: '12px', cursor: 'pointer', padding: '12px', background: 'var(--bg)', borderRadius: '8px', border: '1px solid var(--line)' }}>
                        <input
                            data-cy={`form.daily.adl.${key}`}
                            type="checkbox"
                            checked={(adl as any)[key]}
                            onChange={(e) => {
                                setAdl({ ...adl, [key]: e.target.checked });
                                setIsDirty(true);
                            }}
                            style={{ width: '20px', height: '20px' }}
                        />
                        <span style={{ textTransform: 'capitalize', fontWeight: 600 }}>{key}</span>
                    </label>
                ))}
            </div>
        </div>
    );
};

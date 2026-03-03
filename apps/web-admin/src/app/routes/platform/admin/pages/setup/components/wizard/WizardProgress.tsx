import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

type Step = 'services' | 'staff' | 'clients' | 'success';

interface WizardProgressProps {
    currentStep: Step;
}

export const WizardProgress: React.FC<WizardProgressProps> = ({ currentStep }) => {
    const { t } = useTranslation();

    const steps: { key: Step; label: string }[] = [
        { key: 'services', label: t(ContentRegistry.SETUP_WIZARD.STEPS.SERVICES) },
        { key: 'staff', label: t(ContentRegistry.SETUP_WIZARD.STEPS.STAFF) },
        { key: 'clients', label: t(ContentRegistry.SETUP_WIZARD.STEPS.CLIENTS) },
        { key: 'success', label: t(ContentRegistry.SETUP_WIZARD.STEPS.FINISH) },
    ];

    return (
        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '3rem', position: 'relative' }}>
            <div style={{ position: 'absolute', top: '15px', left: 0, right: 0, height: '2px', background: '#e5e7eb', zIndex: 0 }} />
            {steps.map((s, idx) => {
                const isActive = currentStep === s.key;
                const isCompleted = steps.findIndex(step => step.key === currentStep) > idx;
                return (
                    <div key={s.key} style={{ zIndex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', width: '80px' }}>
                        <div style={{
                            width: '32px',
                            height: '32px',
                            borderRadius: '50%',
                            background: isActive ? '#004d40' : (isCompleted ? '#059669' : 'white'),
                            border: `2px solid ${isActive || isCompleted ? 'transparent' : '#d1d5db'}`,
                            color: isActive || isCompleted ? 'white' : '#6b7280',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            fontWeight: 'bold',
                            fontSize: '0.875rem',
                            marginBottom: '0.5rem',
                            boxShadow: isActive ? '0 0 0 4px rgba(0, 77, 64, 0.1)' : 'none'
                        }}>
                            {isCompleted ? '✓' : idx + 1}
                        </div>
                        <span style={{ fontSize: '0.75rem', fontWeight: isActive ? 'bold' : '500', color: isActive ? '#111827' : '#6b7280', textAlign: 'center' }}>{s.label}</span>
                    </div>
                );
            })}
        </div>
    );
};

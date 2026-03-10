import React, { useState } from 'react';
import { ChevronRight, ChevronLeft, CheckCircle } from 'lucide-react';

interface WizardStep {
    title: string;
    description: string;
    image?: string;
    criticalWarning?: string;
}

interface TaskCarouselWizardProps {
    taskName: string;
    steps: WizardStep[];
    onComplete: () => void;
    onClose: () => void;
}

export const TaskCarouselWizard: React.FC<TaskCarouselWizardProps> = ({ taskName, steps, onComplete, onClose }) => {
    const [currentStep, setCurrentStep] = useState(0);

    const handleNext = () => {
        if (currentStep < steps.length - 1) {
            setCurrentStep(prev => prev + 1);
        } else {
            onComplete();
        }
    };

    return (
        <div style={{ position: 'fixed', inset: 0, zIndex: 9999, display: 'flex', alignItems: 'center', justifyContent: 'center', backgroundColor: 'rgba(0,0,0,0.7)', padding: '20px' }}>
            <div style={{ backgroundColor: '#fff', borderRadius: '16px', width: '100%', maxWidth: '400px', overflow: 'hidden', display: 'flex', flexDirection: 'column', height: '80vh', maxHeight: '600px' }}>

                {/* Header */}
                <div style={{ padding: '16px', borderBottom: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <h2 style={{ margin: 0, fontSize: '1.2rem', fontWeight: 800 }}>{taskName}</h2>
                    <button onClick={onClose} style={{ border: 'none', background: '#F3F4F6', borderRadius: '50%', width: '32px', height: '32px', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer', fontWeight: 600 }}>✕</button>
                </div>

                {/* Content */}
                <div style={{ flex: 1, padding: '24px', overflowY: 'auto', display: 'flex', flexDirection: 'column' }}>
                    <div style={{ color: '#6B7280', fontSize: '0.9rem', fontWeight: 700, textTransform: 'uppercase', marginBottom: '16px', letterSpacing: '1px' }}>
                        Step {currentStep + 1} of {steps.length}
                    </div>

                    <h3 style={{ margin: '0 0 16px 0', fontSize: '1.5rem', fontWeight: 900, lineHeight: 1.2 }}>
                        {steps[currentStep].title}
                    </h3>

                    {steps[currentStep].image && (
                        <div style={{ width: '100%', height: '180px', backgroundColor: '#F3F4F6', borderRadius: '12px', marginBottom: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '3rem' }}>
                            {steps[currentStep].image}
                        </div>
                    )}

                    <p style={{ fontSize: '1.1rem', color: '#374151', lineHeight: 1.6, margin: '0 0 24px 0' }}>
                        {steps[currentStep].description}
                    </p>

                    {steps[currentStep].criticalWarning && (
                        <div style={{ backgroundColor: '#FEF2F2', borderLeft: '4px solid #EF4444', padding: '12px', borderRadius: '4px', color: '#991B1B', fontWeight: 600, fontSize: '0.9rem', marginTop: 'auto' }}>
                            ⚠️ {steps[currentStep].criticalWarning}
                        </div>
                    )}
                </div>

                {/* Footer Controls */}
                <div style={{ padding: '16px', borderTop: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#F9FAFB' }}>
                    <button
                        onClick={() => setCurrentStep(prev => Math.max(0, prev - 1))}
                        disabled={currentStep === 0}
                        style={{ border: 'none', background: 'transparent', padding: '12px', color: currentStep === 0 ? '#D1D5DB' : '#4B5563', cursor: currentStep === 0 ? 'default' : 'pointer', display: 'flex', alignItems: 'center' }}
                    >
                        <ChevronLeft size={24} />
                    </button>

                    <div style={{ display: 'flex', gap: '6px' }}>
                        {steps.map((_, idx) => (
                            <div key={idx} style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: idx === currentStep ? '#4F46E5' : '#D1D5DB' }} />
                        ))}
                    </div>

                    <button
                        onClick={handleNext}
                        style={{
                            border: 'none', background: currentStep === steps.length - 1 ? '#10B981' : '#4F46E5', color: 'white',
                            padding: '12px 24px', borderRadius: '24px', fontWeight: 800, fontSize: '1rem', cursor: 'pointer',
                            display: 'flex', alignItems: 'center', gap: '8px'
                        }}
                    >
                        {currentStep === steps.length - 1 ? (
                            <><CheckCircle size={18} /> Complete</>
                        ) : (
                            <>Next <ChevronRight size={18} /></>
                        )}
                    </button>
                </div>

            </div>
        </div>
    );
};

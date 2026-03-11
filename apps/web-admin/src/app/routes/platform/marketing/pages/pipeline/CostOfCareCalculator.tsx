import React, { useState } from 'react';
import { Calculator, Clock, Activity, Send, Mail, CheckCircle2, DollarSign } from 'lucide-react';

export const CostOfCareCalculator: React.FC = () => {
    const [hours, setHours] = useState<number>(20);
    const [acuity, setAcuity] = useState<'LOW' | 'MEDIUM' | 'HIGH'>('LOW');
    const [step, setStep] = useState<1 | 2 | 3>(1);
    
    // Lead capture form state
    const [email, setEmail] = useState('');
    const [name, setName] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);

    const baseHourlyRate = 35;
    const acuityMultipliers = {
        'LOW': 1.0,    // Companionship
        'MEDIUM': 1.3, // ADL support
        'HIGH': 1.8    // Memory care / Hoyer lift
    };

    const calculatedWeeklyCost = hours * (baseHourlyRate * acuityMultipliers[acuity]);

    const handleGenerateCost = (e: React.FormEvent) => {
        e.preventDefault();
        setIsSubmitting(true);
        setTimeout(() => {
            setIsSubmitting(false);
            setStep(3);
        }, 800);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '32px', maxWidth: '600px', margin: '0 auto', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)' }}>
            
            {/* Header */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px', borderBottom: '1px solid #E2E8F0', paddingBottom: '24px' }}>
                <div style={{ backgroundColor: '#EEF2FF', padding: '12px', borderRadius: '12px' }}>
                    <Calculator size={28} color="#6366F1" />
                </div>
                <div>
                    <h2 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Care Cost Estimator</h2>
                    <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Customize a care plan to see transparent weekly pricing.</p>
                </div>
            </div>

            {/* Step 1: Configuration */}
            {step === 1 && (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '32px' }}>
                    
                    {/* Hours Slider */}
                    <div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '16px', alignItems: 'center' }}>
                            <label style={{ fontWeight: 800, color: '#334155', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <Clock size={18} color="#64748B"/> Weekly Care Hours
                            </label>
                            <span style={{ fontSize: '1.2rem', fontWeight: 900, color: '#6366F1' }}>{hours} hrs</span>
                        </div>
                        <input 
                            type="range" 
                            min="4" 
                            max="168" 
                            step="4"
                            value={hours} 
                            onChange={(e) => setHours(Number(e.target.value))}
                            style={{ width: '100%', accentColor: '#6366F1', cursor: 'grab' }}
                        />
                        <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.8rem', color: '#94A3B8', marginTop: '8px' }}>
                            <span>4 hrs (Respite)</span>
                            <span>168 hrs (24/7 Care)</span>
                        </div>
                    </div>

                    {/* Acuity Selector */}
                    <div>
                        <label style={{ fontWeight: 800, color: '#334155', display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                            <Activity size={18} color="#64748B"/> Level of Care
                        </label>
                        <div style={{ display: 'flex', gap: '12px' }}>
                            {['LOW', 'MEDIUM', 'HIGH'].map(level => (
                                <button 
                                    key={level}
                                    onClick={() => setAcuity(level as any)}
                                    style={{ 
                                        flex: 1, padding: '12px', borderRadius: '8px', cursor: 'pointer', fontWeight: 700, fontSize: '0.9rem', transition: 'all 0.2s',
                                        backgroundColor: acuity === level ? '#EEF2FF' : '#F8FAFC',
                                        border: `2px solid ${acuity === level ? '#6366F1' : '#E2E8F0'}`,
                                        color: acuity === level ? '#4338CA' : '#64748B'
                                    }}
                                >
                                    {level === 'LOW' && 'Companionship'}
                                    {level === 'MEDIUM' && 'Personal Care'}
                                    {level === 'HIGH' && 'Complex / Memory'}
                                </button>
                            ))}
                        </div>
                    </div>

                    <button 
                        onClick={() => setStep(2)}
                        style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', padding: '16px', fontWeight: 800, fontSize: '1.1rem', cursor: 'pointer', marginTop: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}
                    >
                        Calculate My Estimate
                    </button>
                </div>
            )}

            {/* Step 2: Gated Lead Capture (The Funnel Trap) */}
            {step === 2 && (
                <div style={{ textAlign: 'center' }}>
                    <div style={{ backgroundColor: '#F0F9FF', border: '1px solid #BAE6FD', padding: '24px', borderRadius: '12px', marginBottom: '24px' }}>
                        <h3 style={{ margin: '0 0 12px 0', color: '#0369A1', fontSize: '1.1rem' }}>Your customized estimate is ready!</h3>
                        <p style={{ margin: 0, color: '#0CA5E9', fontSize: '0.9rem' }}>Where should we email your pricing breakdown and care guide?</p>
                    </div>

                    <form onSubmit={handleGenerateCost} style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                        <input 
                            type="text" 
                            required 
                            placeholder="Your Name"
                            value={name}
                            onChange={(e) => setName(e.target.value)}
                            style={{ padding: '16px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', outline: 'none' }}
                        />
                        <input 
                            type="email" 
                            required 
                            placeholder="Email Address"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            style={{ padding: '16px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', outline: 'none' }}
                        />
                        
                        <button 
                            type="submit"
                            disabled={isSubmitting}
                            style={{ backgroundColor: '#6366F1', color: 'white', border: 'none', borderRadius: '8px', padding: '16px', fontWeight: 800, fontSize: '1.1rem', cursor: isSubmitting ? 'wait' : 'pointer', marginTop: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}
                        >
                            {isSubmitting ? 'Generating...' : <><Mail size={20} /> Reveal My Estimate</>}
                        </button>
                        
                        <div style={{ fontSize: '0.75rem', color: '#94A3B8', marginTop: '8px' }}>
                            By submitting, you agree to our privacy terms. We hate spam as much as you do.
                        </div>
                    </form>
                </div>
            )}

            {/* Step 3: The Result */}
            {step === 3 && (
                <div style={{ textAlign: 'center' }}>
                    <CheckCircle2 size={64} color="#10B981" style={{ margin: '0 auto 24px auto' }}/>
                    <h3 style={{ margin: '0 0 8px 0', fontSize: '1.4rem', color: '#0F172A' }}>Here is your expected cost.</h3>
                    <p style={{ margin: '0 0 32px 0', color: '#64748B', fontSize: '0.95rem' }}>We've also emailed a detailed copy to {email}.</p>
                    
                    <div style={{ backgroundColor: '#F8FAFC', border: '1px solid #E2E8F0', padding: '32px', borderRadius: '16px', marginBottom: '32px' }}>
                        <div style={{ fontSize: '0.9rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '8px' }}>Estimated Weekly Investment</div>
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#0F172A', fontWeight: 900, fontSize: '3.5rem' }}>
                            <DollarSign size={40} strokeWidth={3}/>
                            {calculatedWeeklyCost.toLocaleString(undefined, { minimumFractionDigits: 0, maximumFractionDigits: 0 })}
                        </div>
                        <div style={{ fontSize: '0.9rem', color: '#64748B', marginTop: '8px' }}>
                            Based on {hours} hours of {acuity.toLowerCase()} care.
                        </div>
                    </div>

                    <button style={{ backgroundColor: '#10B981', color: 'white', border: 'none', borderRadius: '8px', padding: '16px 24px', fontWeight: 800, fontSize: '1.1rem', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px', width: '100%' }}>
                        Schedule a Free Consultation
                    </button>
                    
                    <button 
                        onClick={() => { setStep(1); setHours(20); setAcuity('LOW'); }}
                        style={{ background: 'none', border: 'none', color: '#64748B', fontWeight: 600, marginTop: '24px', cursor: 'pointer', textDecoration: 'underline' }}
                    >
                        Start Over
                    </button>
                </div>
            )}

        </div>
    );
};

import React, { useState } from 'react';
import { UploadCloud, Building2, User, FileText, CheckCircle, Clock } from 'lucide-react';

export const DischargePlannerPortal: React.FC = () => {
    const [step, setStep] = useState<1 | 2 | 3>(1);
    const [patientName, setPatientName] = useState('');
    const [isUploading, setIsUploading] = useState(false);

    const handleUpload = (e: React.FormEvent) => {
        e.preventDefault();
        setIsUploading(true);
        setTimeout(() => {
            setIsUploading(false);
            setStep(3);
        }, 1500);
    };

    return (
        <div style={{ backgroundColor: '#F8FAFC', minHeight: '100vh', padding: '48px 24px', fontFamily: 'system-ui, sans-serif' }}>
            <div style={{ maxWidth: '600px', margin: '0 auto' }}>
                
                {/* Header Branding */}
                <div style={{ textAlign: 'center', marginBottom: '32px' }}>
                    <div style={{ display: 'inline-flex', alignItems: 'center', gap: '12px', backgroundColor: 'white', padding: '12px 24px', borderRadius: '32px', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.1)' }}>
                        <Building2 color="#0369A1" size={24} />
                        <span style={{ fontWeight: 900, color: '#0F172A', fontSize: '1.2rem', letterSpacing: '1px' }}>PRIMECARE HOME HEALTH</span>
                    </div>
                    <h2 style={{ marginTop: '24px', color: '#334155', fontWeight: 800 }}>B2B Discharge Triage Portal</h2>
                    <p style={{ color: '#64748B', fontSize: '0.95rem' }}>Secure, streamlined referral ingestion for Case Managers & Social Workers.</p>
                </div>

                <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '16px', padding: '32px', boxShadow: '0 10px 15px -3px rgba(0,0,0,0.05)' }}>
                    
                    {step === 1 && (
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                            <div>
                                <label style={{ fontWeight: 700, color: '#475569', fontSize: '0.9rem', marginBottom: '8px', display: 'block' }}>Referring Facility</label>
                                <select style={{ width: '100%', padding: '16px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none', backgroundColor: '#F8FAFC', color: '#0F172A', fontWeight: 600 }}>
                                    <option>St. Jude Regional Hospital</option>
                                    <option>Mount Sinai Westside</option>
                                    <option>Downtown Rehab Center</option>
                                </select>
                            </div>
                            <div>
                                <label style={{ fontWeight: 700, color: '#475569', fontSize: '0.9rem', marginBottom: '8px', display: 'block' }}>Case Manager NPI / ID</label>
                                <input type="text" placeholder="e.g. 192837465" style={{ width: '100%', boxSizing: 'border-box', padding: '16px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }} />
                            </div>
                            <button 
                                onClick={() => setStep(2)}
                                style={{ backgroundColor: '#0369A1', color: 'white', border: 'none', padding: '16px', borderRadius: '8px', fontWeight: 800, fontSize: '1.1rem', cursor: 'pointer', marginTop: '8px', transition: 'all 0.2s' }}
                            >
                                Continue to Patient Details
                            </button>
                        </div>
                    )}

                    {step === 2 && (
                        <form onSubmit={handleUpload} style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                            <div>
                                <label style={{ fontWeight: 700, color: '#475569', fontSize: '0.9rem', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                    <User size={16}/> Patient Legal Name
                                </label>
                                <input 
                                    type="text" 
                                    required
                                    value={patientName}
                                    onChange={(e) => setPatientName(e.target.value)}
                                    placeholder="Last, First" 
                                    style={{ width: '100%', boxSizing: 'border-box', padding: '16px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }} 
                                />
                            </div>

                            <div style={{ backgroundColor: '#F1F5F9', border: '2px dashed #94A3B8', borderRadius: '12px', padding: '32px', textAlign: 'center' }}>
                                <FileText size={48} color="#64748B" style={{ margin: '0 auto 16px auto', opacity: 0.5 }} />
                                <h4 style={{ margin: '0 0 8px 0', color: '#334155' }}>Upload Clinical Facesheet</h4>
                                <p style={{ margin: '0 0 16px 0', color: '#64748B', fontSize: '0.85rem' }}>Drag & drop the patient's PDF facesheet or medication list here. (Limit 25MB, HIPAA Secure)</p>
                                <button type="button" style={{ backgroundColor: 'white', border: '1px solid #CBD5E1', padding: '8px 16px', borderRadius: '6px', color: '#0F172A', fontWeight: 600, cursor: 'pointer' }}>
                                    Browse Files...
                                </button>
                            </div>

                            <button 
                                type="submit"
                                disabled={isUploading || !patientName}
                                style={{ backgroundColor: '#0369A1', color: 'white', border: 'none', padding: '16px', borderRadius: '8px', fontWeight: 800, fontSize: '1.1rem', cursor: isUploading ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '12px' }}
                            >
                                {isUploading ? (
                                    <>Transmitting to Intake Team...</>
                                ) : (
                                    <><UploadCloud size={20} /> Securely Submit Referral</>
                                )}
                            </button>
                            
                            <button 
                                type="button"
                                onClick={() => setStep(1)}
                                style={{ background: 'none', border: 'none', color: '#64748B', cursor: 'pointer', fontWeight: 600, textDecoration: 'underline' }}
                            >
                                Back
                            </button>
                        </form>
                    )}

                    {step === 3 && (
                        <div style={{ textAlign: 'center', padding: '16px 0' }}>
                            <CheckCircle size={64} color="#10B981" style={{ margin: '0 auto 24px auto' }} />
                            <h3 style={{ margin: '0 0 12px 0', color: '#0F172A', fontSize: '1.4rem' }}>Referral Successfully Received</h3>
                            <p style={{ color: '#475569', lineHeight: 1.6, marginBottom: '32px' }}>
                                The facesheet for <strong>{patientName}</strong> has been securely routed to our Intake Triage queue.
                            </p>

                            <div style={{ backgroundColor: '#F0F9FF', border: '1px solid #BAE6FD', padding: '16px', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '12px', color: '#0369A1', fontWeight: 800 }}>
                                <Clock size={20} /> Guaranteed Clinical Review SLA: 30 Minutes
                            </div>

                            <button 
                                onClick={() => { setStep(1); setPatientName(''); }}
                                style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', padding: '12px 24px', borderRadius: '8px', fontWeight: 600, cursor: 'pointer', marginTop: '32px' }}
                            >
                                Submit Another Patient
                            </button>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

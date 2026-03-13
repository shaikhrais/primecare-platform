import React, { useState } from 'react';
import { ShieldCheck, XCircle, FileSignature, CheckCircle2, UserCheck, AlertTriangle } from 'lucide-react';

interface Testimonial {
    id: string;
    patientName: string;
    caregiverName: string;
    quote: string;
    source: 'INTERNAL_SURVEY' | 'DISCHARGE_CALL' | 'APP_FEEDBACK';
    date: string;
    hipaaReleaseSigned: boolean;
    photoAssigned: boolean;
    status: 'READY_FOR_MARKETING' | 'AWAITING_LEGAL' | 'REJECTED';
}

export const TestimonialReleaseTracker: React.FC = () => {
    const [testimonials, setTestimonials] = useState<Testimonial[]>([
        { id: '1', patientName: 'Robert M.', caregiverName: 'Maria G.', quote: 'Maria is an angel. I do not know how our family would have survived the winter without her.', source: 'INTERNAL_SURVEY', date: '2023-11-02', hipaaReleaseSigned: true, photoAssigned: true, status: 'READY_FOR_MARKETING' },
        { id: '2', patientName: 'Eleanor F.', caregiverName: 'David T.', quote: 'David made my husband laugh, which is something I had not seen in months.', source: 'DISCHARGE_CALL', date: '2023-10-28', hipaaReleaseSigned: false, photoAssigned: false, status: 'AWAITING_LEGAL' },
        { id: '3', patientName: 'James W. (Son)', caregiverName: 'Sarah L.', quote: 'The overnight care was exactly what we needed. Highly recommend PrimeCare.', source: 'APP_FEEDBACK', date: '2023-10-15', hipaaReleaseSigned: true, photoAssigned: false, status: 'AWAITING_LEGAL' },
        { id: '4', patientName: 'Betty C.', caregiverName: 'Clinician Team', quote: 'They helped me recover from my hip surgery so fast.', source: 'INTERNAL_SURVEY', date: '2023-09-02', hipaaReleaseSigned: false, photoAssigned: false, status: 'REJECTED' },
    ]);

    const handleSendWaiver = (id: string) => {
        setTestimonials(testimonials.map(t => 
            t.id === id ? { ...t, hipaaReleaseSigned: true, status: t.photoAssigned ? 'READY_FOR_MARKETING' : 'AWAITING_LEGAL' } : t
        ));
    };

    const getStatusBadge = (status: Testimonial['status']) => {
        switch (status) {
            case 'READY_FOR_MARKETING':
                return <span style={{ backgroundColor: '#DCFCE7', color: '#166534', padding: '4px 12px', borderRadius: '12px', fontSize: '0.8rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}><ShieldCheck size={14} /> CLEARED</span>;
            case 'AWAITING_LEGAL':
                return <span style={{ backgroundColor: '#FEF9C3', color: '#854D0E', padding: '4px 12px', borderRadius: '12px', fontSize: '0.8rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}><FileSignature size={14} /> PENDING WAIVER</span>;
            case 'REJECTED':
                return <span style={{ backgroundColor: '#FEE2E2', color: '#991B1B', padding: '4px 12px', borderRadius: '12px', fontSize: '0.8rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}><XCircle size={14} /> DECLINED</span>;
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: '8px', border: '1px solid #FECACA' }}>
                        <ShieldCheck size={28} color="#DC2626" />
                    </div>
                    <div>
                        <h3 data-cy="h3-testimonial-release-tracker-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>HIPAA Testimonial Release Ledger</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Enforces strict legal compliance before using any patient feedback in public marketing materials.</p>
                    </div>
                </div>
            </div>

            <table data-cy="table-testimonial-release-tracker" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.95rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Patient Quote</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Caregiver</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>HIPAA Release Link</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Stock Photo</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Marketing Status</th>
                    </tr>
                </thead>
                <tbody>
                    {testimonials.map(t => (
                        <tr key={t.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                            <td style={{ padding: '16px 12px', verticalAlign: 'top', width: '40%' }}>
                                <div style={{ fontWeight: 800, color: '#0F172A', marginBottom: '4px' }}>"{t.quote}"</div>
                                <div style={{ fontSize: '0.8rem', color: '#64748B' }}>- {t.patientName} | Source: {t.source}</div>
                            </td>
                            
                            <td style={{ padding: '16px 12px', verticalAlign: 'top' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '6px', color: '#334155', fontWeight: 700 }}>
                                    <UserCheck size={16} color="#0284C7"/> {t.caregiverName}
                                </div>
                            </td>

                            <td style={{ padding: '16px 12px', verticalAlign: 'top', textAlign: 'center' }}>
                                {t.hipaaReleaseSigned ? (
                                    <span style={{ color: '#16A34A', fontWeight: 700, display: 'inline-flex', alignItems: 'center', gap: '4px' }}><CheckCircle2 size={16}/> Signed ({t.date})</span>
                                ) : (
                                    t.status !== 'REJECTED' && (
                                        <button data-cy="btn-testimonial-release-tracker-0" 
                                            onClick={() => handleSendWaiver(t.id)}
                                            style={{ backgroundColor: '#F1F5F9', color: '#334155', border: '1px solid #CBD5E1', borderRadius: '6px', padding: '6px 12px', fontWeight: 700, cursor: 'pointer', fontSize: '0.8rem' }}
                                        >
                                            Send DocuSign Link
                                        </button>
                                    )
                                )}
                            </td>
                            
                             <td style={{ padding: '16px 12px', verticalAlign: 'top', textAlign: 'center' }}>
                                {t.photoAssigned ? (
                                    <span style={{ color: '#16A34A', fontWeight: 700, display: 'inline-flex', alignItems: 'center', gap: '4px' }}><CheckCircle2 size={16}/> Selected</span>
                                ) : (
                                    <span style={{ color: '#94A3B8', fontWeight: 600 }}>Missing Asset</span>
                                )}
                            </td>

                            <td style={{ padding: '16px 12px', verticalAlign: 'top', textAlign: 'right' }}>
                                {getStatusBadge(t.status)}
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#FEF2F2', borderRadius: '8px', border: '1px dashed #FECACA', fontSize: '0.85rem', color: '#991B1B', display: 'flex', gap: '8px' }}>
                <AlertTriangle size={20} style={{ flexShrink: 0 }} />
                <strong>Strict HIPAA Enforcement:</strong> Even a simple first name paired with a medical condition (e.g., 'Mom loved the dementia care') constitutes Protected Health Information (PHI). This tool prevents the marketing team from turning internal 5-star surveys into public Facebook Ads until a legally binding Media Release Form is signed and vaulted.
            </div>
        </div>
    );
};

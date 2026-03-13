import React, { useState } from 'react';
import { Camera, AlertTriangle, UploadCloud, CheckCircle2 } from 'lucide-react';

export const DamageReportIntake: React.FC = () => {
    const [status, setStatus] = useState<'IDLE' | 'UPLOADING' | 'SUCCESS'>('IDLE');
    const [fileName, setFileName] = useState<string>('');

    const handleUpload = () => {
        setStatus('UPLOADING');
        setTimeout(() => {
            setStatus('SUCCESS');
        }, 1500);
    };

    if (status === 'SUCCESS') {
        return (
            <div style={{ padding: '24px', backgroundColor: '#F0FDF4', borderRadius: '12px', border: '1px solid #BBF7D0', textAlign: 'center', marginTop: '16px' }}>
                <CheckCircle2 size={40} color="#16A34A" style={{ margin: '0 auto 12px auto' }} />
                <h3 data-cy="h3-rn.damage-report-intake-0" style={{ margin: 0, color: '#14532D', fontSize: '1.2rem' }}>Report Submitted</h3>
                <p style={{ margin: '8px 0 0 0', color: '#166534', fontSize: '0.9rem' }}>
                    The Property Manager has been notified. A replacement asset will be routed to your branch.
                </p>
                <button data-cy="btn-rn.damage-report-intake-0" 
                    onClick={() => { setStatus('IDLE'); setFileName(''); }}
                    style={{ marginTop: '16px', padding: '8px 16px', backgroundColor: '#16A34A', color: 'white', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 600 }}
                >
                    Report Another Issue
                </button>
            </div>
        );
    }

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '20px' }}>
                <div style={{ backgroundColor: '#FEF2F2', padding: '10px', borderRadius: '8px' }}>
                    <AlertTriangle size={20} color="#DC2626" />
                </div>
                <div>
                    <h3 data-cy="h3-rn.damage-report-intake-1" style={{ margin: 0, fontSize: '1.1rem', color: '#0F172A', fontWeight: 800 }}>Report Damaged Equipment</h3>
                    <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.85rem' }}>Send a photo to Property Management for quick replacement.</p>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                <div>
                    <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '6px' }}>Asset ID / Serial Number (Optional)</label>
                    <input data-cy="input-rn.damage-report-intake-0" type="text" placeholder="e.g. ECG-5912" style={{ padding: '10px', width: '100%', borderRadius: '6px', border: '1px solid #CBD5E1', fontSize: '0.95rem' }} />
                </div>

                <div>
                    <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '6px' }}>Issue Description</label>
                    <textarea data-cy="textarea-rn.damage-report-intake" rows={3} placeholder="Describe the damage..." style={{ padding: '10px', width: '100%', borderRadius: '6px', border: '1px solid #CBD5E1', fontSize: '0.95rem', resize: 'vertical' }} />
                </div>

                {/* Upload Zone */}
                <div 
                    style={{ 
                        border: '2px dashed #CBD5E1', borderRadius: '8px', padding: '32px', textAlign: 'center', 
                        backgroundColor: '#F8FAFC', cursor: 'pointer', transition: 'border-color 0.2s'
                    }}
                    onClick={() => setFileName('broken_cuff_image.jpg')}
                >
                    {fileName ? (
                        <div style={{ color: '#0F172A', fontWeight: 600 }}>
                            <Camera size={24} color="#0EA5E9" style={{ marginBottom: '8px' }} />
                            <div>{fileName} attached.</div>
                        </div>
                    ) : (
                        <div style={{ color: '#64748B' }}>
                            <Camera size={32} color="#94A3B8" style={{ marginBottom: '12px' }} />
                            <div style={{ fontWeight: 600, color: '#475569' }}>Tap to upload or take a photo</div>
                            <div style={{ fontSize: '0.8rem', marginTop: '4px' }}>JPEG, PNG up to 10MB</div>
                        </div>
                    )}
                </div>

                <button data-cy="btn-rn.damage-report-intake-1" 
                    onClick={handleUpload}
                    disabled={status === 'UPLOADING' || !fileName}
                    style={{ 
                        width: '100%', padding: '12px', backgroundColor: '#0F172A', color: 'white', 
                        border: 'none', borderRadius: '8px', fontWeight: 700, fontSize: '1rem', 
                        cursor: (status === 'UPLOADING' || !fileName) ? 'not-allowed' : 'pointer',
                        opacity: (status === 'UPLOADING' || !fileName) ? 0.6 : 1,
                        display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px',
                        marginTop: '8px'
                    }}
                >
                    {status === 'UPLOADING' ? (
                         <>Processing...</>
                    ) : (
                        <><UploadCloud size={18} /> Submit Routing Request</>
                    )}
                </button>
            </div>
        </div>
    );
};

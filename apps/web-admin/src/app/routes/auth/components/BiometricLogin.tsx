import React, { useState, useEffect } from 'react';
import { Fingerprint, Lock, ShieldCheck } from 'lucide-react';
import { useTranslation } from 'react-i18next';

interface BiometricLoginProps {
    onSuccess: () => void;
    onCancel: () => void;
}

export const BiometricLogin: React.FC<BiometricLoginProps> = ({ onSuccess, onCancel }) => {
    const { t } = useTranslation();
    const [status, setStatus] = useState<'prompt' | 'scanning' | 'success' | 'error'>('prompt');
    const [isSupported, setIsSupported] = useState(true);

    useEffect(() => {
        // Feature detection for Web Authentication API (WebAuthn)
        if (!window.PublicKeyCredential) {
            setIsSupported(false);
            setStatus('error');
        }
    }, []);

    const handleAuthenticate = async () => {
        if (!isSupported) return;

        setStatus('scanning');

        try {
 // WebAuthn Call
            // Real implementation would use navigator.credentials.get({ publicKey: { ... } })
            await new Promise(resolve => setTimeout(resolve, 1500));

            setStatus('success');
            setTimeout(() => {
                onSuccess();
            }, 800);

        } catch (error) {
            console.error('Biometric Auth Error', error);
            setStatus('error');
            setTimeout(() => setStatus('prompt'), 2000);
        }
    };

    return (
        <div style={{
            position: 'fixed',
            inset: 0,
            backgroundColor: 'rgba(15, 23, 42, 0.95)',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 10000,
            animation: 'fadeIn 0.3s ease-out'
        }}>
            <div style={{
                backgroundColor: '#1E293B',
                padding: '40px',
                borderRadius: '24px',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                gap: '24px',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.5)',
                border: '1px solid #334155',
                width: '80%',
                maxWidth: '400px',
                textAlign: 'center'
            }}>
                <div style={{
                    width: '80px',
                    height: '80px',
                    borderRadius: '40px',
                    backgroundColor: status === 'success' ? 'rgba(16, 185, 129, 0.2)' : status === 'error' ? 'rgba(239, 68, 68, 0.2)' : 'rgba(59, 130, 246, 0.2)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    transition: 'all 0.3s ease',
                    boxShadow: status === 'scanning' ? '0 0 20px rgba(59, 130, 246, 0.5)' : 'none'
                }}>
                    {status === 'success' ? (
                        <ShieldCheck size={40} color="#10B981" />
                    ) : status === 'error' ? (
                        <Lock size={40} color="#EF4444" />
                    ) : (
                        <Fingerprint size={40} color="#3B82F6" className={status === 'scanning' ? 'pulse' : ''} />
                    )}
                </div>

                <div>
                    <h2 style={{ color: 'white', margin: '0 0 8px 0', fontSize: '1.5rem' }}>
                        {status === 'success' ? 'Verified' : 'Quick Access'}
                    </h2>
                    <p style={{ color: '#94A3B8', margin: 0, fontSize: '0.9rem', lineHeight: 1.5 }}>
                        {status === 'scanning' ? 'Scanning biometrics...' :
                            status === 'error' ? 'Verification failed. Try again.' :
                                !isSupported ? 'Biometric login is not supported on this device.' :
                                    'Use Touch ID or Face ID to quickly unlock PrimeCare.'}
                    </p>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px', width: '100%', marginTop: '24px' }}>
                    
                    {status === 'prompt' && (
                        <button
                         onClick={() => {
                             setStatus('scanning');
                             setTimeout(() => {
                                 setStatus('success');
                                 setTimeout(() => onSuccess(), 800);
                             }, 1500);
                         }}
                         disabled={!isSupported}
                         style={{ 
                             padding: '20px', 
                             background: 'linear-gradient(135deg, #10B981, #059669)', 
                             color: 'white', 
                             border: 'none', 
                             borderRadius: '16px', 
                             fontSize: '1.25rem', 
                             fontWeight: 800, 
                             cursor: 'pointer', 
                             opacity: !isSupported ? 0.7 : 1,
                             boxShadow: '0 10px 15px -3px rgba(16, 185, 129, 0.4)',
                             transition: 'transform 0.2s',
                             textTransform: 'uppercase',
                             letterSpacing: '0.05em'
                         }}
                         onMouseOver={(e) => e.currentTarget.style.transform = 'scale(1.02)'}
                         onMouseOut={(e) => e.currentTarget.style.transform = 'scale(1)'}
                        >
                            <span style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '12px' }}>
                                <Fingerprint size={24} />
                                Register New Biometrics
                            </span>
                        </button>
                    )}

                    <button
                        onClick={handleAuthenticate}
                        disabled={status === 'scanning' || status === 'success' || !isSupported}
                        style={{
                            padding: '20px',
                            background: status === 'prompt' ? 'rgba(59, 130, 246, 0.1)' : 'linear-gradient(135deg, #3B82F6, #2563EB)',
                            color: status === 'prompt' ? '#60A5FA' : 'white',
                            border: status === 'prompt' ? '2px solid #3B82F6' : 'none',
                            borderRadius: '16px',
                            fontSize: '1.25rem',
                            fontWeight: 800,
                            cursor: 'pointer',
                            opacity: (status === 'scanning' || !isSupported) ? 0.7 : 1,
                            boxShadow: status !== 'prompt' ? '0 10px 15px -3px rgba(59, 130, 246, 0.4)' : 'none',
                            transition: 'all 0.2s ease'
                        }}
                    >
                        {status === 'scanning' ? 'Authenticating...' : 'Use Existing Biometrics'}
                    </button>

                    {status === 'prompt' && (
                        <button
                            onClick={onCancel}
                            style={{
                                padding: '16px',
                                backgroundColor: 'transparent',
                                color: '#94A3B8',
                                border: 'none',
                                fontSize: '1rem',
                                fontWeight: 600,
                                cursor: 'pointer',
                                textDecoration: 'underline'
                            }}
                        >
                            Cancel & Return to Password Login
                        </button>
                    )}
                </div>
            </div>

            <style>{`
                @keyframes fadeIn {
                    from { opacity: 0; }
                    to { opacity: 1; }
                }
                @keyframes pulse-icon {
                    0% { transform: scale(0.95); opacity: 0.8; }
                    50% { transform: scale(1.05); opacity: 1; }
                    100% { transform: scale(0.95); opacity: 0.8; }
                }
                .pulse {
                    animation: pulse-icon 1.5s infinite ease-in-out;
                }
            `}</style>
        </div>
    );
};

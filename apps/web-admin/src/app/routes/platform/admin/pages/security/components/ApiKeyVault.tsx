import React, { useState } from 'react';
import { Key, Copy, CheckCircle, RefreshCw } from 'lucide-react';
import { useNotification } from '@/shared/context/NotificationContext';

export const ApiKeyVault: React.FC = () => {
    const { showToast } = useNotification();
    const [reveal, setReveal] = useState(false);
    const [copied, setCopied] = useState(false);

    // Mock Key
    const STATIC_KEY = "pk_live_51Mabcde1234FGHIdjklMNOpqrSTUvwxyz9876QWERTYUIOPasdfghjklZXCVBNM";

    const copyToClipboard = () => {
        navigator.clipboard.writeText(STATIC_KEY);
        setCopied(true);
        showToast('API Key copied to clipboard. Do not paste this into public forums.', 'warning');
        setTimeout(() => setCopied(false), 2000);
    };

    return (
        <div style={{ backgroundColor: 'white', padding: '32px', borderRadius: '16px', border: '1px solid #E2E8F0', maxWidth: '600px' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 800, margin: '0 0 8px 0', color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Key color="#8B5CF6" /> Infrastructure API Playground
            </h2>
            <p style={{ color: '#64748B', margin: '0 0 24px 0', fontSize: '0.9rem', lineHeight: '1.5' }}>
                Generate root-level Bearer tokens for external system interoperability. <strong style={{color: '#EF4444'}}>Never commit these to version control.</strong>
            </p>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', marginBottom: '24px' }}>
                <label style={{ fontSize: '0.85rem', fontWeight: 700, color: '#475569' }}>Production Root Key (v3)</label>
                
                <div style={{ position: 'relative', display: 'flex' }}>
                    
                    <div 
                        onMouseEnter={() => setReveal(true)}
                        onMouseLeave={() => setReveal(false)}
                        style={{ 
                            flex: 1, 
                            backgroundColor: '#F1F5F9', 
                            border: '1px solid #CBD5E1', 
                            borderRight: 'none',
                            padding: '12px 16px', 
                            borderRadius: '8px 0 0 8px',
                            fontFamily: 'monospace',
                            fontSize: '0.9rem',
                            color: '#0F172A',
                            overflow: 'hidden',
                            position: 'relative'
                        }}
                    >
                        {STATIC_KEY}
                        
                        {/* Overlay Blur */}
                        <div style={{
                            position: 'absolute', inset: 0,
                            backgroundColor: 'rgba(255,255,255,0.4)',
                            backdropFilter: reveal ? 'none' : 'blur(6px)',
                            display: 'flex', alignItems: 'center', justifyContent: 'center',
                            transition: 'backdrop-filter 0.2s ease',
                            pointerEvents: 'none'
                        }}>
                            {!reveal && <span style={{ backgroundColor: '#0F172A', color: 'white', padding: '4px 12px', borderRadius: '20px', fontSize: '0.8rem', fontWeight: 800 }}>HOVER TO REVEAL</span>}
                        </div>
                    </div>

                    <button 
                        onClick={copyToClipboard}
                        style={{ 
                            backgroundColor: copied ? '#10B981' : '#E2E8F0', 
                            color: copied ? 'white' : '#475569',
                            border: '1px solid #CBD5E1', 
                            borderLeft: 'none',
                            borderRadius: '0 8px 8px 0', 
                            padding: '0 16px', 
                            cursor: 'pointer', 
                            display: 'flex', alignItems: 'center', justifyContent: 'center',
                            transition: 'background-color 0.2s ease'
                        }}
                    >
                        {copied ? <CheckCircle size={20} /> : <Copy size={20} />}
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#FEF2F2', padding: '16px', borderRadius: '8px', border: '1px solid #FECACA' }}>
                <div>
                    <div style={{ fontWeight: 800, color: '#991B1B', fontSize: '0.9rem' }}>Compromised Key?</div>
                    <div style={{ fontSize: '0.8rem', color: '#B91C1C' }}>Rolling the root key will instantly sever all active external integrations.</div>
                </div>
                <button style={{ backgroundColor: '#DC2626', color: 'white', border: 'none', padding: '8px 16px', borderRadius: '6px', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                    <RefreshCw size={16} /> ROLL KEY
                </button>
            </div>
        </div>
    );
};

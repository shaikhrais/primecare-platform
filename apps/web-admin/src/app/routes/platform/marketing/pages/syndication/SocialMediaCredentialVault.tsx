import React, { useState } from 'react';
import { Share2, Lock, CheckCircle2, AlertTriangle, Key, Globe, RefreshCcw, Send } from 'lucide-react';

interface SocialPlatform {
    id: string;
    platformName: string;
    iconUrl: string; // simulating an icon
    accountName: string | null;
    status: 'CONNECTED' | 'DISCONNECTED' | 'EXPIRED';
    lastSync: string | null;
    tokenExpiry: string | null;
    permissions: string[];
}

export const SocialMediaCredentialVault: React.FC = () => {
    const [platforms, setPlatforms] = useState<SocialPlatform[]>([
        { id: '1', platformName: 'Facebook Page', iconUrl: 'fb', accountName: 'PrimeCare Home Health', status: 'CONNECTED', lastSync: '2 hours ago', tokenExpiry: '2026-05-15', permissions: ['pages_manage_posts', 'pages_read_engagement'] },
        { id: '2', platformName: 'LinkedIn Company', iconUrl: 'in', accountName: 'PrimeCare USA', status: 'CONNECTED', lastSync: '1 day ago', tokenExpiry: '2027-01-01', permissions: ['w_organization_social', 'r_organization_social'] },
        { id: '3', platformName: 'Instagram Business', iconUrl: 'ig', accountName: '@primecare_health', status: 'EXPIRED', lastSync: '14 days ago', tokenExpiry: '2026-02-28', permissions: ['instagram_basic', 'instagram_content_publish'] },
        { id: '4', platformName: 'X (Twitter)', iconUrl: 'x', accountName: null, status: 'DISCONNECTED', lastSync: null, tokenExpiry: null, permissions: ['tweet.read', 'tweet.write'] }
    ]);

    const [isConnecting, setIsConnecting] = useState<string | null>(null);

    const handleConnect = (id: string) => {
        setIsConnecting(id);
        setTimeout(() => {
            setPlatforms(platforms.map(p => 
                p.id === id ? { ...p, status: 'CONNECTED', accountName: p.accountName || `Connected_${p.platformName.split(' ')[0]}`, lastSync: 'Just now', tokenExpiry: '2027-12-31' } : p
            ));
            setIsConnecting(null);
        }, 1500);
    };

    const handleDisconnect = (id: string) => {
         setPlatforms(platforms.map(p => 
            p.id === id ? { ...p, status: 'DISCONNECTED', accountName: null, lastSync: null, tokenExpiry: null } : p
        ));
    };

    const getStatusColor = (status: SocialPlatform['status']) => {
        switch(status) {
            case 'CONNECTED': return '#16A34A';
            case 'DISCONNECTED': return '#64748B';
            case 'EXPIRED': return '#DC2626';
        }
    };

    const getStatusBg = (status: SocialPlatform['status']) => {
        switch(status) {
            case 'CONNECTED': return '#F0FDF4';
            case 'DISCONNECTED': return '#F8FAFC';
            case 'EXPIRED': return '#FEF2F2';
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F3E8FF', padding: '12px', borderRadius: '8px', border: '1px solid #E9D5FF' }}>
                        <Lock size={28} color="#9333EA" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Social Media Credential Vault</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Securely manage OAuth 2.0 access tokens to allow backend workers to auto-publish content.</p>
                    </div>
                </div>

                 <div style={{ padding: '8px 16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.85rem', color: '#475569', fontWeight: 700 }}>
                    <Key size={16} /> Data Encrypted at Rest (AES-256)
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {platforms.map(platform => {
                    const isConnected = platform.status === 'CONNECTED';
                    const isExpired = platform.status === 'EXPIRED';

                    return (
                        <div key={platform.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '20px', borderRadius: '12px', backgroundColor: getStatusBg(platform.status), border: `1px solid ${isConnected ? '#BBF7D0' : isExpired ? '#FECACA' : '#E2E8F0'}` }}>
                            
                            <div style={{ flex: '1 1 300px', display: 'flex', alignItems: 'flex-start', gap: '16px' }}>
                                <div style={{ width: '48px', height: '48px', backgroundColor: 'white', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.2rem', fontWeight: 900, color: '#0F172A', border: '1px solid #E2E8F0', boxShadow: '0 2px 4px rgba(0,0,0,0.05)' }}>
                                    {platform.iconUrl.toUpperCase()}
                                </div>
                                <div>
                                    <h4 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 900 }}>{platform.platformName}</h4>
                                    
                                    {platform.accountName ? (
                                         <div style={{ fontSize: '0.9rem', color: '#334155', fontWeight: 700, marginTop: '4px' }}>Linked Account: {platform.accountName}</div>
                                    ) : (
                                        <div style={{ fontSize: '0.9rem', color: '#64748B', fontWeight: 600, marginTop: '4px' }}>No account linked</div>
                                    )}

                                    <div style={{ display: 'flex', gap: '6px', marginTop: '8px', flexWrap: 'wrap' }}>
                                        {platform.permissions.map(perm => (
                                            <span key={perm} style={{ fontSize: '0.65rem', backgroundColor: '#E2E8F0', color: '#475569', padding: '2px 6px', borderRadius: '4px', fontFamily: 'monospace' }}>{perm}</span>
                                        ))}
                                    </div>
                                </div>
                            </div>

                            <div style={{ flex: '0 0 200px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
                                 <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.8rem', fontWeight: 800, color: getStatusColor(platform.status) }}>
                                    {isConnected && <CheckCircle2 size={16} />}
                                    {platform.status === 'DISCONNECTED' && <Globe size={16} />}
                                    {isExpired && <AlertTriangle size={16} />}
                                    STATUS: {platform.status}
                                 </div>

                                 {platform.lastSync && (
                                     <div style={{ fontSize: '0.75rem', color: '#64748B' }}>
                                        <div>Last sync: {platform.lastSync}</div>
                                        <div>Token expires: {platform.tokenExpiry}</div>
                                     </div>
                                 )}
                            </div>

                            <div style={{ flex: '0 0 150px', display: 'flex', justifyContent: 'flex-end' }}>
                                {(platform.status === 'DISCONNECTED' || platform.status === 'EXPIRED') ? (
                                    <button 
                                        onClick={() => handleConnect(platform.id)}
                                        disabled={isConnecting === platform.id}
                                        style={{ backgroundColor: '#0284C7', color: 'white', border: 'none', borderRadius: '6px', padding: '10px 16px', fontSize: '0.9rem', fontWeight: 800, cursor: isConnecting === platform.id ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                                    >
                                        {isConnecting === platform.id ? <RefreshCcw size={16} className="animate-spin" /> : <Lock size={16} />}
                                        {isExpired ? 'Re-Authenticate' : 'Connect via OAuth'}
                                    </button>
                                ) : (
                                    <button 
                                        onClick={() => handleDisconnect(platform.id)}
                                        style={{ backgroundColor: 'white', color: '#DC2626', border: '1px solid #FECACA', borderRadius: '6px', padding: '10px 16px', fontSize: '0.9rem', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                                    >
                                        Disconnect
                                    </button>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>

            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#EFF6FF', borderRadius: '8px', border: '1px solid #BFDBFE', fontSize: '0.9rem', color: '#1E3A8A', display: 'flex', alignItems: 'flex-start', gap: '12px' }}>
                 <Send size={24} style={{ flexShrink: 0 }} />
                 <div>
                     <strong>Omnichannel Syndication Engine:</strong> This vault safely stores Long-Lived Access Tokens. When the CMO hits 'Publish' on a new Caregiver Spotlight graphic, they don't need to manually log into 4 different websites. The backend worker decrypts these tokens and blasts the asset to Facebook, LinkedIn, and Instagram simultaneously via API.
                 </div>
            </div>
        </div>
    );
};

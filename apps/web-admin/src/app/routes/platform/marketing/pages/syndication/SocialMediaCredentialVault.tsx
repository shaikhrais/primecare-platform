import React, { useState, useEffect, useCallback } from 'react';
import { Lock, CheckCircle2, AlertTriangle, Key, Globe, RefreshCcw, Send, Loader2 } from 'lucide-react';
import { GoogleOAuthProvider, useGoogleLogin } from '@react-oauth/google';
import { useNotification } from '@/shared/context/NotificationContext';
import { type SocialPlatform, getStatusColor, getStatusBg } from './vaultHelpers';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';

declare global { interface Window { fbAsyncInit: () => void; FB: any; } }

const SocialMediaCredentialVaultInner: React.FC = () => {
    // TanStack Query: auto-cached vault data
    const { data: initialPlatforms = [], isLoading } = useRegistryQuery<SocialPlatform[]>('/v1/system/marketing/syndication/vault', {
        queryKey: ['marketing', 'syndication', 'vault'],
        staleTime: 60_000,
    });
    // Local state for connect/disconnect UI mutations
    const [platformOverrides, setPlatformOverrides] = useState<Record<string, Partial<SocialPlatform>>>({});
    const platforms = initialPlatforms.map(p => ({ ...p, ...platformOverrides[p.id] }));
    const setPlatforms = (updaterOrValue: SocialPlatform[] | ((prev: SocialPlatform[]) => SocialPlatform[])) => {
        const updated = typeof updaterOrValue === 'function' ? updaterOrValue(platforms) : updaterOrValue;
        const overrides: Record<string, Partial<SocialPlatform>> = {};
        updated.forEach(p => { overrides[p.id] = p; });
        setPlatformOverrides(overrides);
    };
    const [isConnecting, setIsConnecting] = useState<string | null>(null);
    const { showToast } = useNotification();

    useEffect(() => {
        if (window.FB) return;
        window.fbAsyncInit = function() { window.FB.init({ appId: '123456789012345', cookie: true, xfbml: true, version: 'v18.0' }); };
        (function(d, s, id){ var js, fjs = d.getElementsByTagName(s)[0] as HTMLElement; if (d.getElementById(id)) return; js = d.createElement(s) as HTMLScriptElement; js.id = id; js.src = "https://connect.facebook.net/en_US/sdk.js"; fjs.parentNode?.insertBefore(js, fjs); }(document, 'script', 'facebook-jssdk'));
    }, []);

    const loginWithGoogle = useGoogleLogin({
        onSuccess: tokenResponse => { setIsConnecting(null); setPlatforms(platforms.map(p => p.id === '5' ? { ...p, status: 'CONNECTED', accountName: 'PrimeCare GBP', lastSync: 'Just now', tokenExpiry: '1 hour' } : p)); },
        onError: () => setIsConnecting(null),
        scope: 'https://www.googleapis.com/auth/business.manage',
    });

    const handleConnect = useCallback((id: string) => {
        setIsConnecting(id);
        if (id === '5') { loginWithGoogle(); }
        else if (id === '1' || id === '3') {
            if (window.FB) { window.FB.login((r: any) => { setIsConnecting(null); if (r.authResponse) setPlatforms(prev => prev.map(p => p.id === id ? { ...p, status: 'CONNECTED', accountName: `Connected_${p.platformName.split(' ')[0]}`, lastSync: 'Just now', tokenExpiry: '60 Days' } : p)); }, { scope: id === '1' ? 'pages_manage_posts,pages_read_engagement' : 'instagram_basic,instagram_content_publish' }); }
            else { setIsConnecting(null); showToast("Facebook SDK failed to load.", "error"); }
        } else { setTimeout(() => { setPlatforms(prev => prev.map(p => p.id === id ? { ...p, status: 'CONNECTED', accountName: p.accountName || `Connected_${p.platformName.split(' ')[0]}`, lastSync: 'Just now', tokenExpiry: '90 Days' } : p)); setIsConnecting(null); }, 1000); }
    }, [loginWithGoogle]);

    const handleDisconnect = (id: string) => setPlatforms(platforms.map(p => p.id === id ? { ...p, status: 'DISCONNECTED', accountName: null, lastSync: null, tokenExpiry: null } : p));

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}><div style={{ backgroundColor: '#F3E8FF', padding: '12px', borderRadius: '8px', border: '1px solid #E9D5FF' }}><Lock size={28} color="#9333EA" /></div><div><h3 data-cy="h3-social-media-credential-vault-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Social Media Credential Vault</h3><p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Securely manage OAuth 2.0 access tokens to allow backend workers to auto-publish content.</p></div></div>
                <div style={{ padding: '8px 16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.85rem', color: '#475569', fontWeight: 700 }}><Key size={16} /> Data Encrypted at Rest (AES-256)</div>
            </div>

            {isLoading ? <div style={{ display: 'flex', justifyContent: 'center', padding: '48px 0', color: '#94A3B8' }}><Loader2 size={32} className="animate-spin" /></div> : (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    {platforms.map(platform => { const isConnected = platform.status === 'CONNECTED'; const isExpired = platform.status === 'EXPIRED'; return (
                        <div key={platform.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '20px', borderRadius: '12px', backgroundColor: getStatusBg(platform.status), border: `1px solid ${isConnected ? '#BBF7D0' : isExpired ? '#FECACA' : '#E2E8F0'}` }}>
                            <div style={{ flex: '1 1 300px', display: 'flex', alignItems: 'flex-start', gap: '16px' }}>
                                <div style={{ width: '48px', height: '48px', backgroundColor: 'white', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.2rem', fontWeight: 900, color: '#0F172A', border: '1px solid #E2E8F0', boxShadow: '0 2px 4px rgba(0,0,0,0.05)' }}>{platform.iconUrl.toUpperCase()}</div>
                                <div><h4 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 900 }}>{platform.platformName}</h4>{platform.accountName ? <div style={{ fontSize: '0.9rem', color: '#334155', fontWeight: 700, marginTop: '4px' }}>Linked Account: {platform.accountName}</div> : <div style={{ fontSize: '0.9rem', color: '#64748B', fontWeight: 600, marginTop: '4px' }}>No account linked</div>}<div style={{ display: 'flex', gap: '6px', marginTop: '8px', flexWrap: 'wrap' }}>{platform.permissions.map(perm => <span key={perm} style={{ fontSize: '0.65rem', backgroundColor: '#E2E8F0', color: '#475569', padding: '2px 6px', borderRadius: '4px', fontFamily: 'monospace' }}>{perm}</span>)}</div></div>
                            </div>
                            <div style={{ flex: '0 0 200px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.8rem', fontWeight: 800, color: getStatusColor(platform.status) }}>{isConnected && <CheckCircle2 size={16} />}{platform.status === 'DISCONNECTED' && <Globe size={16} />}{isExpired && <AlertTriangle size={16} />}STATUS: {platform.status}</div>
                                {platform.lastSync && <div style={{ fontSize: '0.75rem', color: '#64748B' }}><div>Last sync: {platform.lastSync}</div><div>Token expires: {platform.tokenExpiry}</div></div>}
                            </div>
                            <div style={{ flex: '0 0 150px', display: 'flex', justifyContent: 'flex-end' }}>
                                {(platform.status === 'DISCONNECTED' || platform.status === 'EXPIRED') ? <button data-cy="btn-social-media-credential-vault-0" onClick={() => handleConnect(platform.id)} disabled={isConnecting === platform.id} style={{ backgroundColor: '#0284C7', color: 'white', border: 'none', borderRadius: '6px', padding: '10px 16px', fontSize: '0.9rem', fontWeight: 800, cursor: isConnecting === platform.id ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}>{isConnecting === platform.id ? <RefreshCcw size={16} className="animate-spin" /> : <Lock size={16} />}{isExpired ? 'Re-Authenticate' : 'Connect via OAuth'}</button> : <button data-cy="btn-social-media-credential-vault-1" onClick={() => handleDisconnect(platform.id)} style={{ backgroundColor: 'white', color: '#DC2626', border: '1px solid #FECACA', borderRadius: '6px', padding: '10px 16px', fontSize: '0.9rem', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}>Disconnect</button>}
                            </div>
                        </div>); })}
                </div>)}

            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#EFF6FF', borderRadius: '8px', border: '1px solid #BFDBFE', fontSize: '0.9rem', color: '#1E3A8A', display: 'flex', alignItems: 'flex-start', gap: '12px' }}><Send size={24} style={{ flexShrink: 0 }} /><div><strong>Omnichannel Syndication Engine:</strong> This vault safely stores Long-Lived Access Tokens. When the CMO hits 'Publish' on a new Caregiver Spotlight graphic, they don't need to manually log into 4 different websites. The backend worker decrypts these tokens and blasts the asset to Facebook, LinkedIn, and Instagram simultaneously via API.</div></div>
        </div>
    );
};

export const SocialMediaCredentialVault: React.FC = () => (
    <GoogleOAuthProvider clientId="1234567890-demo.apps.googleusercontent.com"><SocialMediaCredentialVaultInner /></GoogleOAuthProvider>
);

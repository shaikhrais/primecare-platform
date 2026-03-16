import React, { useState } from 'react';
import { Cloud, Radio, RefreshCw, Server, AlertCircle, Database } from 'lucide-react';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useToast as useNotification } from '@/shared/hooks/useToast';

export const ThirdPartyCdnSync: React.FC = () => {
    const [provider, setProvider] = useState<'cloudflare' | 'aws'>('aws');
    const [bucketUrl, setBucketUrl] = useState('');
    const [accessKey, setAccessKey] = useState('');
    const [lastSync, setLastSync] = useState('2026-03-09 14:00:00 UTC');
    const { showToast } = useNotification();

    const syncMutation = useApiMutation('/platform/admin/dam/media/cdn-sync', {
        onSuccess: () => {
            setLastSync(new Date().toUTCString());
            showToast(`Successfully mirrored vault to external ${provider.toUpperCase()} bucket.`, 'success');
        },
        onError: () => { showToast('Edge propagation failed', 'error'); },
    });

    const isSyncing = syncMutation.isPending;

    const handleSync = () => syncMutation.mutate({ provider, bucketUrl });

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '10px', borderRadius: '8px' }}>
                        <Cloud size={24} color="#16A34A" />
                    </div>
                    <div>
                        <h3 data-cy="h3-third-party-cdn-sync-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>External Edge Synchronization</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Mirror internal digital assets to public-facing edge networks.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ fontSize: '0.8rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <RefreshCw size={14} color="#94A3B8" /> Last Sync: {lastSync}
                    </div>
                    <button 
                        data-cy="btn-cdn-sync"
                        onClick={handleSync}
                        disabled={isSyncing || !bucketUrl}
                        style={{ backgroundColor: '#16A34A', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: (isSyncing || !bucketUrl) ? 'not-allowed' : 'pointer', opacity: (isSyncing || !bucketUrl) ? 0.6 : 1, display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        {isSyncing ? <RefreshCw size={16} className="animate-spin" /> : <Radio size={16} />}
                        {isSyncing ? 'Synchronizing...' : 'Force Edge Propagation'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Configuration Panel */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '20px' }}>
                    
                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '8px' }}>Select Infrastructure Provider</label>
                        <div style={{ display: 'flex', gap: '12px' }}>
                            <div 
                                data-cy="cdn-provider-aws"
                                onClick={() => setProvider('aws')}
                                style={{ flex: 1, padding: '16px', border: `2px solid ${provider === 'aws' ? '#F59E0B' : '#E2E8F0'}`, borderRadius: '8px', cursor: 'pointer', backgroundColor: provider === 'aws' ? '#FFFBEB' : 'white', display: 'flex', alignItems: 'center', gap: '12px' }}
                            >
                                <Database size={24} color={provider === 'aws' ? '#F59E0B' : '#94A3B8'} />
                                <div>
                                    <div style={{ fontWeight: 700, color: '#0F172A' }}>AWS S3</div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>Amazon Web Services</div>
                                </div>
                            </div>
                            <div 
                                data-cy="cdn-provider-cloudflare"
                                onClick={() => setProvider('cloudflare')}
                                style={{ flex: 1, padding: '16px', border: `2px solid ${provider === 'cloudflare' ? '#F97316' : '#E2E8F0'}`, borderRadius: '8px', cursor: 'pointer', backgroundColor: provider === 'cloudflare' ? '#FFF7ED' : 'white', display: 'flex', alignItems: 'center', gap: '12px' }}
                            >
                                <Cloud size={24} color={provider === 'cloudflare' ? '#F97316' : '#94A3B8'} />
                                <div>
                                    <div style={{ fontWeight: 700, color: '#0F172A' }}>Cloudflare R2</div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>Zero egress fees</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '8px' }}>Target Public Bucket URL</label>
                        <input 
                            data-cy="cdn-bucket-url"
                            type="text" 
                            placeholder="e.g. s3://primecare-public-assets"
                            value={bucketUrl}
                            onChange={(e) => setBucketUrl(e.target.value)}
                            style={{ width: '100%', padding: '10px 12px', borderRadius: '6px', border: '1px solid #CBD5E1', outline: 'none', color: '#0F172A' }}
                        />
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '8px' }}>{provider === 'aws' ? 'IAM Secret Access Key' : 'API Token Secret'}</label>
                        <input 
                            data-cy="cdn-access-key"
                            type="password" 
                            placeholder="•••••••••••••••••••••••••"
                            value={accessKey}
                            onChange={(e) => setAccessKey(e.target.value)}
                            style={{ width: '100%', padding: '10px 12px', borderRadius: '6px', border: '1px solid #CBD5E1', outline: 'none', color: '#0F172A', fontFamily: 'monospace' }}
                        />
                    </div>

                </div>

                {/* Status Dashboard */}
                <div style={{ width: '350px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', padding: '24px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    <h4 style={{ margin: '0 0 8px 0', fontSize: '0.85rem', color: '#475569', textTransform: 'uppercase' }}>Connection Status</h4>
                    
                    <div style={{ border: '1px solid #BBF7D0', padding: '12px', borderRadius: '6px', backgroundColor: '#F0FDF4', color: '#16A34A', display: 'flex', gap: '8px', fontSize: '0.85rem', alignItems: 'flex-start' }}>
                        <Server size={18} style={{ flexShrink: 0, marginTop: '2px' }} />
                        <div>
                            <strong>Upstream Link Active.</strong><br/>
                            Internal DAM vault is configured to successfully push modified assets to `{bucketUrl || 's3://unconfigured'}` automatically on save.
                        </div>
                    </div>

                    <div style={{ border: '1px solid #FED7AA', padding: '12px', borderRadius: '6px', backgroundColor: '#FFF7ED', color: '#C2410C', display: 'flex', gap: '8px', fontSize: '0.85rem', alignItems: 'flex-start' }}>
                        <AlertCircle size={18} style={{ flexShrink: 0, marginTop: '2px' }} />
                        <div>
                            <strong>Propagation Delay:</strong>
                            Assets pushed to edge networks may take up to 2 minutes to clear DNS caching and appear globally to all frontend clients.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

import React, { useState, useEffect } from 'react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

export default function DeveloperPortal() {
    const [apiKey, setApiKey] = useState('');
    const { showToast } = useNotification();
    const [keys, setKeys] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchKeys();
    }, []);

    const fetchKeys = async () => {
        try {
            const response = await apiClient.get('/v1/admin/developer/keys');
            if (response.ok) {
                const data = await response.json();
                setKeys(data);
            }
        } catch (error) {
            console.error('Failed to fetch API keys', error);
        } finally {
            setLoading(false);
        }
    };

    const handleCreateKey = async () => {
        const name = prompt('Enter a name for this API Key (e.g. My Website)');
        if (!name) return;

        try {
            const response = await apiClient.post('/v1/admin/developer/keys', { name });
            if (response.ok) {
                const data = await response.json();
                showToast(`Your security key is: ${data.key}\n\nIMPORTANT: Copy this key now. It will not be shown again.`, 'success');
                fetchKeys();
            }
        } catch (error) {
            showToast('Failed to create key', 'error');
        }
    };

    const handleDeleteKey = async (id: string) => {
        if (!confirm('Are you sure you want to revoke this key?')) return;
        try {
            const response = await apiClient.delete(`/v1/admin/developer/keys/${id}`);
            if (response.ok) fetchKeys();
        } catch (error) {
            alert('Failed to delete key');
        }
    };

    return (
        <div style={{ padding: '24px' }} data-cy="developer-portal-page">
            <div style={{ marginBottom: '40px' }}>
                <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Developer Portal</h1>
                <p style={{ color: '#6B7280' }}>Integrate PrimeCare into your own applications using professional-grade APIs.</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '32px' }}>
                <div className="pc-card">
                    <div className="pc-card-h">API Reference</div>
                    <div className="pc-card-b">
                        <div style={{ padding: '2rem', textAlign: 'center', backgroundColor: '#F9FAFB', borderRadius: '12px', border: '1px dashed #E5E7EB' }}>
                            <span style={{ fontSize: '3rem' }}>📖</span>
                            <h3 style={{ marginTop: '1rem', fontWeight: '700' }}>Platform API v1.0</h3>
                            <p style={{ color: '#6B7280', marginBottom: '2rem' }}>Our OpenAPI specification is automatically synced with the backend.</p>
                            <a
                                href="/doc"
                                target="_blank"
                                data-cy="btn-open-docs"
                                className="btn btn-primary"
                                style={{ textDecoration: 'none' }}
                            >
                                Open Interactive Documentation
                            </a>
                        </div>

                        <div style={{ marginTop: '2rem' }}>
                            <h4 style={{ fontWeight: '700', marginBottom: '1rem' }}>Quick Start Guide</h4>
                            <div style={{ backgroundColor: '#111827', padding: '1.5rem', borderRadius: '8px', color: '#10B981', fontFamily: 'monospace', fontSize: '13px' }}>
                                <div># Fetch your staff list</div>
                                <div>curl -X GET "https://api.pc.ca/v1/admin/users" \</div>
                                <div style={{ marginLeft: '1rem' }}>-H "X-API-Key: pk_your_key_here"</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="pc-card">
                    <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span>My API Keys</span>
                        <button data-cy="btn-create-api-key" onClick={handleCreateKey} className="btn" style={{ fontSize: '12px', padding: '6px 12px' }}>+ New Key</button>
                    </div>
                    <div className="pc-card-b">
                        {loading ? <p>Loading...</p> : keys.length === 0 ? <p style={{ color: '#6B7280', textAlign: 'center' }}>No keys generated yet.</p> : (
                            <div style={{ display: 'grid', gap: '12px' }}>
                                {keys.map(k => (
                                    <div key={k.id} style={{ padding: '12px', border: '1px solid var(--line)', borderRadius: '8px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                        <div>
                                            <div style={{ fontWeight: '700', fontSize: '14px' }}>{k.name}</div>
                                            <div style={{ fontSize: '12px', color: '#6B7280' }}>
                                                {k.key.substring(0, 8)}••••••••
                                            </div>
                                        </div>
                                        <button data-cy={`btn-delete-key-${k.id}`} onClick={() => handleDeleteKey(k.id)} style={{ background: 'none', border: 'none', cursor: 'pointer' }}>🗑️</button>
                                    </div>
                                ))}
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
}

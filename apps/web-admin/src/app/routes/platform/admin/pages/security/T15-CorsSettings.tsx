import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry } = AdminRegistry;

const CorsSettings: React.FC = () => {
    const [config, setConfig] = useState<{
        corsAllowedOrigins: string[];
        corsAllowedMethods: string[];
        corsAllowedHeaders: string[];
    }>({
        corsAllowedOrigins: [],
        corsAllowedMethods: [],
        corsAllowedHeaders: []
    });
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);
    const [message, setMessage] = useState('');

    useEffect(() => {
        fetchConfig();
    }, []);

    const fetchConfig = async () => {
        try {
            const response = await fetch('/v1/admin/security/cors');
            const data = await response.json();
            setConfig(data);
        } catch (error) {
            console.error('Failed to fetch CORS config', error);
        } finally {
            setLoading(false);
        }
    };

    const handleSave = async () => {
        setSaving(true);
        setMessage('');
        try {
            const response = await fetch('/v1/admin/security/cors', {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(config)
            });
            if (response.ok) {
                setMessage('✅ CORS Configuration updated successfully. Changes are live.');
            } else {
                setMessage('❌ Failed to update configuration.');
            }
        } catch (error) {
            setMessage('❌ Error saving configuration.');
        } finally {
            setSaving(false);
        }
    };

    if (loading) return <div className="pc-loader">Loading Security Context...</div>;

    return (
        <div className="pc-page" style={{ padding: '24px', maxWidth: '800px' }}>
            <div className="pc-card" style={{ padding: '32px' }}>
                <header style={{ marginBottom: '24px' }}>
                    <h2 style={{ fontSize: '24px', fontWeight: '700', color: '#111827' }}>🌐 Runtime CORS Management</h2>
                    <p style={{ color: '#6B7280', marginTop: '8px' }}>
                        Configure cross-origin resource sharing at runtime. Changes take effect immediately across all worker nodes.
                    </p>
                </header>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                    {/* Allowed Origins */}
                    <div>
                        <label style={{ display: 'block', fontWeight: '600', marginBottom: '8px', fontSize: '14px' }}>Allowed Origins</label>
                        <textarea
                            style={{ width: '100%', padding: '12px', border: '1px solid #D1D5DB', borderRadius: '8px', minHeight: '80px', fontFamily: 'monospace' }}
                            value={config.corsAllowedOrigins.join('\n')}
                            onChange={(e) => setConfig({ ...config, corsAllowedOrigins: e.target.value.split('\n').filter(s => s.trim()) })}
                            placeholder="https://example.com&#10;http://localhost:3000"
                        />
                        <p style={{ fontSize: '12px', color: '#9CA3AF', marginTop: '4px' }}>One origin per line. Use * for public access (not recommended for production).</p>
                    </div>

                    {/* Allowed Methods */}
                    <div>
                        <label style={{ display: 'block', fontWeight: '600', marginBottom: '12px', fontSize: '14px' }}>Allowed Methods</label>
                        <div style={{ display: 'flex', gap: '12px', flexWrap: 'wrap' }}>
                            {['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'].map(method => (
                                <label key={method} style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 12px', background: '#F9FAFB', border: '1px solid #E5E7EB', borderRadius: '6px', cursor: 'pointer' }}>
                                    <input
                                        type="checkbox"
                                        checked={config.corsAllowedMethods.includes(method)}
                                        onChange={(e) => {
                                            const methods = e.target.checked
                                                ? [...config.corsAllowedMethods, method]
                                                : config.corsAllowedMethods.filter(m => m !== method);
                                            setConfig({ ...config, corsAllowedMethods: methods });
                                        }}
                                    />
                                    <span style={{ fontSize: '14px', fontWeight: '500' }}>{method}</span>
                                </label>
                            ))}
                        </div>
                    </div>

                    {/* Allowed Headers */}
                    <div>
                        <label style={{ display: 'block', fontWeight: '600', marginBottom: '8px', fontSize: '14px' }}>Allowed Headers</label>
                        <input
                            type="text"
                            className="pc-input"
                            style={{ width: '100%' }}
                            value={config.corsAllowedHeaders.join(', ')}
                            onChange={(e) => setConfig({ ...config, corsAllowedHeaders: e.target.value.split(',').map(s => s.trim()).filter(s => s) })}
                        />
                        <p style={{ fontSize: '12px', color: '#9CA3AF', marginTop: '4px' }}>Comma-separated list (e.g., Content-Type, Authorization, X-Tenant-ID)</p>
                    </div>

                    <div style={{ marginTop: '12px', display: 'flex', alignItems: 'center', gap: '16px' }}>
                        <button
                            className="pc-button pc-button-primary"
                            onClick={handleSave}
                            disabled={saving}
                            style={{ minWidth: '160px' }}
                        >
                            {saving ? 'Updating Gateways...' : 'Apply Configuration'}
                        </button>
                        {message && <span style={{ fontSize: '14px', fontWeight: '500' }}>{message}</span>}
                    </div>
                </div>

                <div style={{ marginTop: '32px', padding: '16px', background: '#FEF3C7', border: '1px solid #F59E0B', borderRadius: '8px' }}>
                    <h4 style={{ color: '#92400E', fontSize: '14px', fontWeight: '600', marginBottom: '4px' }}>⚠️ Security Warning</h4>
                    <p style={{ color: '#B45309', fontSize: '13px' }}>
                        Incorrect CORS settings can block access to the entire platform or expose sensitive endpoints to CSRF attacks. Always verify origins before applying.
                    </p>
                </div>
            </div>
        </div>
    );
};

export default CorsSettings;

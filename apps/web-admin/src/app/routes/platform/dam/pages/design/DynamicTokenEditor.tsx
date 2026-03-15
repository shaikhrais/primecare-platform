import React, { useState, useEffect } from 'react';
import { Settings, Palette, Eye, Maximize, AlertTriangle, Save } from 'lucide-react';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useNotification } from '@/shared/context/NotificationContext';

interface DesignToken {
    id: string;
    label: string;
    cssVar: string;
    value: string;
    type: 'color' | 'size' | 'radius';
}

export const DynamicTokenEditor: React.FC = () => {
    const [tokens, setTokens] = useState<DesignToken[]>([
        { id: '1', label: 'Primary Brand Color', cssVar: '--color-primary', value: '#2563EB', type: 'color' },
        { id: '2', label: 'Success Feedback', cssVar: '--color-success', value: '#10B981', type: 'color' },
        { id: '3', label: 'Danger Alert', cssVar: '--color-danger', value: '#EF4444', type: 'color' },
        { id: '4', label: 'Global Border Radius', cssVar: '--radius-global', value: '8px', type: 'radius' },
        { id: '5', label: 'Base Spacing Unit', cssVar: '--spacing-base', value: '16px', type: 'size' }
    ]);
    
    const { showToast } = useNotification();

    // Live update the actual document root to show real-time changes
    useEffect(() => {
        tokens.forEach(token => {
            document.documentElement.style.setProperty(token.cssVar, token.value);
        });
    }, [tokens]);

    const handleTokenChange = (id: string, newValue: string) => {
        setTokens(prev => prev.map(t => t.id === id ? { ...t, value: newValue } : t));
    };

    const saveMutation = useApiMutation('/platform/admin/dam/design/sync-tokens', {
        onSuccess: () => { showToast('Design tokens compiled and pushed to all themes.', 'success'); },
        onError: () => { showToast('Failed to persist design tokens', 'error'); },
    });

    const handleSaveGlobal = () => saveMutation.mutate({ tokens });

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', paddingBottom: '16px', borderBottom: '1px solid #E2E8F0' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FAF5FF', padding: '10px', borderRadius: '8px' }}>
                        <Palette size={24} color="#9333EA" />
                    </div>
                    <div>
                        <h3 data-cy="h3-dynamic-token-editor-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Dynamic Token Editor</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Override CSS variables live across the platform.</p>
                    </div>
                </div>
                
                <button 
                    data-cy="dam.tokens.btn-deploy"
                    onClick={handleSaveGlobal}
                    disabled={saveMutation.isPending}
                    style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: saveMutation.isPending ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                >
                    <Save size={16} /> {saveMutation.isPending ? 'Deploying...' : 'Deploy to Production'}
                </button>
            </div>

            <div style={{ display: 'flex', gap: '32px' }}>
                {/* Editor Column */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    <div style={{ fontWeight: 800, color: '#475569', fontSize: '0.9rem', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <Settings size={16} /> Token Override Schema
                    </div>
                    
                    {tokens.map(token => (
                        <div key={token.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                            <div>
                                <div style={{ fontWeight: 700, color: '#0F172A', fontSize: '0.9rem' }}>{token.label}</div>
                                <div style={{ fontSize: '0.75rem', color: '#64748B', fontFamily: 'monospace' }}>{token.cssVar}</div>
                            </div>
                            
                            <div>
                                {token.type === 'color' ? (
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        <input 
                                            data-cy={`dam.tokens.inp-${token.id}`}
                                            type="color" 
                                            value={token.value} 
                                            onChange={(e) => handleTokenChange(token.id, e.target.value)}
                                            style={{ width: '40px', height: '40px', padding: '0', border: '2px solid #E2E8F0', borderRadius: '6px', cursor: 'pointer' }}
                                        />
                                        <span style={{ fontFamily: 'monospace', fontSize: '0.85rem', color: '#475569' }}>{token.value.toUpperCase()}</span>
                                    </div>
                                ) : (
                                    <input 
                                        data-cy={`dam.tokens.inp-${token.id}`}
                                        type="text" 
                                        value={token.value}
                                        onChange={(e) => handleTokenChange(token.id, e.target.value)}
                                        style={{ width: '80px', padding: '8px', border: '1px solid #CBD5E1', borderRadius: '6px', textAlign: 'right', fontFamily: 'monospace' }}
                                    />
                                )}
                            </div>
                        </div>
                    ))}
                </div>

                {/* Live Preview Column */}
                <div style={{ width: '350px' }}>
                    <div style={{ fontWeight: 800, color: '#475569', fontSize: '0.9rem', marginBottom: '16px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <Eye size={16} /> Live Component Preview
                    </div>
                    
                    <div style={{ border: '2px dashed #E2E8F0', borderRadius: '12px', padding: '24px', backgroundColor: '#F8FAFC', display: 'flex', flexDirection: 'column', gap: '20px' }}>
                        
                        {/* Sample Card using the tokens */}
                        <div style={{ 
                            backgroundColor: 'white', 
                            padding: 'var(--spacing-base, 16px)', 
                            borderRadius: 'var(--radius-global, 8px)',
                            border: '1px solid #E2E8F0',
                            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
                        }}>
                            <h4 style={{ margin: '0 0 12px 0', color: '#0F172A' }}>Client Assessment</h4>
                            
                            <div style={{ display: 'flex', gap: '8px', marginBottom: '16px' }}>
                                <span style={{ backgroundColor: 'var(--color-success, #10B981)', color: 'white', padding: '4px 8px', borderRadius: '20px', fontSize: '0.7rem', fontWeight: 800 }}>Cleared</span>
                                <span style={{ backgroundColor: 'var(--color-danger, #EF4444)', color: 'white', padding: '4px 8px', borderRadius: '20px', fontSize: '0.7rem', fontWeight: 800 }}>High Fall Risk</span>
                            </div>

                            <button data-cy="btn-dynamic-token-editor-0" style={{ 
                                width: '100%', 
                                padding: '10px', 
                                backgroundColor: 'var(--color-primary, #2563EB)', 
                                color: 'white', 
                                border: 'none', 
                                borderRadius: 'var(--radius-global, 8px)',
                                cursor: 'pointer',
                                fontWeight: 700
                            }}>
                                Save Assessment
                            </button>
                        </div>
                        
                        <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: 'var(--radius-global, 8px)', border: '1px solid #FECACA', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.8rem', color: '#991B1B' }}>
                            <AlertTriangle size={16} color="var(--color-danger, #EF4444)" />
                            <span style={{ fontWeight: 600 }}>Emergency Protocol Active</span>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    );
};

import React, { useState } from 'react';
import { EyeOff, Type, BarChart, CheckCircle2, ShieldAlert, Image as ImageIcon, Save } from 'lucide-react';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useToast as useNotification } from '@/shared/hooks/useToast';

interface VisuallyComplexAsset {
    id: string;
    type: 'CHART' | 'SVG' | 'IMAGE';
    title: string;
    ariaLabel: string;
    status: 'COMPLIANT' | 'MISSING_ARIA';
}

export const ScreenReaderContentEditor: React.FC = () => {
    const [assets, setAssets] = useState<VisuallyComplexAsset[]>([
        { id: '1', type: 'CHART', title: 'Q3 Patient Demographics Pie Chart', ariaLabel: 'A pie chart showing patient demographics for quarter 3: 40% elderly, 35% adult, 25% pediatric.', status: 'COMPLIANT' },
        { id: '2', type: 'SVG', title: 'Interactive Anatomy Diagram - Heart', ariaLabel: '', status: 'MISSING_ARIA' },
        { id: '3', type: 'IMAGE', title: 'Staff Headshot - Dr. Emily Chen', ariaLabel: 'Headshot photograph of Dr. Emily Chen, Chief Medical Officer, wearing a white coat and smiling.', status: 'COMPLIANT' },
        { id: '4', type: 'CHART', title: 'Weekly Overtime Bar Graph', ariaLabel: '', status: 'MISSING_ARIA' }
    ]);
    const { showToast } = useNotification();

    const handleAriaChange = (id: string, newLabel: string) => {
        setAssets(prev => prev.map(a => {
            if (a.id === id) {
                return { 
                    ...a, 
                    ariaLabel: newLabel, 
                    status: newLabel.length > 10 ? 'COMPLIANT' : 'MISSING_ARIA' 
                };
            }
            return a;
        }));
    };

    const saveMutation = useApiMutation('/platform/admin/dam/accessibility/aria-labels', {
        onSuccess: () => { showToast('ARIA label patches applied.', 'success'); },
        onError: () => { showToast('Failed to patch accessibility tree', 'error'); },
    });

    const handleSave = () => saveMutation.mutate({ assets });

    const getIcon = (type: string) => {
        switch(type) {
            case 'CHART': return <BarChart size={18} color="#8B5CF6" />;
            case 'SVG': return <Type size={18} color="#F59E0B" />;
            case 'IMAGE': return <ImageIcon size={18} color="#3B82F6" />;
            default: return <ImageIcon size={18} />;
        }
    };

    const compliantCount = assets.filter(a => a.status === 'COMPLIANT').length;
    const missingCount = assets.filter(a => a.status === 'MISSING_ARIA').length;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FDF4FF', padding: '10px', borderRadius: '8px' }}>
                        <EyeOff size={24} color="#C026D3" />
                    </div>
                    <div>
                        <h3 data-cy="h3-screen-reader-content-editor-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Screen Reader Accessibility Editor</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Enforce explicit aria-labels on visually complex charts and UI elements.</p>
                    </div>
                </div>

                <button 
                    data-cy="dam.a11y.btn-save"
                    onClick={handleSave}
                    disabled={saveMutation.isPending || missingCount > 0}
                    style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: (saveMutation.isPending || missingCount > 0) ? 'not-allowed' : 'pointer', opacity: (saveMutation.isPending || missingCount > 0) ? 0.6 : 1, display: 'flex', alignItems: 'center', gap: '8px' }}
                >
                    <Save size={16} /> {saveMutation.isPending ? 'Injecting Tags...' : 'Enforce Accessibility Standards'}
                </button>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                
                {/* Editor List */}
                <div style={{ flex: 2, display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    {assets.map(asset => (
                        <div key={asset.id} style={{ 
                            border: `2px solid ${asset.status === 'MISSING_ARIA' ? '#FECACA' : '#E2E8F0'}`, 
                            borderRadius: '8px', padding: '16px', 
                            backgroundColor: asset.status === 'MISSING_ARIA' ? '#FEF2F2' : 'white',
                            display: 'flex', flexDirection: 'column', gap: '12px'
                        }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 700, color: '#0F172A' }}>
                                    <div style={{ backgroundColor: '#F1F5F9', padding: '6px', borderRadius: '4px' }}>
                                        {getIcon(asset.type)}
                                    </div>
                                    {asset.title}
                                </div>
                                {asset.status === 'COMPLIANT' ? (
                                    <span style={{ backgroundColor: '#D1FAE5', color: '#065F46', padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}>
                                        <CheckCircle2 size={14} /> WCAG AAA COMPLIANT
                                    </span>
                                ) : (
                                    <span style={{ backgroundColor: '#FEE2E2', color: '#991B1B', padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}>
                                        <ShieldAlert size={14} /> MISSING ARIA-LABEL
                                    </span>
                                )}
                            </div>

                            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                                <label style={{ fontSize: '0.8rem', color: '#475569', fontWeight: 600 }}>Screen Reader Text (aria-label):</label>
                                <textarea 
                                    data-cy={`dam.a11y.inp-aria-${asset.id}`}
                                    value={asset.ariaLabel}
                                    placeholder="Describe this visual element in detail for visually impaired users..."
                                    onChange={(e) => handleAriaChange(asset.id, e.target.value)}
                                    style={{ 
                                        width: '100%', minHeight: '80px', padding: '12px', borderRadius: '6px', 
                                        border: `1px dashed ${asset.status === 'MISSING_ARIA' ? '#F87171' : '#CBD5E1'}`, 
                                        outline: 'none', resize: 'vertical', fontFamily: 'sans-serif',
                                        backgroundColor: asset.status === 'MISSING_ARIA' ? 'white' : '#F8FAFC'
                                    }}
                                />
                            </div>
                        </div>
                    ))}
                </div>

                {/* Audit Scorecard */}
                <div style={{ flex: 1, backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', padding: '24px', display: 'flex', flexDirection: 'column', gap: '20px', height: 'fit-content' }}>
                    <div style={{ fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', borderBottom: '1px solid #E2E8F0', paddingBottom: '16px' }}>
                        Platform Accessibility Scan
                    </div>

                    <div style={{ border: '1px solid #CBD5E1', borderRadius: '8px', overflow: 'hidden' }}>
                        <div style={{ backgroundColor: 'white', padding: '16px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #E2E8F0' }}>
                            <span style={{ color: '#475569', fontWeight: 600, fontSize: '0.9rem' }}>Total Complex Elements</span>
                            <span style={{ color: '#0F172A', fontWeight: 800, fontSize: '1.2rem' }}>{assets.length}</span>
                        </div>
                        <div style={{ backgroundColor: 'white', padding: '16px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #E2E8F0' }}>
                            <span style={{ color: '#475569', fontWeight: 600, fontSize: '0.9rem', display: 'flex', alignItems: 'center', gap: '6px' }}><CheckCircle2 size={16} color="#10B981" /> Compliant</span>
                            <span style={{ color: '#10B981', fontWeight: 800, fontSize: '1.2rem' }}>{compliantCount}</span>
                        </div>
                        <div style={{ backgroundColor: '#FEF2F2', padding: '16px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span style={{ color: '#991B1B', fontWeight: 600, fontSize: '0.9rem', display: 'flex', alignItems: 'center', gap: '6px' }}><ShieldAlert size={16} color="#DC2626" /> Missing Labels</span>
                            <span style={{ color: '#DC2626', fontWeight: 800, fontSize: '1.2rem' }}>{missingCount}</span>
                        </div>
                    </div>

                    {missingCount > 0 && (
                        <div style={{ backgroundColor: '#FFFBEB', color: '#B45309', border: '1px solid #FDE68A', borderRadius: '6px', padding: '12px', fontSize: '0.8rem', fontWeight: 500, lineHeight: 1.5 }}>
                            <strong>Compliance Warning:</strong> You cannot deploy these application updates until all {missingCount} visual elements have been assigned an explicit `aria-label` for screen reader platforms.
                        </div>
                    )}
                </div>

            </div>
        </div>
    );
};

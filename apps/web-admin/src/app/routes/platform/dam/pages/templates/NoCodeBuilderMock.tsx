import React, { useState } from 'react';
import { LayoutTemplate, Move, PlusCircle, Trash2, Smartphone, Monitor } from 'lucide-react';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useNotification } from '@/shared/context/NotificationContext';

interface Block {
    id: string;
    type: 'HERO' | 'FORM' | 'STAT_GRID' | 'TEXT_BLOCK';
    label: string;
}

export const NoCodeBuilderMock: React.FC = () => {
    const [blocks, setBlocks] = useState<Block[]>([
        { id: 'b1', type: 'HERO', label: 'Welcome Banner (Standard)' },
        { id: 'b2', type: 'STAT_GRID', label: 'Patient Vitals Overview' }
    ]);
    const [viewMode, setViewMode] = useState<'MOBILE' | 'DESKTOP'>('DESKTOP');
    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const handleAddBlock = (type: Block['type'], label: string) => {
        setBlocks(prev => [...prev, { id: `b_${Date.now()}`, type, label }]);
    };

    const handleRemoveBlock = (id: string) => {
        setBlocks(prev => prev.filter(b => b.id !== id));
    };

    const templateMutation = useApiMutation('/platform/admin/dam/templates/no-code', {
        onSuccess: () => { showToast('JSON Template Structure saved to DB.', 'success'); },
        onError: () => { showToast('Failed to lock layout templates', 'error'); },
    });

    const handleSaveTemplate = () => templateMutation.mutate({ blocks });

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', overflow: 'hidden', marginTop: '16px' }}>
            <div style={{ backgroundColor: '#F8FAFC', padding: '16px 24px', borderBottom: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#EEF2FF', padding: '8px', borderRadius: '8px' }}>
                        <LayoutTemplate size={20} color="#6366F1" />
                    </div>
                    <div>
                        <h3 data-cy="h3-no-code-builder-mock-0" style={{ margin: 0, fontSize: '1.1rem', color: '#0F172A', fontWeight: 800 }}>No-Code Page Templater</h3>
                        <p style={{ margin: '2px 0 0 0', color: '#64748B', fontSize: '0.8rem' }}>Assemble layout schemas using registered components.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
                    <div style={{ display: 'flex', backgroundColor: '#E2E8F0', borderRadius: '6px', padding: '2px' }}>
                        <button 
                            data-cy="dam.template.btn-mobile"
                            onClick={() => setViewMode('MOBILE')}
                            style={{ padding: '6px 12px', borderRadius: '4px', border: 'none', cursor: 'pointer', backgroundColor: viewMode === 'MOBILE' ? 'white' : 'transparent', boxShadow: viewMode === 'MOBILE' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none', color: viewMode === 'MOBILE' ? '#0F172A' : '#64748B' }}
                        >
                            <Smartphone size={16} />
                        </button>
                        <button 
                            data-cy="dam.template.btn-desktop"
                            onClick={() => setViewMode('DESKTOP')}
                            style={{ padding: '6px 12px', borderRadius: '4px', border: 'none', cursor: 'pointer', backgroundColor: viewMode === 'DESKTOP' ? 'white' : 'transparent', boxShadow: viewMode === 'DESKTOP' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none', color: viewMode === 'DESKTOP' ? '#0F172A' : '#64748B' }}
                        >
                            <Monitor size={16} />
                        </button>
                    </div>

                    <button 
                        data-cy="dam.template.btn-export"
                        onClick={handleSaveTemplate}
                        disabled={isSaving}
                        style={{ padding: '8px 16px', backgroundColor: '#2563EB', color: 'white', border: 'none', borderRadius: '6px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', fontSize: '0.85rem' }}
                    >
                        {isSaving ? 'Saving Schema...' : 'Export JSON Schema'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', minHeight: '500px' }}>
                {/* Block Palette */}
                <div style={{ width: '280px', borderRight: '1px solid #E2E8F0', padding: '24px', backgroundColor: '#F8FAFC' }}>
                    <h4 style={{ margin: '0 0 16px 0', fontSize: '0.85rem', color: '#475569', textTransform: 'uppercase', letterSpacing: '0.5px' }}>Component Library</h4>
                    
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                        <div 
                            data-cy="dam.template.add-hero"
                            onClick={() => handleAddBlock('HERO', 'Hero Banner')}
                            style={{ padding: '12px', backgroundColor: 'white', border: '1px dashed #CBD5E1', borderRadius: '6px', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.85rem', fontWeight: 600, color: '#334155' }}
                        >
                            <PlusCircle size={16} color="#6366F1" /> Hero Banner
                        </div>
                        <div 
                            data-cy="dam.template.add-stat-grid"
                            onClick={() => handleAddBlock('STAT_GRID', 'Metrics Grid (3-Col)')}
                            style={{ padding: '12px', backgroundColor: 'white', border: '1px dashed #CBD5E1', borderRadius: '6px', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.85rem', fontWeight: 600, color: '#334155' }}
                        >
                            <PlusCircle size={16} color="#6366F1" /> Metrics Grid (3-Col)
                        </div>
                        <div 
                            data-cy="dam.template.add-form"
                            onClick={() => handleAddBlock('FORM', 'Authentication Form')}
                            style={{ padding: '12px', backgroundColor: 'white', border: '1px dashed #CBD5E1', borderRadius: '6px', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.85rem', fontWeight: 600, color: '#334155' }}
                        >
                            <PlusCircle size={16} color="#6366F1" /> Authentication Form
                        </div>
                        <div 
                            data-cy="dam.template.add-text"
                            onClick={() => handleAddBlock('TEXT_BLOCK', 'Markdown Text Area')}
                            style={{ padding: '12px', backgroundColor: 'white', border: '1px dashed #CBD5E1', borderRadius: '6px', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.85rem', fontWeight: 600, color: '#334155' }}
                        >
                            <PlusCircle size={16} color="#6366F1" /> Markdown Text Area
                        </div>
                    </div>
                </div>

                {/* Canvas Canvas Area */}
                <div style={{ flex: 1, padding: '24px', display: 'flex', justifyContent: 'center', backgroundColor: '#F1F5F9', overflowY: 'auto' }}>
                    <div style={{ 
                        width: viewMode === 'DESKTOP' ? '100%' : '375px', 
                        backgroundColor: 'white', 
                        border: '1px solid #E2E8F0', 
                        borderRadius: viewMode === 'MOBILE' ? '24px' : '8px', 
                        minHeight: '100%',
                        padding: '16px',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '12px',
                        transition: 'width 0.3s ease'
                    }}>
                        {blocks.length === 0 ? (
                            <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', border: '2px dashed #E2E8F0', borderRadius: '8px' }}>
                                Drag or click components to build page.
                            </div>
                        ) : (
                            blocks.map((block) => (
                                <div key={block.id} style={{ padding: '16px', border: '1px solid #CBD5E1', backgroundColor: '#F8FAFC', borderRadius: '6px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', cursor: 'grab' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                        <Move size={16} color="#94A3B8" />
                                        <div style={{ fontSize: '0.85rem', fontWeight: 700, color: '#0F172A' }}>{block.label}</div>
                                    </div>
                                    <button data-cy={`dam.template.btn-remove-${block.id}`} onClick={() => handleRemoveBlock(block.id)} style={{ background: 'transparent', border: 'none', cursor: 'pointer', color: '#EF4444' }}>
                                        <Trash2 size={16} />
                                    </button>
                                </div>
                            ))
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};

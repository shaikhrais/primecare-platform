import React, { useState } from 'react';
import { Component, Type, RotateCcw, Save, Settings2 } from 'lucide-react';

export const InteractivePlayground: React.FC = () => {
    const [selectedSize, setSelectedSize] = useState<'sm' | 'md' | 'lg'>('md');
    const [selectedVariant, setSelectedVariant] = useState<'primary' | 'secondary' | 'danger' | 'ghost'>('primary');
    const [isDisabled, setIsDisabled] = useState(false);
    const [buttonText, setButtonText] = useState('Test Action String');

    // Pseudo-Component Renderer based on selected props
    const renderComponent = () => {
        let bg = '#2563EB';
        let customColor = 'white';
        let border = 'none';

        if (selectedVariant === 'secondary') {
            bg = '#F1F5F9';
            customColor = '#0F172A';
        } else if (selectedVariant === 'danger') {
            bg = '#DC2626';
        } else if (selectedVariant === 'ghost') {
            bg = 'transparent';
            customColor = '#2563EB';
            border = '2px solid #2563EB';
        }

        let padding = '10px 20px';
        let fontSize = '0.9rem';
        
        if (selectedSize === 'sm') {
            padding = '6px 12px';
            fontSize = '0.75rem';
        } else if (selectedSize === 'lg') {
            padding = '14px 28px';
            fontSize = '1.1rem';
        }

        return (
            <button 
                data-cy="playground-preview-btn"
                disabled={isDisabled}
                style={{
                    backgroundColor: isDisabled ? '#E2E8F0' : bg,
                    color: isDisabled ? '#94A3B8' : customColor,
                    border: isDisabled ? 'none' : border,
                    padding,
                    fontSize,
                    borderRadius: '8px',
                    fontWeight: 700,
                    cursor: isDisabled ? 'not-allowed' : 'pointer',
                    transition: 'all 0.2s',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '8px'
                }}
            >
                {buttonText}
            </button>
        );
    };

    return (
        <div style={{ backgroundColor: '#F8FAFC', border: '1px solid #E2E8F0', borderRadius: '12px', overflow: 'hidden', marginTop: '16px' }}>
            <div style={{ backgroundColor: '#0F172A', padding: '16px 24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: 'white', fontWeight: 700 }}>
                    <Settings2 size={20} color="#38BDF8" /> UI Component Sandbox
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="btn-reset-props" style={{ backgroundColor: 'transparent', color: '#94A3B8', border: '1px solid #334155', borderRadius: '6px', padding: '6px 12px', fontSize: '0.8rem', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <RotateCcw size={14} /> Reset Props
                    </button>
                    <button data-cy="btn-update-registry" style={{ backgroundColor: '#38BDF8', color: '#0F172A', border: 'none', borderRadius: '6px', padding: '6px 12px', fontSize: '0.8rem', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <Save size={14} /> Update Global Registry
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', minHeight: '400px' }}>
                {/* Prop Controls Sidebar */}
                <div style={{ width: '300px', backgroundColor: 'white', borderRight: '1px solid #E2E8F0', padding: '24px', display: 'flex', flexDirection: 'column', gap: '20px' }}>
                    
                    <div>
                        <label style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem', fontWeight: 700, color: '#475569', marginBottom: '8px' }}>
                            <Type size={14} /> Content String
                        </label>
                        <input 
                            data-cy="playground-text-input"
                            type="text" 
                            value={buttonText} 
                            onChange={(e) => setButtonText(e.target.value)}
                            style={{ width: '100%', padding: '8px', borderRadius: '6px', border: '1px solid #CBD5E1', fontSize: '0.9rem' }} 
                        />
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '0.8rem', fontWeight: 700, color: '#475569', marginBottom: '8px' }}>Variant (Hierarchy)</label>
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '8px' }}>
                            {['primary', 'secondary', 'danger', 'ghost'].map(v => (
                                <button 
                                    key={v}
                                    data-cy={`playground-variant-${v}`}
                                    onClick={() => setSelectedVariant(v as any)}
                                    style={{ 
                                        padding: '6px', fontSize: '0.8rem', borderRadius: '4px', cursor: 'pointer',
                                        backgroundColor: selectedVariant === v ? '#DBEAFE' : '#F1F5F9',
                                        color: selectedVariant === v ? '#1D4ED8' : '#475569',
                                        border: `1px solid ${selectedVariant === v ? '#93C5FD' : '#E2E8F0'}`,
                                        fontWeight: selectedVariant === v ? 700 : 500,
                                        textTransform: 'capitalize'
                                    }}
                                >
                                    {v}
                                </button>
                            ))}
                        </div>
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '0.8rem', fontWeight: 700, color: '#475569', marginBottom: '8px' }}>Size Scale</label>
                        <div style={{ display: 'flex', gap: '8px' }}>
                            {['sm', 'md', 'lg'].map(s => (
                                <button 
                                    key={s}
                                    data-cy={`playground-size-${s}`}
                                    onClick={() => setSelectedSize(s as any)}
                                    style={{ 
                                        flex: 1, padding: '6px', fontSize: '0.8rem', borderRadius: '4px', cursor: 'pointer',
                                        backgroundColor: selectedSize === s ? '#DBEAFE' : '#F1F5F9',
                                        color: selectedSize === s ? '#1D4ED8' : '#475569',
                                        border: `1px solid ${selectedSize === s ? '#93C5FD' : '#E2E8F0'}`,
                                        fontWeight: selectedSize === s ? 700 : 500,
                                        textTransform: 'uppercase'
                                    }}
                                >
                                    {s}
                                </button>
                            ))}
                        </div>
                    </div>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '8px' }}>
                        <input 
                            data-cy="playground-disabled-toggle"
                            type="checkbox" 
                            id="disabledToggle" 
                            checked={isDisabled} 
                            onChange={(e) => setIsDisabled(e.target.checked)} 
                            style={{ width: '16px', height: '16px' }}
                        />
                        <label htmlFor="disabledToggle" style={{ fontSize: '0.85rem', fontWeight: 600, color: '#475569', cursor: 'pointer' }}>
                            Force Disabled State
                        </label>
                    </div>
                </div>

                {/* Canvas Render Area */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
                    <div style={{ padding: '12px 24px', borderBottom: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center', color: '#64748B', fontSize: '0.8rem', fontWeight: 600 }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                            <Component size={14} /> Active Preview: {'<PrimaryButton />'}
                        </div>
                        <div>Viewport: 100%</div>
                    </div>
                    
                    {/* The Stage */}
                    <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', backgroundImage: 'radial-gradient(#E2E8F0 1px, transparent 1px)', backgroundSize: '20px 20px', backgroundColor: '#F8FAFC' }}>
                        {renderComponent()}
                    </div>
                </div>
            </div>
        </div>
    );
};

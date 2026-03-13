import React, { useRef, useState, useEffect } from 'react';
import { Pen, RotateCcw, Check } from 'lucide-react';

interface SignaturePadProps {
    onSign?: (base64Signature: string) => void;
    onSave?: (base64Signature: string) => void;
    onCancel?: () => void;
    onClear?: () => void;
    width?: number;
    height?: number;
}

export const SignaturePad: React.FC<SignaturePadProps> = ({ onSign, onSave, onCancel, onClear, width, height }) => {
    const canvasRef = useRef<HTMLCanvasElement>(null);
    const [isDrawing, setIsDrawing] = useState(false);
    const [hasSigned, setHasSigned] = useState(false);

    // Context initialization
    useEffect(() => {
        const canvas = canvasRef.current;
        if (!canvas) return;
        
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        // Set up high-fidelity canvas styling
        ctx.strokeStyle = '#0F172A'; // Dark slate ink
        ctx.lineJoin = 'round';
        ctx.lineCap = 'round';
        ctx.lineWidth = 3;

        // Prevent scrolling on touch devices while signing
        const preventScroll = (e: TouchEvent) => e.preventDefault();
        canvas.addEventListener('touchstart', preventScroll, { passive: false });
        canvas.addEventListener('touchmove', preventScroll, { passive: false });

        return () => {
            canvas.removeEventListener('touchstart', preventScroll);
            canvas.removeEventListener('touchmove', preventScroll);
        };
    }, []);

    const startDrawing = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
        setIsDrawing(true);
        setHasSigned(true);
        const canvas = canvasRef.current;
        const ctx = canvas?.getContext('2d');
        if (!canvas || !ctx) return;

        const rect = canvas.getBoundingClientRect();
        const x = ('touches' in e) ? e.touches[0].clientX - rect.left : (e as React.MouseEvent).clientX - rect.left;
        const y = ('touches' in e) ? e.touches[0].clientY - rect.top : (e as React.MouseEvent).clientY - rect.top;

        ctx.beginPath();
        ctx.moveTo(x, y);
    };

    const draw = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
        if (!isDrawing) return;
        
        const canvas = canvasRef.current;
        const ctx = canvas?.getContext('2d');
        if (!canvas || !ctx) return;

        const rect = canvas.getBoundingClientRect();
        const x = ('touches' in e) ? e.touches[0].clientX - rect.left : (e as React.MouseEvent).clientX - rect.left;
        const y = ('touches' in e) ? e.touches[0].clientY - rect.top : (e as React.MouseEvent).clientY - rect.top;

        ctx.lineTo(x, y);
        ctx.stroke();
    };

    const stopDrawing = () => {
        setIsDrawing(false);
        const canvas = canvasRef.current;
        const ctx = canvas?.getContext('2d');
        if (ctx) ctx.closePath();
    };

    const clearSignature = () => {
        const canvas = canvasRef.current;
        const ctx = canvas?.getContext('2d');
        if (!canvas || !ctx) return;
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        setHasSigned(false);
        if (onClear) onClear();
    };

    const handleConfirm = () => {
        const canvas = canvasRef.current;
        if (!canvas || !hasSigned) return;
        
        // Export as High Quality PNG Base64
        const dataUrl = canvas.toDataURL('image/png');
        if (onSign) onSign(dataUrl);
        if (onSave) onSave(dataUrl);
    };

    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E2E8F0', boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)' }}>
            
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '16px' }}>
                <Pen size={24} color="#3B82F6" />
                <h3 data-cy="h3-rn.signature-pad-0" style={{ margin: 0, fontSize: '1.25rem', fontWeight: 800, color: '#0F172A' }}>Provider Signature Required</h3>
            </div>
            
            <p style={{ color: '#64748B', marginBottom: '24px', fontSize: '0.9rem' }}>
                Please sign below using your finger, stylus, or mouse to authorize this clinical assessment.
            </p>

            {/* Signature Area */}
            <div style={{ position: 'relative', border: '2px dashed #CBD5E1', borderRadius: '12px', overflow: 'hidden', backgroundColor: '#F8FAFC' }}>
                <canvas 
                    ref={canvasRef}
                    width={width || 600}
                    height={height || 200}
                    style={{ display: 'block', width: '100%', cursor: 'crosshair', touchAction: 'none' }}
                    onMouseDown={startDrawing}
                    onMouseMove={draw}
                    onMouseUp={stopDrawing}
                    onMouseLeave={stopDrawing}
                    onTouchStart={startDrawing}
                    onTouchMove={draw}
                    onTouchEnd={stopDrawing}
                />
                
                {/* Signature Baseline */}
                <div style={{ position: 'absolute', bottom: '40px', left: '40px', right: '40px', borderBottom: '2px solid #E2E8F0', pointerEvents: 'none', display: 'flex', alignItems: 'flex-end' }}>
                     <span style={{ fontSize: '2rem', color: '#94A3B8', paddingBottom: '4px', fontStyle: 'italic', opacity: 0.5 }}>X</span>
                </div>
            </div>

            {/* Actions */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '24px' }}>
                <button data-cy="btn-rn.signature-pad-0" 
                    onClick={clearSignature}
                    style={{ background: 'none', border: 'none', display: 'flex', alignItems: 'center', gap: '8px', color: '#64748B', fontWeight: 700, cursor: 'pointer', padding: '8px 16px', borderRadius: '8px', transition: 'background-color 0.2s' }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#F1F5F9'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                >
                    <RotateCcw size={18} /> Clear Pad
                </button>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="btn-rn.signature-pad-1" onClick={onCancel} style={{ background: 'none', border: '1px solid #CBD5E1', color: '#64748B', fontWeight: 800, padding: '12px 24px', borderRadius: '8px', cursor: 'pointer' }}>
                        Cancel
                    </button>
                    <button data-cy="btn-rn.signature-pad-2" 
                        onClick={handleConfirm}
                        disabled={!hasSigned}
                        style={{ backgroundColor: hasSigned ? '#10B981' : '#E2E8F0', color: hasSigned ? 'white' : '#94A3B8', border: 'none', fontWeight: 800, padding: '12px 24px', borderRadius: '8px', display: 'flex', alignItems: 'center', gap: '8px', cursor: hasSigned ? 'pointer' : 'default', transition: 'background-color 0.2s' }}
                    >
                        <Check size={18} /> Accept Signature
                    </button>
                </div>
            </div>

        </div>
    );
};

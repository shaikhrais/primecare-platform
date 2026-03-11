import React, { useRef, useState, useEffect } from 'react';
import { Image as ImageIcon, Crosshair, XCircle, FileCheck } from 'lucide-react';

interface WoundCanvasProps {
    imageUrl?: string;
}

export const WoundCanvas: React.FC<WoundCanvasProps> = ({ imageUrl = "https://images.unsplash.com/photo-1628186105315-e232938b813b?q=80&w=800&auto=format&fit=crop" }) => {
    const canvasRef = useRef<HTMLCanvasElement>(null);
    const containerRef = useRef<HTMLDivElement>(null);
    const [imageLoaded, setImageLoaded] = useState(false);
    const [mode, setMode] = useState<'draw' | 'pin'>('draw');
    const [pins, setPins] = useState<{x: number, y: number}[]>([]);
    
    // Draw state
    const [isDrawing, setIsDrawing] = useState(false);

    useEffect(() => {
        // Load dynamic wound base image onto canvas
        const canvas = canvasRef.current;
        const ctx = canvas?.getContext('2d');
        if (!canvas || !ctx) return;

        const img = new Image();
        img.crossOrigin = "anonymous";
        // Safe anatomical stock photo or dynamic prop
        img.src = imageUrl; 
        img.onload = () => {
             // Draw image to fill canvas
             ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
             setImageLoaded(true);
             
             // Set default draw style
             ctx.strokeStyle = '#EF4444'; // Red for tracing necrotic boundaries
             ctx.lineWidth = 3;
             ctx.lineCap = 'round';
             ctx.lineJoin = 'round';
        };
    }, []);

    const handlePointerDown = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
        if (!imageLoaded) return;
        
        const canvas = canvasRef.current;
        const ctx = canvas?.getContext('2d');
        if (!canvas || !ctx) return;

        const rect = canvas.getBoundingClientRect();
        const x = ('touches' in e) ? e.touches[0].clientX - rect.left : (e as React.MouseEvent).clientX - rect.left;
        const y = ('touches' in e) ? e.touches[0].clientY - rect.top : (e as React.MouseEvent).clientY - rect.top;

        if (mode === 'draw') {
            setIsDrawing(true);
            ctx.beginPath();
            ctx.moveTo(x, y);
        } else if (mode === 'pin') {
            setPins(prev => [...prev, { x, y }]);
            // Draw a quick crosshair on the canvas permanently for the pin
            ctx.fillStyle = '#3B82F6';
            ctx.beginPath();
            ctx.arc(x, y, 6, 0, Math.PI * 2);
            ctx.fill();
            ctx.strokeStyle = '#FFFFFF';
            ctx.lineWidth = 2;
            ctx.stroke();
        }
    };

    const handlePointerMove = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
        if (!isDrawing || mode !== 'draw') return;
        
        const canvas = canvasRef.current;
        const ctx = canvas?.getContext('2d');
        if (!canvas || !ctx) return;

        const rect = canvas.getBoundingClientRect();
        const x = ('touches' in e) ? e.touches[0].clientX - rect.left : (e as React.MouseEvent).clientX - rect.left;
        const y = ('touches' in e) ? e.touches[0].clientY - rect.top : (e as React.MouseEvent).clientY - rect.top;

        ctx.lineTo(x, y);
        ctx.stroke();
    };

    const handlePointerUp = () => {
        if (mode === 'draw') {
            setIsDrawing(false);
            const ctx = canvasRef.current?.getContext('2d');
            if (ctx) ctx.closePath();
        }
    };

    const handleClear = () => {
        const canvas = canvasRef.current;
        const ctx = canvas?.getContext('2d');
        if (!canvas || !ctx) return;
        
        // Redraw image to wipe
        const img = new Image();
        img.crossOrigin = "anonymous";
        img.src = imageUrl; 
        img.onload = () => {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
             // Reapply drawing styles
             ctx.strokeStyle = '#EF4444'; 
             ctx.lineWidth = 3;
             ctx.lineCap = 'round';
             ctx.lineJoin = 'round';
        };
        setPins([]);
    };

    return (
        <section style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '16px', overflow: 'hidden' }}>
            
            {/* Toolbar */}
            <div style={{ backgroundColor: '#F8FAFC', padding: '16px 24px', borderBottom: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <ImageIcon size={20} color="#64748B" />
                    <h2 style={{ fontSize: '1.1rem', fontWeight: 800, margin: 0, color: '#0F172A' }}>Wound Analysis Canvas</h2>
                </div>
                
                <div style={{ display: 'flex', gap: '8px' }}>
                    <button 
                        onClick={() => setMode('draw')}
                        style={{ 
                            padding: '8px 16px', borderRadius: '8px', border: '1px solid #CBD5E1', cursor: 'pointer', fontWeight: 700,
                            backgroundColor: mode === 'draw' ? '#FEE2E2' : 'white',
                            color: mode === 'draw' ? '#DC2626' : '#64748B',
                        }}
                    >
                        Trace Boundary
                    </button>
                    <button 
                        onClick={() => setMode('pin')}
                        style={{ 
                            padding: '8px 16px', borderRadius: '8px', border: '1px solid #CBD5E1', cursor: 'pointer', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '6px',
                            backgroundColor: mode === 'pin' ? '#DBEAFE' : 'white',
                            color: mode === 'pin' ? '#2563EB' : '#64748B',
                        }}
                    >
                        <Crosshair size={16} /> Drop Measure Pin
                    </button>
                </div>
            </div>

            {/* Editor Canvas Area */}
            <div ref={containerRef} style={{ width: '100%', height: '400px', backgroundColor: '#E2E8F0', position: 'relative', display: 'flex', justifyContent: 'center' }}>
                {!imageLoaded && (
                    <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#64748B', fontWeight: 700 }}>
                        Loading High-Resolution Image Data...
                    </div>
                )}
                
                <canvas 
                    ref={canvasRef}
                    width={800} // Locked scale parameter to preserve coordinate mapping
                    height={400}
                    style={{ 
                        opacity: imageLoaded ? 1 : 0, transition: 'opacity 0.3s',
                        cursor: mode === 'draw' ? 'crosshair' : 'cell',
                        touchAction: 'none' // Prevent pull-to-refresh on tablets
                    }}
                    onMouseDown={handlePointerDown}
                    onMouseMove={handlePointerMove}
                    onMouseUp={handlePointerUp}
                    onMouseLeave={handlePointerUp}
                    onTouchStart={handlePointerDown}
                    onTouchMove={handlePointerMove}
                    onTouchEnd={handlePointerUp}
                />
            </div>

            {/* Footer Metrics */}
             <div style={{ padding: '16px 24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ color: '#64748B', fontSize: '0.9rem', fontWeight: 600 }}>
                    Pins Dropped: {pins.length}
                </div>
                
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button onClick={handleClear} style={{ display: 'flex', alignItems: 'center', gap: '6px', background: 'none', border: 'none', color: '#EF4444', fontWeight: 700, cursor: 'pointer' }}>
                        <XCircle size={18} /> Clear Markups
                    </button>
                    <button style={{ backgroundColor: '#10B981', color: 'white', border: 'none', padding: '10px 24px', borderRadius: '8px', cursor: 'pointer', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <FileCheck size={18} /> Save to Chart
                    </button>
                </div>
             </div>

        </section>
    );
};

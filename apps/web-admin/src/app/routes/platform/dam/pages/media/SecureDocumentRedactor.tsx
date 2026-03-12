import React, { useState } from 'react';
import { FileText, Edit3, Shield, CheckCheck, Save, MousePointer2 } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface RedactionBox {
    id: string;
    x: number;
    y: number;
    width: number;
    height: number;
}

export const SecureDocumentRedactor: React.FC = () => {
    const [redactions, setRedactions] = useState<RedactionBox[]>([
        { id: 'r1', x: 120, y: 180, width: 140, height: 24 }, // Pre-existing redaction (e.g. SSN)
    ]);
    const [isDrawing, setIsDrawing] = useState(false);
    const [startX, setStartX] = useState(0);
    const [startY, setStartY] = useState(0);
    const [currentBox, setCurrentBox] = useState<Partial<RedactionBox> | null>(null);
    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const handleMouseDown = (e: React.MouseEvent<HTMLDivElement>) => {
        const rect = e.currentTarget.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        setStartX(x);
        setStartY(y);
        setIsDrawing(true);
        setCurrentBox({ x, y, width: 0, height: 0 });
    };

    const handleMouseMove = (e: React.MouseEvent<HTMLDivElement>) => {
        if (!isDrawing) return;
        const rect = e.currentTarget.getBoundingClientRect();
        const currentX = e.clientX - rect.left;
        const currentY = e.clientY - rect.top;

        setCurrentBox({
            x: Math.min(startX, currentX),
            y: Math.min(startY, currentY),
            width: Math.abs(currentX - startX),
            height: Math.abs(currentY - startY)
        });
    };

    const handleMouseUp = () => {
        if (isDrawing && currentBox && currentBox.width! > 10 && currentBox.height! > 10) {
            setRedactions(prev => [...prev, { ...currentBox, id: `r_${Date.now()}` } as RedactionBox]);
        }
        setIsDrawing(false);
        setCurrentBox(null);
    };

    const handleSave = async () => {
        setIsSaving(true);
        try {
            await apiClient.post('/platform/admin/dam/media/redact-document', { redactions });
            showToast("Redacted PDF saved permanently to vault. Original file overwritten.", "success");
            setRedactions([]);
        } catch (error) {
            showToast("Failed to lock document redactions", "error");
        } finally {
            setIsSaving(false);
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '10px', borderRadius: '8px' }}>
                        <Shield size={24} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Secure Document Redactor</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Scrub PHI and SSNs from documents before vaulting.</p>
                    </div>
                </div>

                <button 
                    onClick={handleSave}
                    disabled={isSaving || redactions.length === 0}
                    style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: (isSaving || redactions.length === 0) ? 'not-allowed' : 'pointer', opacity: (isSaving || redactions.length === 0) ? 0.6 : 1, display: 'flex', alignItems: 'center', gap: '8px' }}
                >
                    <Save size={16} /> {isSaving ? 'Processing...' : 'Apply Redactions & Lock'}
                </button>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Tools Sidebar */}
                <div style={{ width: '250px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <h4 style={{ margin: '0 0 12px 0', fontSize: '0.85rem', color: '#475569', textTransform: 'uppercase' }}>File Details</h4>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.9rem', color: '#0F172A', fontWeight: 700, marginBottom: '4px' }}>
                            <FileText size={16} color="#3B82F6" /> patient-intake-912.pdf
                        </div>
                        <div style={{ fontSize: '0.8rem', color: '#64748B' }}>Uploaded: 2 hours ago</div>
                        <div style={{ fontSize: '0.8rem', color: '#64748B' }}>Size: 1.2 MB</div>
                    </div>

                    <div style={{ padding: '12px', border: '1px solid #CBD5E1', borderRadius: '8px', display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 600, color: '#334155', cursor: 'pointer', backgroundColor: '#F1F5F9' }}>
                        <Edit3 size={18} /> Draw Blackout Box
                    </div>
                    <div style={{ padding: '12px', border: '1px solid #CBD5E1', borderRadius: '8px', display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 600, color: '#94A3B8', cursor: 'not-allowed' }}>
                        <MousePointer2 size={18} /> Select & Move
                    </div>

                    {redactions.length > 0 && (
                        <div style={{ marginTop: 'auto', backgroundColor: '#F0FDF4', padding: '12px', borderRadius: '8px', border: '1px solid #BBF7D0', color: '#16A34A', fontSize: '0.8rem', fontWeight: 600, display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <CheckCheck size={16} /> {redactions.length} Redactions Pending
                        </div>
                    )}
                </div>

                {/* Canvas Area ( PDF) */}
                <div style={{ flex: 1, backgroundColor: '#F1F5F9', border: '1px solid #E2E8F0', borderRadius: '8px', display: 'flex', justifyContent: 'center', padding: '32px', overflow: 'auto' }}>
                    <div 
                        onMouseDown={handleMouseDown}
                        onMouseMove={handleMouseMove}
                        onMouseUp={handleMouseUp}
                        onMouseLeave={handleMouseUp}
                        style={{ 
                            width: '595px', height: '842px', backgroundColor: 'white', boxShadow: '0 4px 6px rgba(0,0,0,0.1)', position: 'relative', cursor: 'crosshair',
                            backgroundImage: 'url("data:image/svg+xml,%3Csvg width=\'100\' height=\'100\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cpath d=\'M10 20h80M10 40h80M10 60h80M10 80h40\' stroke=\'%23E2E8F0\' stroke-width=\'2\' stroke-linecap=\'round\'/%3E%3C/svg%3E")',
                            backgroundSize: '100px 100px'
                        }}
                    >
                        <div style={{ position: 'absolute', top: '150px', left: '40px', right: '40px', color: '#64748B', fontFamily: 'serif', fontSize: '1.2rem', lineHeight: '2' }}>
                            <h2 style={{ color: '#0F172A', textAlign: 'center' }}>Patient Consent to Treat</h2>
                            <p>Patient Name: John Doe</p>
                            <p>Social Security Number: XXX-XX-XXXX</p>
                            <p>Date of Birth: 05/14/1982</p>
                            <p>I hereby consent to medical treatment provided by PrimeCare agency staff. I understand that my medical history will be recorded and stored securely...</p>
                        </div>
                        
                        {/* Render existing redactions */}
                        {redactions.map(r => (
                            <div key={r.id} style={{ position: 'absolute', left: r.x, top: r.y, width: r.width, height: r.height, backgroundColor: 'black' }} />
                        ))}

                        {/* Render active drawing box */}
                        {isDrawing && currentBox && (
                            <div style={{ position: 'absolute', left: currentBox.x, top: currentBox.y, width: currentBox.width, height: currentBox.height, backgroundColor: 'rgba(0,0,0,0.5)', border: '1px dashed black' }} />
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};

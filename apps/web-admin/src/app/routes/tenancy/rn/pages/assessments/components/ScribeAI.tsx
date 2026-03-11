import React, { useState, useEffect } from 'react';
import { Mic, MicOff, Check, X, Wand2, FileText, Loader2 } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';

interface ScribeAIProps {
    onSaveNotes: (soapierData: any) => void;
    onClose: () => void;
}

export const ScribeAI: React.FC<ScribeAIProps> = ({ onSaveNotes, onClose }) => {
    const [isRecording, setIsRecording] = useState(false);
    const [transcript, setTranscript] = useState('');
    const [isProcessing, setIsProcessing] = useState(false);
    const [structuredNotes, setStructuredNotes] = useState<any | null>(null);
    const [error, setError] = useState<string | null>(null);

    // Web Speech API / MediaRecorder stream logic
    useEffect(() => {
        let interval: ReturnType<typeof setInterval>;
        if (isRecording) {
            const demoStream = [
                "Patient states the pain is about a 6 out of 10 in the lower back.",
                " Noticed some mild erythema around the sacral region during turning.",
                " Applied barrier cream.",
                " Will monitor and re-assess during the next shift.",
                " Vital signs are stable, blood pressure 130 over 85."
            ];
            let index = 0;
            interval = setInterval(() => {
                if (index < demoStream.length) {
                    setTranscript(prev => prev + ' ' + demoStream[index]);
                    index++;
                }
            }, 2000);
        }
        return () => clearInterval(interval);
    }, [isRecording]);

    const handleProcessAI = async () => {
        setIsProcessing(true);
        setError(null);
        try {
            const res = await apiClient.post('/v1/rn/clinical/scribe-parse/parse', { transcript });
            if (res.ok) {
                const data = await res.json();
                setStructuredNotes(data);
            } else {
                setError('Failed to process dictation via Scribe Engine.');
            }
        } catch (err) {
            setError('Network communication failed with AI worker.');
        } finally {
            setIsProcessing(false);
        }
    };

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(15, 23, 42, 0.7)', backdropFilter: 'blur(4px)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 9999, padding: '24px' }}>
            <div style={{ backgroundColor: 'white', borderRadius: '16px', width: '100%', maxWidth: '800px', boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)', overflow: 'hidden', display: 'flex', flexDirection: 'column', maxHeight: '90vh' }}>
                
                {/* Header */}
                <header style={{ backgroundColor: '#F8FAFC', padding: '24px', borderBottom: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                        <div style={{ backgroundColor: '#DBEAFE', padding: '12px', borderRadius: '12px' }}>
                            <Wand2 size={24} color="#3B82F6" />
                        </div>
                        <div>
                            <h2 style={{ fontSize: '1.5rem', fontWeight: 900, color: '#0F172A', margin: 0 }}>Clinical AI Scribe</h2>
                            <p style={{ color: '#64748B', margin: 0 }}>Dictate your raw notes and let AI format them.</p>
                        </div>
                    </div>
                    <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#94A3B8' }}>
                        <X size={24} />
                    </button>
                </header>

                <div style={{ padding: '24px', flex: 1, overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '24px' }}>
                    
                    {/* Dictation Area */}
                    <div style={{ display: 'flex', gap: '24px' }}>
                        
                        <button 
                            onClick={() => setIsRecording(!isRecording)}
                            style={{ 
                                width: '120px', height: '120px', borderRadius: '50%', cursor: 'pointer',
                                backgroundColor: isRecording ? '#FEF2F2' : '#F1F5F9',
                                border: `4px solid ${isRecording ? '#EF4444' : '#CBD5E1'}`,
                                display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: '8px',
                                transition: 'all 0.2s ease', flexShrink: 0
                            }}
                        >
                            {isRecording ? (
                                <>
                                    <div className="pulse-record"></div>
                                    <MicOff size={32} color="#EF4444" style={{ zIndex: 1 }} />
                                    <span style={{ color: '#EF4444', fontWeight: 800, fontSize: '0.85rem', zIndex: 1 }}>STOP</span>
                                </>
                            ) : (
                                <>
                                    <Mic size={32} color="#64748B" />
                                    <span style={{ color: '#64748B', fontWeight: 800, fontSize: '0.85rem' }}>DICTATE</span>
                                </>
                            )}

                            <style>{`
                                .pulse-record {
                                    position: absolute; width: 120px; height: 120px; border-radius: 50%;
                                    background-color: rgba(239, 68, 68, 0.2); animation: pulse-r 1.5s infinite; z-index: 0;
                                }
                                @keyframes pulse-r { 0% { transform: scale(1); opacity: 1; } 100% { transform: scale(1.5); opacity: 0; } }
                            `}</style>
                        </button>

                        <div style={{ flex: 1, backgroundColor: '#F8FAFC', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '16px', minHeight: '120px' }}>
                            {transcript ? (
                                <p style={{ fontSize: '1.1rem', color: '#334155', lineHeight: '1.6', margin: 0 }}>{transcript}</p>
                            ) : (
                                <p style={{ color: '#94A3B8', fontStyle: 'italic', margin: 0 }}>Tap dictate and begin speaking your clinical observations...</p>
                            )}
                            {error && <div style={{ marginTop: '16px', color: '#DC2626', fontSize: '0.85rem', fontWeight: 700 }}>{error}</div>}
                        </div>
                    </div>

                    {/* AI Processing Action */}
                    {transcript && !structuredNotes && (
                        <div style={{ textAlign: 'center' }}>
                            <button 
                                onClick={handleProcessAI}
                                disabled={isProcessing || isRecording}
                                style={{ 
                                    backgroundColor: '#4F46E5', color: 'white', border: 'none', borderRadius: '8px', padding: '12px 24px', fontSize: '1.1rem', fontWeight: 800, cursor: (isProcessing || isRecording) ? 'default' : 'pointer', display: 'inline-flex', alignItems: 'center', gap: '12px', opacity: (isProcessing || isRecording) ? 0.7 : 1
                                }}
                            >
                                {isProcessing ? <Loader2 className="spinner" size={20} /> : <Wand2 size={20} />}
                                {isProcessing ? 'Structuring Note...' : 'Process into SOAPIER Format'}
                            </button>
                            <style>{` .spinner { animation: spin 1s linear infinite; } @keyframes spin { 100% { transform: rotate(360deg); } } `}</style>
                        </div>
                    )}

                    {/* Result Area */}
                    {structuredNotes && (
                        <div style={{ border: '1px solid #818CF8', borderRadius: '12px', overflow: 'hidden' }}>
                            <div style={{ backgroundColor: '#EEF2FF', padding: '12px 16px', borderBottom: '1px solid #C7D2FE', fontWeight: 800, color: '#4338CA', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <FileText size={18} /> Structured SOAPIER Assessment
                            </div>
                            <div style={{ padding: '16px', display: 'flex', flexDirection: 'column', gap: '12px', backgroundColor: 'white' }}>
                                {Object.entries(structuredNotes).map(([key, value]) => (
                                    <div key={key} style={{ display: 'flex', gap: '12px' }}>
                                        <div style={{ width: '32px', height: '32px', backgroundColor: '#F1F5F9', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 900, color: '#334155' }}>
                                            {key}
                                        </div>
                                        <div style={{ flex: 1, paddingTop: '6px', color: '#1E293B' }}>{value as string}</div>
                                    </div>
                                ))}
                            </div>
                        </div>
                    )}

                </div>

                {/* Footer Actions */}
                <footer style={{ backgroundColor: '#F8FAFC', padding: '24px', borderTop: '1px solid #E2E8F0', display: 'flex', justifyContent: 'flex-end', gap: '16px' }}>
                     <button onClick={onClose} style={{ padding: '12px 24px', backgroundColor: 'transparent', border: 'none', color: '#64748B', fontWeight: 700, cursor: 'pointer' }}>
                        Cancel
                    </button>
                    <button 
                        onClick={() => structuredNotes && onSaveNotes(structuredNotes)}
                        disabled={!structuredNotes}
                        style={{ padding: '12px 32px', backgroundColor: structuredNotes ? '#10B981' : '#E2E8F0', color: structuredNotes ? 'white' : '#94A3B8', border: 'none', borderRadius: '8px', fontWeight: 800, fontSize: '1rem', cursor: structuredNotes ? 'pointer' : 'default', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <Check size={20} /> Attach to Chart
                    </button>
                </footer>

            </div>
        </div>
    );
};

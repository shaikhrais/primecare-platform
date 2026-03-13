import React, { useState, useEffect, useRef } from 'react';
import { Mic, MicOff, Loader } from 'lucide-react';

interface VoiceDictationButtonProps {
    onResult: (text: string) => void;
    isListening: boolean;
    setIsListening: (val: boolean) => void;
}

export const VoiceDictationButton: React.FC<VoiceDictationButtonProps> = ({ onResult, isListening, setIsListening }) => {
    const [supported, setSupported] = useState(false);
    const recognitionRef = useRef<any>(null);

    useEffect(() => {
        // @ts-ignore
        const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        if (SpeechRecognition) {
            setSupported(true);
            const recognition = new SpeechRecognition();
            recognition.continuous = true;
            recognition.interimResults = true;

            recognition.onresult = (event: any) => {
                let finalTranscript = '';
                for (let i = event.resultIndex; i < event.results.length; ++i) {
                    if (event.results[i].isFinal) {
                        finalTranscript += event.results[i][0].transcript;
                    }
                }
                if (finalTranscript) {
                    onResult(finalTranscript.trim() + ' ');
                }
            };

            recognition.onerror = (event: any) => {
                console.error("Speech recognition error", event.error);
                setIsListening(false);
            };

            recognition.onend = () => {
                setIsListening(false);
            };

            recognitionRef.current = recognition;
        }
    }, [onResult, setIsListening]);

    const toggleListen = () => {
        if (!supported || !recognitionRef.current) return;

        if (isListening) {
            recognitionRef.current.stop();
        } else {
            recognitionRef.current.start();
            setIsListening(true);
        }
    };

    if (!supported) return null;

    return (
        <button data-cy="btn-shared.voice-dictation-button-0"
            onClick={toggleListen}
            style={{
                background: isListening ? '#EF4444' : 'transparent',
                border: isListening ? 'none' : '1px solid #E2E8F0',
                borderRadius: '8px',
                padding: '6px 12px',
                display: 'flex',
                alignItems: 'center',
                gap: '6px',
                cursor: 'pointer',
                color: isListening ? 'white' : '#64748B',
                fontWeight: 600,
                fontSize: '0.85rem',
                transition: 'all 0.2s',
                boxShadow: isListening ? '0 0 10px rgba(239, 68, 68, 0.5)' : 'none'
            }}
            title="Dictate Notes"
        >
            {isListening ? (
                <>
                    <Loader size={16} className="spin" style={{ animation: 'spin 1s linear infinite' }} />
                    Listening...
                </>
            ) : (
                <>
                    <Mic size={16} /> Dictate
                </>
            )}
            <style>{`
                @keyframes spin {
                    from { transform: rotate(0deg); }
                    to { transform: rotate(360deg); }
                }
            `}</style>
        </button>
    );
};

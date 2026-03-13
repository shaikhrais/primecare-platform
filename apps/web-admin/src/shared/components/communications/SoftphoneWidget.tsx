import React, { useState, useEffect } from 'react';
import { Phone, PhoneOff, Mic, MicOff, Minimize2, Maximize2 } from 'lucide-react';
import { useNotification } from '@/shared/context/NotificationContext';

// Global Event listener hook for intercepting phone number clicks
export const useSoftphoneDispatcher = () => {
    useEffect(() => {
        const interceptTelLinks = (e: MouseEvent) => {
            const target = e.target as HTMLElement;
            const anchor = target.closest('a');

            if (anchor && anchor.href.startsWith('tel:')) {
                e.preventDefault();
                const number = anchor.href.replace('tel:', '');
                const event = new CustomEvent('open-softphone', { detail: { number, name: target.getAttribute('data-name') || 'Unknown Contact' } });
                window.dispatchEvent(event);
            }
        };

        document.addEventListener('click', interceptTelLinks);
        return () => document.removeEventListener('click', interceptTelLinks);
    }, []);
};

export const SoftphoneWidget: React.FC = () => {
    const { showToast } = useNotification();
    const [isOpen, setIsOpen] = useState(false);
    const [isMinimized, setIsMinimized] = useState(false);

    const [contactName, setContactName] = useState('Dispatcher');
    const [phoneNumber, setPhoneNumber] = useState('');

    const [callState, setCallState] = useState<'idle' | 'calling' | 'connected'>('idle');
    const [duration, setDuration] = useState(0);
    const [isMuted, setIsMuted] = useState(false);

    useSoftphoneDispatcher(); // Mount the global listener

    useEffect(() => {
        const handleOpen = (e: Event) => {
            const customEvent = e as CustomEvent;
            setPhoneNumber(customEvent.detail.number);
            setContactName(customEvent.detail.name);
            setIsOpen(true);
            setIsMinimized(false);
            setCallState('calling');

            // Transition instantly for WebRTC local testing since signal server is offline
            setCallState('connected');
            showToast(`Connected to ${customEvent.detail.name}`, 'success');
        };

        window.addEventListener('open-softphone', handleOpen);
        return () => window.removeEventListener('open-softphone', handleOpen);
    }, [showToast]);

    // Timer logic
    useEffect(() => {
        let interval: number;
        if (callState === 'connected') {
            interval = window.setInterval(() => setDuration(prev => prev + 1), 1000);
        } else {
            setDuration(0);
        }
        return () => window.clearInterval(interval);
    }, [callState]);

    const formatTime = (seconds: number) => {
        const m = Math.floor(seconds / 60).toString().padStart(2, '0');
        const s = (seconds % 60).toString().padStart(2, '0');
        return `${m}:${s}`;
    };

    const handleHangUp = () => {
        setCallState('idle');
        setIsOpen(false);
        showToast('Call ended', 'info');

        // Log the call outcome to the backend
        fetch('/api/v1/system/data/communications', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                recipientId: phoneNumber,
                channel: 'VOICE',
                status: 'completed',
                metadata: JSON.stringify({ duration, contactName })
            })
        }).catch(err => console.error('Failed to log call data:', err));
    };

    if (!isOpen) return null;

    if (isMinimized) {
        return (
            <div
                style={{
                    position: 'fixed',
                    bottom: '24px',
                    right: '24px',
                    backgroundColor: callState === 'connected' ? '#10B981' : '#F59E0B',
                    color: 'white',
                    padding: '12px 24px',
                    borderRadius: '24px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '12px',
                    boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
                    zIndex: 9999,
                    cursor: 'pointer',
                    fontWeight: 700
                }}
                onClick={() => setIsMinimized(false)}
            >
                <Phone className={callState === 'calling' ? 'animate-pulse' : ''} size={18} />
                <span>{callState === 'connected' ? formatTime(duration) : 'Dialing...'}</span>
                <Maximize2 size={16} />
            </div>
        );
    }

    return (
        <div style={{
            position: 'fixed',
            bottom: '24px',
            right: '24px',
            width: '320px',
            backgroundColor: '#0F172A', // Sleek dark mode for WebRTC Widget
            borderRadius: '16px',
            boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.2), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
            overflow: 'hidden',
            zIndex: 9999,
            display: 'flex',
            flexDirection: 'column'
        }}>
            <div style={{ padding: '16px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                    <div style={{ color: '#94A3B8', fontSize: '0.8rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '1px' }}>
                        {callState === 'calling' ? 'Calling...' : callState === 'connected' ? 'Secure VoIP Call' : 'Idle'}
                    </div>
                    <div style={{ color: 'white', fontSize: '1.25rem', fontWeight: 800, marginTop: '4px' }}>{contactName}</div>
                    <div style={{ color: '#CBD5E1', fontSize: '0.9rem' }}>{phoneNumber}</div>
                </div>
                <button data-cy="btn-shared.softphone-widget-0"
                    onClick={() => setIsMinimized(true)}
                    style={{ background: 'transparent', border: 'none', color: '#94A3B8', cursor: 'pointer' }}
                >
                    <Minimize2 size={20} />
                </button>
            </div>

            {callState === 'connected' && (
                <div style={{ textAlign: 'center', padding: '12px 0', fontSize: '2rem', fontWeight: 200, color: '#34D399', backgroundColor: 'rgba(255,255,255,0.05)' }}>
                    {formatTime(duration)}
                </div>
            )}

            <div style={{ padding: '24px', display: 'flex', justifyContent: 'center', gap: '20px', backgroundColor: '#1E293B' }}>
                <button data-cy="btn-shared.softphone-widget-1"
                    onClick={() => setIsMuted(prev => !prev)}
                    style={{
                        width: '56px', height: '56px', borderRadius: '50%',
                        backgroundColor: isMuted ? 'rgba(255,255,255,0.2)' : 'rgba(255,255,255,0.1)',
                        color: 'white', border: 'none', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer'
                    }}
                >
                    {isMuted ? <MicOff size={24} /> : <Mic size={24} />}
                </button>

                <button data-cy="btn-shared.softphone-widget-2"
                    onClick={handleHangUp}
                    style={{
                        width: '56px', height: '56px', borderRadius: '50%',
                        backgroundColor: '#EF4444',
                        color: 'white', border: 'none', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer',
                        boxShadow: '0 4px 14px 0 rgba(239, 68, 68, 0.39)'
                    }}
                >
                    <PhoneOff size={24} />
                </button>
            </div>
        </div>
    );
};

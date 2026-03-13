import React, { useState } from 'react';
import { Send, X, Phone } from 'lucide-react';

interface DirectDispatchChatProps {
    isOpen: boolean;
    onClose: () => void;
}

export const DirectDispatchChat: React.FC<DirectDispatchChatProps> = ({ isOpen, onClose }) => {
    const [messages, setMessages] = useState([
        { id: 1, text: "Hi, I'm Sarah, your active dispatcher today. How can I help?", sender: 'dispatcher', time: '08:00 AM' }
    ]);
    const [inputValue, setInputValue] = useState('');

    if (!isOpen) return null;

    const handleSend = () => {
        if (!inputValue.trim()) return;
        setMessages(prev => [...prev, {
            id: Date.now(),
            text: inputValue,
            sender: 'psw',
            time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        }]);
        setInputValue('');

 // dispatcher reply
        setTimeout(() => {
            setMessages(prev => [...prev, {
                id: Date.now() + 1,
                text: "Copy that. Updating the client's file now.",
                sender: 'dispatcher',
                time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
            }]);
        }, 1500);
    };

    return (
        <div style={{
            position: 'fixed',
            bottom: '80px', // above bottom nav
            right: '20px',
            width: '320px',
            height: '450px',
            backgroundColor: '#ffffff',
            borderRadius: '16px',
            boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.2)',
            display: 'flex',
            flexDirection: 'column',
            zIndex: 9998,
            overflow: 'hidden',
            border: '1px solid #E2E8F0'
        }}>
            {/* Header */}
            <div style={{
                backgroundColor: '#1E293B',
                color: 'white',
                padding: '16px',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center'
            }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <div style={{ width: '10px', height: '10px', backgroundColor: '#10B981', borderRadius: '50%' }} />
                    <h3 data-cy="h3-psw.direct-dispatch-chat-0" style={{ margin: 0, fontSize: '1rem', fontWeight: 600 }}>Active Dispatch</h3>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="btn-psw.direct-dispatch-chat-0" style={{ background: 'none', border: 'none', color: 'white', cursor: 'pointer', padding: 0 }}><Phone size={18} /></button>
                    <button data-cy="btn-psw.direct-dispatch-chat-1" onClick={onClose} style={{ background: 'none', border: 'none', color: 'white', cursor: 'pointer', padding: 0 }}><X size={18} /></button>
                </div>
            </div>

            {/* Message Area */}
            <div style={{ flex: 1, padding: '16px', overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '16px', backgroundColor: '#F8FAFC' }}>
                {messages.map(msg => (
                    <div key={msg.id} style={{
                        alignSelf: msg.sender === 'psw' ? 'flex-end' : 'flex-start',
                        maxWidth: '80%'
                    }}>
                        <div style={{
                            backgroundColor: msg.sender === 'psw' ? '#3B82F6' : '#E2E8F0',
                            color: msg.sender === 'psw' ? 'white' : '#0F172A',
                            padding: '10px 14px',
                            borderRadius: '12px',
                            borderBottomRightRadius: msg.sender === 'psw' ? '2px' : '12px',
                            borderBottomLeftRadius: msg.sender === 'psw' ? '12px' : '2px',
                            fontSize: '0.9rem',
                            lineHeight: 1.4
                        }}>
                            {msg.text}
                        </div>
                        <div style={{ fontSize: '0.65rem', color: '#94A3B8', marginTop: '4px', textAlign: msg.sender === 'psw' ? 'right' : 'left' }}>
                            {msg.time}
                        </div>
                    </div>
                ))}
            </div>

            {/* Input Area */}
            <div style={{ padding: '12px', backgroundColor: 'white', borderTop: '1px solid #E2E8F0', display: 'flex', gap: '8px' }}>
                <input data-cy="input-psw.direct-dispatch-chat-0"
                    type="text"
                    value={inputValue}
                    onChange={e => setInputValue(e.target.value)}
                    onKeyPress={e => e.key === 'Enter' && handleSend()}
                    placeholder="Message Dispatch..."
                    style={{
                        flex: 1,
                        padding: '10px 14px',
                        border: '1px solid #CBD5E1',
                        borderRadius: '20px',
                        outline: 'none',
                        fontSize: '0.9rem'
                    }}
                />
                <button data-cy="btn-psw.direct-dispatch-chat-2"
                    onClick={handleSend}
                    style={{
                        backgroundColor: '#3B82F6',
                        color: 'white',
                        border: 'none',
                        borderRadius: '50%',
                        width: '40px',
                        height: '40px',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        cursor: 'pointer'
                    }}
                >
                    <Send size={18} style={{ marginLeft: '-2px' }} />
                </button>
            </div>
        </div>
    );
};

import React, { useState } from 'react';
import { Send, Phone } from 'lucide-react';

import { apiClient } from '@/shared/utils/apiClient';

interface ChatMessage {
    id: string;
    text: string;
    sender: 'family' | 'coordinator';
    timestamp: string;
}

export const iMessageThread: React.FC = () => {
    // Starting with an empty thread or a welcome message
    const [messages, setMessages] = useState<ChatMessage[]>([
        { id: '0', text: 'Hello! I am Jessica, your Care Coordinator. How can I help you regarding John today?', sender: 'coordinator', timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) }
    ]);
    const [inputText, setInputText] = useState('');

    const handleSend = async (e: React.FormEvent) => {
        e.preventDefault();
        const text = inputText;
        if (!text.trim()) return;

        const newMsg: ChatMessage = {
            id: Date.now().toString(),
            text,
            sender: 'family',
            timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        };

        // Unshift since array is reversed
        setMessages(prev => [newMsg, ...prev]);
        setInputText('');

        try {
            // Post to backend Audit Log
            await apiClient.post('/v1/client/family/message', {
                clientId: 'demo-client-1',
                subject: 'Family Portal Message',
                body: text
            });

 // Coordinator Auto-reply for Demo UX (since no real-time sockets yet)
            setTimeout(() => {
                const autoReply: ChatMessage = {
                    id: Date.now().toString(),
                    text: "I've received your message and logged it to the patient file. I'll get back to you shortly!",
                    sender: 'coordinator',
                    timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
                };
                setMessages(prev => [autoReply, ...prev]);
            }, 2500);

        } catch (error) {
            console.error('Failed to send message:', error);
        }
    };

    return (
        <section style={{ backgroundColor: 'white', borderRadius: '24px', border: '1px solid #E2E8F0', overflow: 'hidden', display: 'flex', flexDirection: 'column', height: '600px', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)' }}>
            
            {/* Header */}
            <header style={{ backgroundColor: '#F8FAFC', padding: '16px 24px', borderBottom: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ width: '48px', height: '48px', borderRadius: '50%', backgroundColor: '#E2E8F0', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.25rem' }}>👩‍💼</div>
                    <div>
                        <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.1rem' }}>Jessica M.</div>
                        <div style={{ fontSize: '0.85rem', color: '#10B981', fontWeight: 700 }}>Online (Care Coordinator)</div>
                    </div>
                </div>
                <button data-cy="btn-i-message-thread-0" style={{ backgroundColor: '#DBEAFE', color: '#1D4ED8', border: 'none', padding: '10px', borderRadius: '50%', cursor: 'pointer' }}>
                    <Phone size={20} />
                </button>
            </header>

            {/* Chat Area - Utilizing column-reverse to auto-anchor to bottom without JS scroll math */}
            <div style={{ flex: 1, padding: '24px', overflowY: 'auto', display: 'flex', flexDirection: 'column-reverse', gap: '16px', backgroundColor: '#FFFFFF' }}>
                {messages.map((msg) => {
                    const isMe = msg.sender === 'family';
                    return (
                        <div key={msg.id} style={{ display: 'flex', flexDirection: 'column', alignItems: isMe ? 'flex-end' : 'flex-start' }}>
                            <div style={{
                                maxWidth: '75%',
                                padding: '12px 18px',
                                borderRadius: '20px',
                                backgroundColor: isMe ? '#3B82F6' : '#F1F5F9',
                                color: isMe ? 'white' : '#0F172A',
                                borderBottomRightRadius: isMe ? '4px' : '20px',
                                borderBottomLeftRadius: isMe ? '20px' : '4px',
                                fontSize: '1.05rem',
                                lineHeight: '1.4'
                            }}>
                                {msg.text}
                            </div>
                            <div style={{ fontSize: '0.75rem', color: '#94A3B8', marginTop: '4px', padding: '0 8px' }}>
                                {msg.timestamp}
                            </div>
                        </div>
                    );
                })}
            </div>

            {/* Input Form */}
            <form data-cy="form-i-message-thread" onSubmit={handleSend} style={{ display: 'flex', gap: '12px', padding: '16px', borderTop: '1px solid #E2E8F0', backgroundColor: '#F8FAFC' }}>
                <input data-cy="input-i-message-thread-0" 
                    type="text" 
                    value={inputText}
                    onChange={e => setInputText(e.target.value)}
                    placeholder="iMessage Coordinator..."
                    style={{ flex: 1, borderRadius: '24px', border: '1px solid #CBD5E1', padding: '12px 24px', fontSize: '1rem', outline: 'none' }}
                />
                <button data-cy="btn-i-message-thread-1" type="submit" disabled={!inputText.trim()} style={{ backgroundColor: inputText.trim() ? '#3B82F6' : '#94A3B8', color: 'white', border: 'none', borderRadius: '50%', width: '48px', height: '48px', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: inputText.trim() ? 'pointer' : 'default', transition: 'background-color 0.2s' }}>
                    <Send size={20} style={{ marginLeft: '4px' }} />
                </button>
            </form>

        </section>
    );
};

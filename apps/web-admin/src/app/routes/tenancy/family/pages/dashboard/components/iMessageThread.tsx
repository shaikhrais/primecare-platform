import React, { useState } from 'react';
import { Send, Phone } from 'lucide-react';

interface ChatMessage {
    id: string;
    text: string;
    sender: 'family' | 'coordinator';
    timestamp: string;
}

const MOCK_CHAT: ChatMessage[] = [
    { id: '1', text: 'Hi! I noticed Sarah was a bit late today, is everything okay?', sender: 'family', timestamp: '10:45 AM' },
    { id: '2', text: 'Hello! Yes, Sarah got caught in some traffic on the 401, but she arrived safely at 10:55 AM.', sender: 'coordinator', timestamp: '10:48 AM' },
    { id: '3', text: 'Great, thanks for letting me know.', sender: 'family', timestamp: '10:50 AM' },
    { id: '4', text: 'No problem at all! Let us know if you need anything else.', sender: 'coordinator', timestamp: '10:52 AM' },
    { id: '5', text: 'Will do. Have a good weekend.', sender: 'family', timestamp: '10:55 AM' },
];

export const iMessageThread: React.FC = () => {
    const [messages, setMessages] = useState<ChatMessage[]>(MOCK_CHAT.reverse()); // Data needs to be reversed for column-reverse layout
    const [inputText, setInputText] = useState('');

    const handleSend = (e: React.FormEvent) => {
        e.preventDefault();
        if (!inputText.trim()) return;

        const newMsg: ChatMessage = {
            id: Date.now().toString(),
            text: inputText,
            sender: 'family',
            timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        };

        // Unshift since array is reversed
        setMessages([newMsg, ...messages]);
        setInputText('');
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
                <button style={{ backgroundColor: '#DBEAFE', color: '#1D4ED8', border: 'none', padding: '10px', borderRadius: '50%', cursor: 'pointer' }}>
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
            <form onSubmit={handleSend} style={{ display: 'flex', gap: '12px', padding: '16px', borderTop: '1px solid #E2E8F0', backgroundColor: '#F8FAFC' }}>
                <input 
                    type="text" 
                    value={inputText}
                    onChange={e => setInputText(e.target.value)}
                    placeholder="iMessage Coordinator..."
                    style={{ flex: 1, borderRadius: '24px', border: '1px solid #CBD5E1', padding: '12px 24px', fontSize: '1rem', outline: 'none' }}
                />
                <button type="submit" disabled={!inputText.trim()} style={{ backgroundColor: inputText.trim() ? '#3B82F6' : '#94A3B8', color: 'white', border: 'none', borderRadius: '50%', width: '48px', height: '48px', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: inputText.trim() ? 'pointer' : 'default', transition: 'background-color 0.2s' }}>
                    <Send size={20} style={{ marginLeft: '4px' }} />
                </button>
            </form>

        </section>
    );
};

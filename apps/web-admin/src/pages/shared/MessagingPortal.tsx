import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { webChatService } from '../../services/WebChatService';

interface ChatMessage {
    id: number | string;
    sender: string;
    text: string;
    time: string;
    type: 'sent' | 'received';
}

export default function MessagingPortal() {
    const { id: threadId } = useParams<{ id: string }>();
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const [messages, setMessages] = useState<ChatMessage[]>([]);
    const [newMessage, setNewMessage] = useState('');
    const token = localStorage.getItem('token');
    const API_URL = import.meta.env.VITE_API_URL;

    useEffect(() => {
        // If staff viewing a specific thread, fetch historical messages
        if (threadId && (user.role === 'staff' || user.role === 'admin')) {
            fetch(`${API_URL}/v1/staff/tickets/${threadId}/messages`, {
                headers: { 'Authorization': `Bearer ${token}` }
            })
                .then(res => res.json())
                .then(data => {
                    const formatted = data.map((m: any) => ({
                        id: m.id,
                        sender: m.senderUserId === user.id ? 'Me' : 'Customer',
                        text: m.bodyText,
                        time: new Date(m.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
                        type: m.senderUserId === user.id ? 'sent' : 'received'
                    }));
                    setMessages(formatted);
                });
        }

        if (user.id || user.email) {
            const id = user.id || user.email;
            webChatService.connect(id);
            const unsubscribe = webChatService.addListener((msg: { sender?: string; userId: string; message: string }) => {
                // If viewing a thread, only show messages for that thread (simple logic for now)
                setMessages((prev: ChatMessage[]) => [...prev, {
                    id: Date.now(),
                    sender: msg.sender || (msg.userId === id ? 'Me' : 'Support'),
                    text: msg.message,
                    time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
                    type: msg.userId === id ? 'sent' : 'received'
                }]);
            });
            return () => {
                unsubscribe();
                webChatService.disconnect();
            };
        }
    }, [user.id, user.email, threadId, token]);

    const handleSend = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!newMessage.trim()) return;

        if (threadId && (user.role === 'staff' || user.role === 'admin')) {
            // Send via API for staff replying to specific thread
            const response = await fetch(`${API_URL}/v1/staff/tickets/${threadId}/reply`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({ bodyText: newMessage }),
            });
            if (response.ok) {
                setNewMessage('');
                // Local echo
                setMessages((prev: ChatMessage[]) => [...prev, {
                    id: Date.now(),
                    sender: 'Me',
                    text: newMessage,
                    time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
                    type: 'sent'
                }]);
            }
        } else {
            webChatService.sendMessage(newMessage);
            setNewMessage('');
        }
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', height: '600px', display: 'flex', flexDirection: 'column', backgroundColor: 'white', borderRadius: '1rem', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
            {/* Header */}
            <div style={{ padding: '1.25rem', backgroundColor: 'var(--pc-primary-dark)', color: 'white', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                <div style={{ width: '40px', height: '40px', borderRadius: '50%', backgroundColor: 'rgba(255,255,255,0.2)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 'bold' }}>P</div>
                <div>
                    <h3 style={{ margin: 0, fontSize: '1.1rem' }}>PrimeCare Support</h3>
                    <span style={{ fontSize: '0.75rem', opacity: 0.8 }}>Online • Usually responds in minutes</span>
                </div>
            </div>

            {/* Message Area */}
            <div data-cy="list-messages" style={{ flex: 1, padding: '1.5rem', overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '1rem', backgroundColor: '#f9fafb' }}>
                {messages.map(msg => (
                    <div key={msg.id} style={{ alignSelf: msg.type === 'sent' ? 'flex-end' : 'flex-start', maxWidth: '70%', display: 'flex', flexDirection: 'column', gap: '0.25rem' }}>
                        <div style={{
                            padding: '0.75rem 1rem',
                            borderRadius: '1rem',
                            fontSize: '0.9rem',
                            backgroundColor: msg.type === 'sent' ? 'var(--pc-primary-dark)' : '#e5e7eb',
                            color: msg.type === 'sent' ? 'white' : '#1f2937',
                            borderBottomRightRadius: msg.type === 'sent' ? '0' : '1rem',
                            borderBottomLeftRadius: msg.type === 'received' ? '0' : '1rem',
                        }}>
                            {msg.text}
                        </div>
                        <span style={{ fontSize: '0.7rem', color: '#6b7280', textAlign: msg.type === 'sent' ? 'right' : 'left' }}>
                            {msg.sender} • {msg.time}
                        </span>
                    </div>
                ))}
            </div>

            {/* Input */}
            <form onSubmit={handleSend} style={{ padding: '1.25rem', borderTop: '1px solid #e5e7eb', display: 'flex', gap: '0.75rem' }}>
                <input
                    data-cy="inp-message"
                    type="text"
                    value={newMessage}
                    onChange={(e) => setNewMessage(e.target.value)}
                    placeholder="Type your message..."
                    style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', outline: 'none' }}
                />
                <button
                    data-cy="btn-send-message"
                    type="submit"
                    style={{ padding: '0.75rem 1.5rem', backgroundColor: 'var(--pc-primary-dark)', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    Send
                </button>
            </form>
        </div>
    );
}

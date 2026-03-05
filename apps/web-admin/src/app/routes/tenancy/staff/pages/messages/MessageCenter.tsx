import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import './MessageCenter.css';

const { ContentRegistry } = AdminRegistry;

interface Message {
    id: string;
    sender: string;
    role: 'PSW' | 'RN' | 'Coordinator' | 'Manager' | 'Family/Client';
    lastMessage: string;
    time: string;
    unread: boolean;
    status: 'online' | 'offline' | 'away';
}

export default function MessageCenter() {
    const { t } = useTranslation();
    const [selectedId, setSelectedId] = useState('1');
    const [searchTerm, setSearchTerm] = useState('');

    const chatList: Message[] = [
        { id: '1', sender: 'Elena Rodriguez', role: 'PSW', lastMessage: 'I will be 10 mins late for the Smith visit.', time: '14:22', unread: true, status: 'online' },
        { id: '2', sender: 'Alice Freeman', role: 'Family/Client', lastMessage: 'Can we change Thursday to 3 PM?', time: '11:05', unread: false, status: 'away' },
        { id: '3', sender: 'Jordan Vale', role: 'PSW', lastMessage: 'The new clinical notes are uploaded.', time: 'Yesterday', unread: false, status: 'offline' },
        { id: '4', sender: 'Michael Chen', role: 'RN', lastMessage: 'Incident report #842 requires review.', time: 'Yesterday', unread: true, status: 'online' },
    ];

    const selectedChat = chatList.find(c => c.id === selectedId) || chatList[0];

    return (
        <div className="message-center">
            <aside className="chat-sidebar">
                <header className="chat-sidebar-header">
                    <h2>{t(ContentRegistry.STAFF_PORTAL.MESSAGES.TITLE || 'Messages')}</h2>
                    <div className="chat-search-container">
                        <span className="absolute left-4 top-1/2 -translate-y-1/2 opacity-40">🔍</span>
                        <input
                            type="text"
                            placeholder={t(ContentRegistry.STAFF_PORTAL.MESSAGES.SEARCH_PLACEHOLDER || 'Search communications...')}
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    </div>
                </header>

                <div className="chat-list">
                    {chatList.filter(c => c.sender.toLowerCase().includes(searchTerm.toLowerCase())).map(chat => (
                        <div
                            key={chat.id}
                            onClick={() => setSelectedId(chat.id)}
                            className={`chat-item ${selectedId === chat.id ? 'active' : ''}`}
                        >
                            <div className="chat-item-header">
                                <span className="chat-role-badge">{chat.role}</span>
                                <span className="chat-time">{chat.time}</span>
                            </div>
                            <div className="chat-sender-name">{chat.sender}</div>
                            <div className="chat-preview">{chat.lastMessage}</div>
                            {chat.unread && selectedId !== chat.id && (
                                <div className="unread-indicator" />
                            )}
                        </div>
                    ))}
                </div>
            </aside>

            <main className="chat-main">
                <header className="chat-main-header">
                    <div className="chat-info">
                        <div className="chat-avatar">
                            {selectedChat.sender[0]}
                        </div>
                        <div>
                            <div className="chat-sender-name">{selectedChat.sender}</div>
                            <div className="status-text">{selectedChat.status}</div>
                        </div>
                    </div>
                    <div className="chat-actions">
                        <button className="chat-action-btn">📞</button>
                        <button className="chat-action-btn">📁</button>
                        <button className="chat-action-btn">⋮</button>
                    </div>
                </header>

                <div className="messages-viewport">
                    <div className="flex flex-col items-center py-10 opacity-30 select-none border-b border-dashed mb-8">
                        <div className="text-4xl mb-2">🛡️</div>
                        <p className="text-[10px] font-black uppercase tracking-[0.3em]">End-to-End Encrypted Channel</p>
                    </div>

                    <div className="message-bubble message-received">
                        Hi, I'm checking on the status of the upcoming visit for morning care.
                    </div>

                    <div className="message-bubble message-sent">
                        {selectedChat.lastMessage}
                    </div>

                    <div className="message-bubble message-received">
                        Understood. I've updated the dispatch board to reflect the delay.
                    </div>
                </div>

                <footer className="chat-footer">
                    <div className="chat-input-wrapper">
                        <button className="chat-action-btn" style={{ border: 'none', background: 'transparent' }}>📎</button>
                        <input
                            type="text"
                            placeholder={t(ContentRegistry.STAFF_PORTAL.MESSAGES.INPUT_PLACEHOLDER || 'Message encrypted core...')}
                        />
                        <button className="btn-modern btn-modern-primary" style={{ padding: '0.75rem 1.5rem', borderRadius: '1.5rem' }}>
                            {t(ContentRegistry.STAFF_PORTAL.MESSAGES.SEND_BTN || 'Send')}
                        </button>
                    </div>
                </footer>
            </main>
        </div>
    );
}

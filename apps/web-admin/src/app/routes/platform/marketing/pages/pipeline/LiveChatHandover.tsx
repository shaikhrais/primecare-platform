import React, { useState } from 'react';
import { Bot, UserSearch, MessageSquare, MonitorPlay, Zap, X } from 'lucide-react';

interface ChatSession {
    id: string;
    visitorIp: string;
    priorityScore: number;
    minutesActive: number;
    status: 'BOT_HANDLING' | 'HUMAN_INTERVENED';
    lastMessage: string;
}

export const LiveChatHandover: React.FC = () => {
    const [sessions, setSessions] = useState<ChatSession[]>([
        { id: 'chat_88', visitorIp: '68.14.xx.xx', priorityScore: 92, minutesActive: 4, status: 'BOT_HANDLING', lastMessage: 'Visitor: "Do you offer hoyer lift support for bedbound seniors?"' },
        { id: 'chat_89', visitorIp: '104.28.xx.xx', priorityScore: 25, minutesActive: 1, status: 'BOT_HANDLING', lastMessage: 'Visitor: "What are your hourly rates?"' },
        { id: 'chat_90', visitorIp: '192.168.xx.xx', priorityScore: 85, minutesActive: 12, status: 'HUMAN_INTERVENED', lastMessage: 'Agent Sarah: "I can absolutely help coordinate that discharge. Let me pull up the intake form."' }
    ]);

    const [activeChat, setActiveChat] = useState<string | null>(null);

    const handleIntervene = (id: string) => {
        setSessions(sessions.map(s => 
            s.id === id ? { ...s, status: 'HUMAN_INTERVENED' } : s
        ));
        setActiveChat(id);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '12px', borderRadius: '8px' }}>
                        <UserSearch size={28} color="#16A34A" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Live Chat Overwatch</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Monitor AI bot conversations and manually intervene on high-value leads.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Active Sessions List */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    <h4 style={{ margin: '0 0 8px 0', fontSize: '0.85rem', color: '#64748B', textTransform: 'uppercase', letterSpacing: '1px' }}>Active Web Sessions</h4>
                    
                    {sessions.map(session => (
                        <div 
                            key={session.id} 
                            style={{ 
                                padding: '16px', 
                                border: '1px solid',
                                borderColor: activeChat === session.id ? '#6366F1' : '#E2E8F0',
                                backgroundColor: activeChat === session.id ? '#EEF2FF' : 'white',
                                borderRadius: '8px',
                                display: 'flex',
                                justifyContent: 'space-between',
                                alignItems: 'center',
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                            onClick={() => setActiveChat(session.id)}
                        >
                            <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                                <div style={{ 
                                    backgroundColor: session.status === 'BOT_HANDLING' ? '#F1F5F9' : '#DCFCE7', 
                                    padding: '10px', 
                                    borderRadius: '50%' 
                                }}>
                                    {session.status === 'BOT_HANDLING' ? <Bot size={20} color="#64748B" /> : <MessageSquare size={20} color="#16A34A" />}
                                </div>
                                <div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 700, color: '#0F172A' }}>
                                        Visitor {session.visitorIp}
                                        {session.priorityScore > 80 && (
                                            <span style={{ backgroundColor: '#FEF2F2', color: '#DC2626', padding: '2px 6px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 800 }}>🔥 HOT LEAD</span>
                                        )}
                                    </div>
                                    <div style={{ fontSize: '0.85rem', color: '#64748B', marginTop: '4px' }}>
                                        {session.minutesActive}m elapsed • Algorithmic Score: {session.priorityScore}/100
                                    </div>
                                </div>
                            </div>
                            
                            {session.status === 'BOT_HANDLING' && session.priorityScore > 80 && (
                                <button 
                                    onClick={(e) => { e.stopPropagation(); handleIntervene(session.id); }}
                                    style={{ backgroundColor: '#DC2626', color: 'white', border: 'none', borderRadius: '6px', padding: '8px 16px', fontWeight: 800, fontSize: '0.85rem', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}
                                >
                                    <Zap size={14} /> HIJACK CHAT
                                </button>
                            )}
                        </div>
                    ))}
                </div>

                {/* Live Preview Pane */}
                <div style={{ width: '400px', backgroundColor: '#F8FAFC', border: '1px solid #E2E8F0', borderRadius: '12px', display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
                    {activeChat ? (
                        <>
                            <div style={{ backgroundColor: '#1E293B', padding: '16px', color: 'white', display: 'flex', alignItems: 'center', gap: '12px' }}>
                                <MonitorPlay size={20} color="#94A3B8" />
                                <div style={{ fontWeight: 700 }}>Live View: {sessions.find(s => s.id === activeChat)?.visitorIp}</div>
                            </div>
                            <div style={{ padding: '24px', flex: 1, display: 'flex', flexDirection: 'column', gap: '16px' }}>
                                {/* chat bubbles */}
                                <div style={{ alignSelf: 'flex-start', backgroundColor: 'white', border: '1px solid #E2E8F0', padding: '12px 16px', borderRadius: '12px 12px 12px 0', fontSize: '0.9rem', color: '#334155', maxWidth: '85%' }}>
                                    {sessions.find(s => s.id === activeChat)?.lastMessage}
                                </div>
                                <div style={{ alignSelf: 'flex-end', backgroundColor: '#6366F1', color: 'white', padding: '12px 16px', borderRadius: '12px 12px 0 12px', fontSize: '0.9rem', maxWidth: '85%' }}>
                                    {sessions.find(s => s.id === activeChat)?.status === 'BOT_HANDLING' 
                                        ? "AI: I can certainly help with that out. What is your preferred schedule?"
                                        : "AGENT: Hi there, I'm taking over this chat from our automated assistant. I'd love to help answer your questions directly."}
                                </div>
                            </div>
                            {sessions.find(s => s.id === activeChat)?.status === 'HUMAN_INTERVENED' && (
                                <div style={{ padding: '16px', borderTop: '1px solid #E2E8F0', backgroundColor: 'white' }}>
                                    <input type="text" placeholder="Type your reply to the visitor..." style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none', boxSizing: 'border-box' }}/>
                                </div>
                            )}
                        </>
                    ) : (
                        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', padding: '32px', textAlign: 'center' }}>
                            <Bot size={48} style={{ marginBottom: '16px', opacity: 0.5 }} />
                            <div style={{ fontWeight: 600 }}>Select a session to eavesdrop.</div>
                            <div style={{ fontSize: '0.85rem', marginTop: '8px' }}>Watch how the AI interacts with pipeline leads.</div>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

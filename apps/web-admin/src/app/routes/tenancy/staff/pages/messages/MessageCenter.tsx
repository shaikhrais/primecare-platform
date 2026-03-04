import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

interface Message {
    id: string;
    sender: string;
    role: string;
    lastMessage: string;
    time: string;
    unread: boolean;
}

export default function MessageCenter() {
    const { t } = useTranslation();
    const [selectedId, setSelectedId] = useState('1');

    const chatList: Message[] = [
        { id: '1', sender: 'Elena Rodriguez', role: 'PSW', lastMessage: 'I will be 10 mins late for the Smith visit.', time: '14:22', unread: true },
        { id: '2', sender: 'Alice Freeman', role: 'Family/Client', lastMessage: 'Can we change Thursday to 3 PM?', time: '11:05', unread: false },
        { id: '3', sender: 'Jordan Vale', role: 'PSW', lastMessage: 'The new clinical notes are uploaded.', time: 'Yesterday', unread: false },
        { id: '4', sender: 'Michael Chen', role: 'Nurse/RN', lastMessage: 'Incident report #842 requires review.', time: 'Yesterday', unread: true },
    ];

    return (
        <div className="flex h-[calc(100vh-8rem)] bg-card border rounded-3xl overflow-hidden shadow-2xl animate-in zoom-in-95 duration-500">
            <aside className="w-80 border-r flex flex-col bg-secondary/10">
                <header className="p-6 border-b bg-card sm:bg-transparent">
                    <h2 className="text-xl font-black tracking-tight mb-4">Messages</h2>
                    <div className="relative">
                        <span className="absolute left-3 top-1/2 -translate-y-1/2 opacity-50">🔍</span>
                        <input
                            type="text"
                            placeholder="Search chats..."
                            className="w-full pl-10 pr-4 py-2 bg-background border rounded-xl text-sm outline-none focus:ring-2 focus:ring-primary/20 transition-all font-medium"
                        />
                    </div>
                </header>
                <div className="flex-1 overflow-y-auto divide-y divide-zinc-100">
                    {chatList.map(chat => (
                        <div
                            key={chat.id}
                            onClick={() => setSelectedId(chat.id)}
                            className={`p-5 cursor-pointer hover:bg-white/50 transition-all relative group ${selectedId === chat.id ? 'bg-white shadow-[inset_4px_0_0_0_var(--brand-500)]' : ''}`}
                        >
                            <div className="flex justify-between items-start mb-1">
                                <span className={`text-xs font-black uppercase tracking-tighter ${selectedId === chat.id ? 'text-primary' : 'text-muted-foreground'}`}>
                                    {chat.role}
                                </span>
                                <span className="text-[10px] text-muted-foreground font-mono">{chat.time}</span>
                            </div>
                            <div className="font-bold text-sm truncate group-hover:text-primary transition-colors">{chat.sender}</div>
                            <div className={`text-xs truncate transition-all ${chat.unread && selectedId !== chat.id ? 'text-foreground font-bold' : 'text-muted-foreground font-medium'}`}>
                                {chat.lastMessage}
                            </div>
                            {chat.unread && selectedId !== chat.id && (
                                <div className="absolute right-5 bottom-8 w-2 h-2 rounded-full bg-primary shadow-sm shadow-primary/40 animate-pulse" />
                            )}
                        </div>
                    ))}
                </div>
            </aside>

            <main className="flex-1 flex flex-col bg-white/50 relative">
                <header className="p-6 border-b flex justify-between items-center bg-card/50 backdrop-blur-xl sticky top-0 z-10">
                    <div className="flex items-center gap-4">
                        <div className="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-xl border">
                            {chatList.find(c => c.id === selectedId)?.sender[0]}
                        </div>
                        <div>
                            <div className="font-black tracking-tight">{chatList.find(c => c.id === selectedId)?.sender}</div>
                            <div className="text-[10px] font-black text-primary uppercase tracking-widest leading-none mt-1">
                                {chatList.find(c => c.id === selectedId)?.role} • ONLINE
                            </div>
                        </div>
                    </div>
                    <div className="flex gap-2">
                        <button className="p-2 hover:bg-secondary rounded-lg transition-colors border">📞</button>
                        <button className="p-2 hover:bg-secondary rounded-lg transition-colors border">📁</button>
                    </div>
                </header>

                <div className="flex-1 p-8 overflow-y-auto space-y-6 flex flex-col justify-end">
                    <div className="flex flex-col items-center py-20 opacity-20 select-none">
                        <div className="text-6xl mb-4">💬</div>
                        <p className="text-sm font-black uppercase tracking-[0.2em]">Secure Communication Channel</p>
                    </div>

                    <div className="flex justify-end">
                        <div className="bg-primary text-primary-foreground px-6 py-3 rounded-2xl rounded-tr-none text-sm font-medium max-w-md shadow-lg shadow-primary/10">
                            Hi Elena, checking on the Smith visit status.
                        </div>
                    </div>
                    <div className="flex justify-start">
                        <div className="bg-card border px-6 py-3 rounded-2xl rounded-tl-none text-sm font-medium max-w-md shadow-sm">
                            I will be 10 mins late for the Smith visit. Traffic is heavy around the clinic.
                        </div>
                    </div>
                </div>

                <footer className="p-6 bg-card border-t border-zinc-100">
                    <div className="flex gap-4 items-center bg-background border p-2 rounded-2xl shadow-inner focus-within:ring-2 focus-within:ring-primary/20 transition-all">
                        <button className="p-2 hover:bg-secondary rounded-lg transition-colors">📎</button>
                        <input
                            type="text"
                            placeholder="Type a message..."
                            className="flex-1 bg-transparent border-none outline-none px-2 font-medium text-sm"
                        />
                        <button className="bg-primary text-primary-foreground px-4 py-2 rounded-xl font-bold text-sm hover:opacity-90 shadow-lg shadow-primary/10 transition-all">
                            Send Message
                        </button>
                    </div>
                </footer>
            </main>
        </div>
    );
}

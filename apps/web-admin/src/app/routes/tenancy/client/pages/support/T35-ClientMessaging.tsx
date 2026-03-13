// ================================================================
// PAGE IDENTITY: T35 � Client Messaging
// Type: Tool | Owner: client
// ================================================================
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

export default function ClientMessaging() {
    const { t } = useTranslation();
    const [message, setMessage] = useState('');

    return (
        <div className="p-8 max-w-5xl mx-auto space-y-8 animate-in fade-in zoom-in-95 duration-700">
            <header className="flex justify-between items-center">
                <div className="flex items-center gap-4">
                    <div className="bg-primary/10 p-3 rounded-2xl text-2xl border border-primary/20">
                        👩‍⚕️
                    </div>
                    <div>
                        <h1 className="text-3xl font-black tracking-tight">Nursing Chat Gateway</h1>
                        <p className="text-muted-foreground font-medium">Direct secure line to your dedicated clinical care team.</p>
                    </div>
                </div>
                <div className="flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-green-500 animate-pulse" />
                    <span className="text-[10px] font-black uppercase text-green-600 tracking-widest">Nursing Hub Online</span>
                </div>
            </header>

            <div className="bg-card border rounded-[2.5rem] h-[600px] flex flex-col shadow-2xl overflow-hidden relative border-zinc-200">
                <div className="absolute inset-0 opacity-[0.03] pointer-events-none select-none overflow-hidden">
                    <div className="grid grid-cols-6 gap-8 rotate-12 -translate-y-20">
                        {Array.from({ length: 30 }).map((_, i) => (
                            <div key={i} className="text-4xl">🏥</div>
                        ))}
                    </div>
                </div>

                <div className="flex-1 p-8 overflow-y-auto space-y-6 relative z-10 flex flex-col justify-end">
                    <div className="flex justify-start">
                        <div className="flex gap-4 max-w-md items-end">
                            <div className="w-8 h-8 rounded-full bg-secondary flex items-center justify-center text-xs font-black border shadow-inner">N</div>
                            <div className="bg-zinc-100 px-6 py-4 rounded-3xl rounded-bl-none text-sm font-medium shadow-sm leading-relaxed">
                                Hello Alice! I'm Nurse Sarah. How can I assist you with your father's care plan today?
                            </div>
                        </div>
                    </div>

                    <div className="flex justify-start">
                        <div className="flex gap-4 max-w-md items-end">
                            <div className="w-8 h-8 rounded-full bg-secondary flex items-center justify-center text-xs font-black border shadow-inner">N</div>
                            <div className="bg-zinc-100 px-6 py-4 rounded-3xl rounded-bl-none text-sm font-medium shadow-sm leading-relaxed">
                                I see your request for the extra physical therapy module. I've notified the coordinator.
                            </div>
                        </div>
                    </div>

                    <div className="flex justify-end">
                        <div className="bg-zinc-900 text-white px-6 py-4 rounded-3xl rounded-br-none text-sm font-medium shadow-xl shadow-zinc-200 leading-relaxed max-w-md">
                            Thank you, Sarah! Could you also verify if the new medication schedule has been updated in the portal?
                        </div>
                    </div>
                </div>

                <footer className="p-8 bg-zinc-50 border-t border-zinc-100 relative z-10">
                    <div className="bg-white border-2 border-zinc-200 p-2 rounded-2xl flex items-center gap-4 focus-within:border-primary transition-all shadow-inner">
                        <button className="p-3 hover:bg-zinc-100 rounded-xl transition-all">📎</button>
                        <input
                            type="text"
                            placeholder="Describe your care concern..."
                            className="flex-1 bg-transparent border-none outline-none font-medium text-sm px-2"
                            value={message}
                            onChange={(e) => setMessage(e.target.value)}
                        />
                        <button className="bg-primary text-primary-foreground px-8 py-3 rounded-xl font-black text-xs uppercase tracking-widest shadow-lg shadow-primary/20 hover:scale-105 active:scale-95 transition-all">
                            Send Secure
                        </button>
                    </div>
                    <div className="mt-4 text-center text-[10px] font-black text-muted-foreground uppercase tracking-widest opacity-40">
                        🔒 End-to-End Encrypted HIPAA Compliant Tunnel
                    </div>
                </footer>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {[
                    { title: 'Urgent Care', icon: '🚨', desc: 'Call 911 for emergencies' },
                    { title: 'Refills', icon: '💊', desc: 'Medication requests' },
                    { title: 'Billing', icon: '💳', desc: 'Insurance inquiries' }
                ].map((item, idx) => (
                    <div key={idx} className="bg-card border rounded-3xl p-6 flex items-center gap-4 hover:border-primary/50 transition-all cursor-pointer group">
                        <div className="text-3xl grayscale group-hover:grayscale-0 transition-all">{item.icon}</div>
                        <div>
                            <div className="font-black text-sm">{item.title}</div>
                            <div className="text-[10px] font-bold text-muted-foreground uppercase tracking-tighter">{item.desc}</div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

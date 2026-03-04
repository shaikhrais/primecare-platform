import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

export default function IncidentPortal() {
    const { t } = useTranslation();
    const [selectedType, setSelectedType] = useState('clinical');

    const incidentTypes = [
        { id: 'clinical', label: 'Clinical Incident', icon: '🩺', desc: 'Patient injury, medication error, or health decline.' },
        { id: 'operational', label: 'Operational Risk', icon: '⚙️', desc: 'Equipment failure, facility damage, or process breach.' },
        { id: 'security', label: 'Security Breach', icon: '🛡️', desc: 'Unauthorized access, theft, or data privacy concern.' },
    ];

    return (
        <div className="p-8 max-w-6xl mx-auto space-y-8 animate-in fade-in zoom-in-95 duration-700">
            <header className="flex justify-between items-center bg-zinc-900 p-8 rounded-[2.5rem] text-white shadow-2xl relative overflow-hidden">
                <div className="absolute inset-0 opacity-10 pointer-events-none select-none">
                    <div className="grid grid-cols-6 gap-8 rotate-12 -translate-y-10">
                        {Array.from({ length: 30 }).map((_, i) => (
                            <div key={i} className="text-4xl">⚠️</div>
                        ))}
                    </div>
                </div>
                <div className="relative z-10">
                    <h1 className="text-3xl font-black tracking-tight uppercase">Incident Command Portal</h1>
                    <p className="text-white/60 font-medium">Document critical events for immediate branch-level triage and audit.</p>
                </div>
                <div className="relative z-10 bg-red-500/20 px-6 py-3 rounded-2xl border border-red-500/30">
                    <div className="text-[10px] font-black uppercase tracking-widest text-red-400">Live Alert Status</div>
                    <div className="text-sm font-black text-red-500 animate-pulse">SYSTEM SECURE</div>
                </div>
            </header>

            <div className="grid grid-cols-1 lg:grid-cols-12 gap-10">
                <div className="lg:col-span-4 space-y-6">
                    <h3 className="font-black uppercase tracking-widest text-xs text-muted-foreground px-2">1. Incident Classification</h3>
                    {incidentTypes.map((type) => (
                        <div
                            key={type.id}
                            onClick={() => setSelectedType(type.id)}
                            className={`p-6 rounded-[2rem] border-2 transition-all cursor-pointer group relative overflow-hidden ${selectedType === type.id
                                    ? 'bg-zinc-900 border-zinc-900 text-white shadow-xl shadow-zinc-200'
                                    : 'bg-card border-zinc-100 hover:border-zinc-300'
                                }`}
                        >
                            <div className="flex items-center gap-4 relative z-10">
                                <div className={`text-3xl ${selectedType === type.id ? 'grayscale-0' : 'grayscale group-hover:grayscale-0'} transition-all`}>
                                    {type.icon}
                                </div>
                                <div>
                                    <div className="font-black text-sm">{type.label}</div>
                                    <div className={`text-[10px] font-medium leading-tight mt-1 ${selectedType === type.id ? 'text-white/50' : 'text-muted-foreground'}`}>
                                        {type.desc}
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}

                    <div className="bg-amber-50 border-2 border-amber-100 p-8 rounded-[2rem]">
                        <div className="flex items-center gap-3 mb-4">
                            <span className="text-2xl">💡</span>
                            <span className="font-black text-xs uppercase tracking-widest text-amber-700">Staff Protocol</span>
                        </div>
                        <p className="text-xs font-medium text-amber-800/80 leading-relaxed">
                            For life-threatening emergencies, always call <span className="font-black text-red-600 underline">911</span> first before documenting the event in this portal.
                        </p>
                    </div>
                </div>

                <div className="lg:col-span-8 bg-card border-2 border-zinc-100 rounded-[3rem] p-10 shadow-sm space-y-8">
                    <h3 className="font-black uppercase tracking-widest text-xs text-muted-foreground">2. Event Documentation</h3>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div className="space-y-2">
                            <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground ml-2">Reporting Staff</label>
                            <input type="text" placeholder="Loading session user..." className="w-full bg-zinc-50 border-2 border-zinc-100 rounded-2xl px-6 py-4 text-sm font-medium outline-none focus:border-primary transition-all" value="Shaikh Rais" readOnly />
                        </div>
                        <div className="space-y-2">
                            <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground ml-2">Date & Time of Event</label>
                            <input type="datetime-local" className="w-full bg-zinc-50 border-2 border-zinc-100 rounded-2xl px-6 py-4 text-sm font-medium outline-none focus:border-primary transition-all" />
                        </div>
                    </div>

                    <div className="space-y-2">
                        <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground ml-2">Involved Patient (Search)</label>
                        <div className="relative">
                            <input type="text" placeholder="Start typing patient name..." className="w-full bg-zinc-50 border-2 border-zinc-100 rounded-2xl px-6 py-4 text-sm font-medium outline-none focus:border-primary transition-all pr-12" />
                            <span className="absolute right-6 top-1/2 -translate-y-1/2 text-lg">🔍</span>
                        </div>
                    </div>

                    <div className="space-y-2">
                        <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground ml-2">Detailed Observation</label>
                        <textarea
                            rows={6}
                            placeholder="Provide a factual, clinical description of the event. Exclude personal opinions."
                            className="w-full bg-zinc-50 border-2 border-zinc-100 rounded-[2rem] px-8 py-6 text-sm font-medium outline-none focus:border-primary transition-all resize-none"
                        />
                    </div>

                    <footer className="pt-6 flex justify-between items-center border-t border-zinc-100">
                        <div className="flex items-center gap-2">
                            <div className="w-3 h-3 rounded-full bg-green-500" />
                            <span className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Auto-save Enabled</span>
                        </div>
                        <div className="flex gap-4">
                            <button className="bg-zinc-100 hover:bg-zinc-200 text-zinc-900 px-8 py-4 rounded-2xl font-black text-xs uppercase tracking-widest transition-all">
                                Save Draft
                            </button>
                            <button className="bg-red-600 text-white px-10 py-4 rounded-2xl font-black text-xs uppercase tracking-widest shadow-xl shadow-red-500/20 hover:scale-105 active:scale-95 transition-all">
                                Finalize & File Incident
                            </button>
                        </div>
                    </footer>
                </div>
            </div>
        </div>
    );
}

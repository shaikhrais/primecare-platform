import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

export default function LiveVisit() {
    const { t } = useTranslation();
    const [status, setStatus] = useState<'idle' | 'checked_in' | 'completed'>('idle');
    const [currentTime, setCurrentTime] = useState(new Date().toLocaleTimeString());
    const [tasks, setTasks] = useState([
        { id: '1', label: 'Morning Medication', done: false },
        { id: '2', label: 'Assist with Transfers', done: false },
        { id: '3', label: 'Meal Preparation (Low Sodium)', done: false },
        { id: '4', label: 'Documentation Sink', done: false },
    ]);

    useEffect(() => {
        const timer = setInterval(() => setCurrentTime(new Date().toLocaleTimeString()), 1000);
        return () => clearInterval(timer);
    }, []);

    const toggleTask = (id: string) => {
        setTasks(prev => prev.map(t => t.id === id ? { ...t, done: !t.done } : t));
    };

    return (
        <div className="min-h-screen bg-zinc-50 p-6 flex flex-col gap-6 animate-in fade-in duration-1000 pb-24">
            <header className="flex justify-between items-center bg-white p-6 rounded-[2rem] border border-zinc-100 shadow-sm">
                <div className="flex items-center gap-4">
                    <div className="w-12 h-12 rounded-2xl bg-primary text-primary-foreground flex items-center justify-center text-xl font-black shadow-lg shadow-primary/20">
                        {status === 'checked_in' ? '⏱️' : '🏠'}
                    </div>
                    <div>
                        <h1 className="text-xl font-black tracking-tight">{status === 'checked_in' ? 'Visit in Progress' : 'Client Residence'}</h1>
                        <p className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Sarah Jenkins • Morning Shift</p>
                    </div>
                </div>
                <div className="text-right">
                    <div className="text-lg font-black tracking-tighter tabular-nums">{currentTime}</div>
                    <div className="text-[10px] font-bold text-muted-foreground uppercase">Local Node Time</div>
                </div>
            </header>

            <div className={`p-8 rounded-[2.5rem] border-2 transition-all duration-1000 flex flex-col items-center justify-center gap-8 ${status === 'checked_in'
                    ? 'bg-zinc-900 border-zinc-900 text-white min-h-[400px] shadow-2xl relative overflow-hidden'
                    : 'bg-white border-zinc-100 min-h-[400px]'
                }`}>
                {status === 'checked_in' && (
                    <div className="absolute inset-0 opacity-10 pointer-events-none overflow-hidden">
                        <div className="w-full h-full bg-[radial-gradient(circle_at_center,_var(--brand-500)_1px,_transparent_1px)] bg-[length:24px_24px] animate-pulse" />
                    </div>
                )}

                {status === 'idle' ? (
                    <>
                        <div className="w-24 h-24 rounded-full bg-primary/5 flex items-center justify-center text-4xl animate-bounce">📍</div>
                        <div className="text-center space-y-2">
                            <div className="font-black text-xl">Arrived at Location?</div>
                            <p className="text-sm font-medium text-muted-foreground">GPS verifies you are within 50m of the patient's residence.</p>
                        </div>
                        <button
                            onClick={() => setStatus('checked_in')}
                            className="bg-primary text-primary-foreground px-12 py-5 rounded-[2rem] font-black text-sm uppercase tracking-widest shadow-2xl shadow-primary/30 hover:scale-105 active:scale-95 transition-all"
                        >
                            Confirm & Check-in
                        </button>
                    </>
                ) : (
                    <div className="w-full space-y-8 relative z-10 px-4">
                        <div className="flex justify-between items-end border-b border-white/10 pb-6">
                            <div>
                                <div className="text-[10px] font-black uppercase tracking-widest text-white/40 mb-2">Elapsed Duration</div>
                                <div className="text-5xl font-black tracking-tighter tabular-nums animate-pulse">01:42:08</div>
                            </div>
                            <div className="text-right">
                                <div className="text-[10px] font-black uppercase tracking-widest text-white/40 mb-2">Verified GPS Pulse</div>
                                <div className="flex items-center gap-2 justify-end">
                                    <div className="w-2 h-2 rounded-full bg-green-500 animate-ping" />
                                    <span className="text-xs font-black">LOCKED</span>
                                </div>
                            </div>
                        </div>

                        <div className="space-y-4">
                            <h3 className="text-[10px] font-black uppercase tracking-widest text-white/40 mb-4 px-2">Clinical ADLs Checklist</h3>
                            {tasks.map(task => (
                                <div
                                    key={task.id}
                                    onClick={() => toggleTask(task.id)}
                                    className={`flex items-center justify-between p-6 rounded-3xl border-2 transition-all cursor-pointer ${task.done
                                            ? 'bg-white/10 border-white/20 opacity-50'
                                            : 'bg-white/5 border-white/5 hover:bg-white/10'
                                        }`}
                                >
                                    <span className={`font-bold text-sm ${task.done ? 'line-through' : ''}`}>{task.label}</span>
                                    <div className={`w-6 h-6 rounded-lg border-2 flex items-center justify-center text-[10px] ${task.done ? 'bg-primary border-primary' : 'border-white/20'
                                        }`}>
                                        {task.done ? '✓' : ''}
                                    </div>
                                </div>
                            ))}
                        </div>

                        <button
                            onClick={() => setStatus('completed')}
                            className="w-full bg-white text-zinc-900 py-6 rounded-[2rem] font-black text-sm uppercase tracking-widest hover:bg-red-500 hover:text-white transition-all shadow-xl shadow-white/5"
                        >
                            Check-out & Sync
                        </button>
                    </div>
                )}
            </div>

            <div className="grid grid-cols-2 gap-4">
                <div className="bg-white border border-zinc-100 p-6 rounded-3xl shadow-sm">
                    <div className="text-[10px] font-black uppercase tracking-widest text-muted-foreground mb-4">Patient Vitals Hub</div>
                    <div className="flex items-baseline gap-2">
                        <span className="text-2xl font-black tracking-tighter">120/80</span>
                        <span className="text-[10px] font-black text-muted-foreground italic">mmHg</span>
                    </div>
                </div>
                <div className="bg-white border border-zinc-100 p-6 rounded-3xl shadow-sm">
                    <div className="text-[10px] font-black uppercase tracking-widest text-muted-foreground mb-4">Regional Backup</div>
                    <div className="flex items-center gap-3">
                        <div className="w-8 h-8 rounded-full bg-zinc-100 flex items-center justify-center text-xs">📞</div>
                        <span className="text-[10px] font-black uppercase tracking-widest">Connect to RN</span>
                    </div>
                </div>
            </div>

            <footer className="fixed bottom-0 left-0 right-0 p-6 bg-white/80 backdrop-blur-xl border-t border-zinc-100 z-50 flex justify-between items-center max-w-lg mx-auto rounded-t-[3rem] shadow-2xl">
                <div className="flex flex-col items-center gap-1 group cursor-pointer text-primary">
                    <span className="text-2xl">🏠</span>
                    <span className="text-[8px] font-black uppercase tracking-widest">Home</span>
                </div>
                <div className="flex flex-col items-center gap-1 group cursor-pointer opacity-30">
                    <span className="text-2xl">📋</span>
                    <span className="text-[8px] font-black uppercase tracking-widest">Protocols</span>
                </div>
                <div className="flex flex-col items-center gap-1 group cursor-pointer opacity-30">
                    <span className="text-2xl">💬</span>
                    <span className="text-[8px] font-black uppercase tracking-widest">Nursing</span>
                </div>
                <div className="flex flex-col items-center gap-1 group cursor-pointer opacity-30">
                    <span className="text-2xl">👤</span>
                    <span className="text-[8px] font-black uppercase tracking-widest">Account</span>
                </div>
            </footer>
        </div>
    );
}

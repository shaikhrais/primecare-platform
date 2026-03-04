import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

interface Task {
    id: string;
    title: string;
    patient: string;
    status: 'inbound' | 'processing' | 'verifying' | 'completed';
    priority: 'high' | 'medium' | 'low';
    dueDate: string;
}

export default function TaskGrid() {
    const { t } = useTranslation();
    const [tasks, setTasks] = useState<Task[]>([
        { id: '1', title: 'Insurance Verification', patient: 'Alice Freeman', status: 'inbound', priority: 'high', dueDate: 'Today' },
        { id: '2', title: 'Clinical Intake Call', patient: 'Robert Smith', status: 'processing', priority: 'medium', dueDate: 'Today' },
        { id: '3', title: 'Background Check (PSW)', patient: 'Jordan Vale', status: 'processing', priority: 'high', dueDate: 'Tomorrow' },
        { id: '4', title: 'Consent Forms Signature', patient: 'Mary Lou', status: 'verifying', priority: 'low', dueDate: 'Today' },
        { id: '5', title: 'Referral Audit', patient: 'Sam Jones', status: 'verifying', priority: 'medium', dueDate: 'Friday' },
    ]);

    const columns = [
        { id: 'inbound', label: '📥 Inbound Request', color: 'bg-blue-500' },
        { id: 'processing', label: '⚙️ Processing', color: 'bg-orange-500' },
        { id: 'verifying', label: '🛡️ Verifying', color: 'bg-indigo-500' },
        { id: 'completed', label: '✅ Completed', color: 'bg-green-500' },
    ];

    return (
        <div className="p-8 max-w-[1600px] mx-auto space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-center">
                <div>
                    <h1 className="text-3xl font-black tracking-tight">Staff Task Board</h1>
                    <p className="text-muted-foreground">Manage service intake and operational coordination pipelines.</p>
                </div>
                <button className="px-6 py-3 bg-primary text-primary-foreground rounded-xl font-bold hover:scale-105 transition-all shadow-lg shadow-primary/20">
                    + New Task
                </button>
            </header>

            <div className="flex gap-6 overflow-x-auto pb-8 min-h-[70vh]">
                {columns.map(col => (
                    <div key={col.id} className="flex-1 min-w-[320px] bg-secondary/30 rounded-3xl p-4 flex flex-col gap-4 border-2 border-dashed border-zinc-200 shadow-inner">
                        <header className="flex justify-between items-center px-2 py-1">
                            <span className="text-xs font-black uppercase tracking-widest text-muted-foreground">{col.label}</span>
                            <span className="text-[10px] font-black bg-white/50 px-2 py-0.5 rounded-full border">
                                {tasks.filter(t => t.status === col.id).length}
                            </span>
                        </header>

                        <div className="space-y-4 flex-1">
                            {tasks.filter(t => t.status === col.id).map(task => (
                                <div key={task.id} className="bg-card border rounded-2xl p-5 shadow-sm hover:shadow-md hover:border-primary transition-all cursor-grab active:cursor-grabbing group">
                                    <div className="flex justify-between items-start mb-3">
                                        <div className={`text-[8px] font-black uppercase px-2 py-0.5 rounded-full border ${task.priority === 'high' ? 'bg-red-500/10 text-red-600 border-red-500/20' : 'bg-zinc-500/10 text-zinc-500'}`}>
                                            {task.priority} Priority
                                        </div>
                                        <div className="text-[10px] text-muted-foreground font-mono">{task.id}</div>
                                    </div>
                                    <h3 className="font-bold text-sm leading-tight mb-2 group-hover:text-primary transition-colors">{task.title}</h3>
                                    <div className="flex items-center gap-2 text-xs text-muted-foreground mb-4">
                                        <span>👤</span>
                                        <span className="font-medium">{task.patient}</span>
                                    </div>
                                    <div className="flex justify-between items-center pt-3 border-t">
                                        <div className="flex -space-x-2">
                                            <div className="w-6 h-6 rounded-full bg-primary/20 border-2 border-card flex items-center justify-center text-[8px] font-black">AI</div>
                                            <div className="w-6 h-6 rounded-full bg-secondary border-2 border-card flex items-center justify-center text-[8px] font-black">ST</div>
                                        </div>
                                        <div className="text-[10px] font-black text-muted-foreground uppercase">
                                            Due {task.dueDate}
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

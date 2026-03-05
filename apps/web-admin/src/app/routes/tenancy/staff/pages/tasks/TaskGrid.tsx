import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import './TaskGrid.css';

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
        { id: 'inbound', label: 'Inbound Request', icon: '📥' },
        { id: 'processing', label: 'Processing', icon: '⚙️' },
        { id: 'verifying', label: 'Verifying', icon: '🛡️' },
        { id: 'completed', label: 'Completed', icon: '✅' },
    ];

    return (
        <div className="task-board">
            <header className="task-board-header">
                <div>
                    <h1>Staff Task Board</h1>
                    <p className="text-sm font-medium text-muted-foreground">Manage service intake and operational coordination pipelines.</p>
                </div>
                <button className="btn-modern btn-modern-primary shadow-xl shadow-primary/20">
                    + New Task
                </button>
            </header>

            <div className="task-board-columns">
                {columns.map(col => (
                    <div key={col.id} className="task-column">
                        <header className="task-column-header">
                            <span className="task-column-label">
                                <span className="mr-2">{col.icon}</span>
                                {col.label}
                            </span>
                            <span className="task-column-count">
                                {tasks.filter(t => t.status === col.id).length}
                            </span>
                        </header>

                        <div className="space-y-4 flex-1">
                            {tasks.filter(t => t.status === col.id).map(task => (
                                <div key={task.id} className="task-card">
                                    <div className={`task-priority-tag priority-${task.priority}`}>
                                        {task.priority} Priority
                                    </div>
                                    <h3 className="task-title">{task.title}</h3>
                                    <div className="task-patient">
                                        <span className="opacity-60 text-lg">👤</span>
                                        <span>{task.patient}</span>
                                    </div>
                                    <div className="task-footer">
                                        <div className="task-avatars">
                                            <div className="task-avatar">AI</div>
                                            <div className="task-avatar" style={{ backgroundColor: '#e2e8f0', color: '#475569' }}>ST</div>
                                        </div>
                                        <div className="task-due-date">
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

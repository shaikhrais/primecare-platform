import React, { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry, ApiRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './TaskGrid.css';

const { ContentRegistry } = AdminRegistry;

interface Task {
    id: string;
    title: string;
    description?: string;
    status: 'todo' | 'in_progress' | 'completed' | 'blocked';
    priority: 'low' | 'medium' | 'high' | 'urgent';
    dueDate?: string;
}

export default function TaskGrid() {
    const { t } = useTranslation();
    const [tasks, setTasks] = useState<Task[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchTasks = async () => {
            try {
                const data: any = await apiClient.get(ApiRegistry.TENANCY.STAFF.TASKS);
                if (Array.isArray(data)) {
                    setTasks(data);
                }
            } catch (error) {
                console.error('Failed to fetch staff tasks:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchTasks();
    }, []);

    const columns = [
        { id: 'todo', label: 'Todo', icon: '📥' },
        { id: 'in_progress', label: 'In Progress', icon: '⚙️' },
        { id: 'blocked', label: 'Blocked', icon: '🛡️' },
        { id: 'completed', label: 'Completed', icon: '✅' },
    ];

    if (loading) {
        return (
            <div className="task-board" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '60vh' }}>
                <div className="animate-pulse text-muted-foreground font-black uppercase tracking-widest">
                    Synchronizing Tasks...
                </div>
            </div>
        );
    }

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
                                        <p className="text-xs opacity-70 line-clamp-2">{task.description}</p>
                                    </div>
                                    <div className="task-footer">
                                        <div className="task-avatars">
                                            <div className="task-avatar">AI</div>
                                            <div className="task-avatar" style={{ backgroundColor: '#e2e8f0', color: '#475569' }}>ST</div>
                                        </div>
                                        <div className="task-due-date">
                                            {task.dueDate ? `Due ${new Date(task.dueDate).toLocaleDateString()}` : 'No Due Date'}
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

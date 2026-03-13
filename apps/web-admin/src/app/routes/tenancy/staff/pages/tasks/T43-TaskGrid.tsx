// ================================================================
// PAGE IDENTITY: T43 � Task Grid
// Type: Tool | Owner: staff
// ================================================================
import React, { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './TaskGrid.css';

const { ContentRegistry, ButtonRegistry, ApiRegistry } = AdminRegistry;
const { STAFF_PORTAL } = ContentRegistry;

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
                const response = await apiClient.get(ApiRegistry.TENANCY.STAFF.TASKS);
                const data = await response.json();
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
        { id: 'todo', label: 'Backlog', icon: '📥' },
        { id: 'in_progress', label: 'Active Care', icon: '⚙️' },
        { id: 'blocked', label: 'Flagged', icon: '🛡️' },
        { id: 'completed', label: 'Resolved', icon: '✅' },
    ];

    if (loading) {
        return (
            <div data-cy="page.container" className="task-board" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '60vh' }}>
                <div className="animate-pulse text-muted-foreground font-black uppercase tracking-widest">
                    Synchronizing Tasks...
                </div>
            </div>
        );
    }

    return (
        <div className="task-board">
            <header className="task-board-header">
                <div className="header-content">
                    <h1 data-cy="page.title">{STAFF_PORTAL.TASKS?.TITLE || 'Service Intake Board'}</h1>
                    <p className="subtitle">{STAFF_PORTAL.TASKS?.SUBTITLE || 'Real-time operational coordination'}</p>
                </div>
                <button data-cy="btn-staff.task-grid-0" className="btn-modern btn-primary">
                    {ButtonRegistry.find(b => b.id === 'btn-staff-task-add')?.label || '+ New Task'}
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
                                    <h3 data-cy="h3-staff.task-grid-0" className="task-title">{task.title}</h3>
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

import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useDialog } from '@/shared/hooks/useDialog';

const { ButtonRegistry } = AdminRegistry;

export default function TrainingHub() {
    const { DialogRenderer } = useDialog();
    const { showToast } = useNotification();
    const [modules] = useState([
        { id: '1', title: 'Clinical Compliance 2026', category: 'Compliance', status: 'Published', trainees: 45 },
        { id: '2', title: 'Dementia Care Mastery', category: 'Clinical', status: 'Published', trainees: 12 },
        { id: '3', title: 'Emergency SOS Protocols', category: 'Operations', status: 'Draft', trainees: 0 },
    ]);

    return (
        <div data-cy="page.container" style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>Training Hub</h1>
                    <p style={{ color: '#6b7280' }}>Manage clinical training modules and staff certifications.</p>
                </div>
                <button
                    className="btn primary"
                    onClick={async () => { const title = prompt('Enter module title:'); if (!title) return; try { const { apiClient } = await import('@/shared/utils/apiClient'); const res = await apiClient.post('/v1/admin/training-modules', { title }); if (res.ok) showToast('Module created: ' + title, 'success'); else showToast('Failed to create module', 'error'); } catch { showToast('Network error', 'error'); } }}
                    data-cy="btn-mgr-training-create"
                >
                    {ButtonRegistry.find((b: any) => b.id === 'btn-mgr-training-create')?.label || 'Create Module'}
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '1.5rem' }}>
                {modules.map(mod => (
                    <div key={mod.id} className="pc-card" style={{ padding: '1.5rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
                            <span style={{ fontSize: '0.75rem', fontWeight: 'bold', padding: '0.25rem 0.5rem', borderRadius: '0.25rem', backgroundColor: mod.status === 'Published' ? '#ecfdf5' : '#f3f4f6', color: mod.status === 'Published' ? '#059669' : '#4b5563' }}>
                                {mod.status}
                            </span>
                            <span style={{ fontSize: '0.75rem', color: '#6b7280' }}>{mod.category}</span>
                        </div>
                        <h3 data-cy="h3-manager.training-hub-0" style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '0.5rem' }}>{mod.title}</h3>
                        <p style={{ fontSize: '0.875rem', color: '#4b5563', marginBottom: '1.5rem' }}>
                            Active Trainees: <strong>{mod.trainees}</strong>
                        </p>
                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                            <button data-cy="btn-manager.training-hub-1" className="btn secondary small" style={{ flex: 1 }}>Edit</button>
                            <button data-cy="btn-manager.training-hub-2" className="btn outline small" style={{ flex: 1 }}>Assign</button>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

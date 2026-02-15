import React, { useEffect, useState } from 'react';
import { SmartBreadcrumbs } from '@/shared/components/SmartBreadcrumbs';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { Calendar, dateFnsLocalizer } from 'react-big-calendar';
import { format, parse, startOfWeek, getDay } from 'date-fns';
import { enUS } from 'date-fns/locale';
import 'react-big-calendar/lib/css/react-big-calendar.css';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { CreateVisitModal } from '@/shared/components/modals/CreateVisitModal';

const { ApiRegistry, ContentRegistry } = AdminRegistry;

const locales = {
    'en-US': enUS,
};

const localizer = dateFnsLocalizer({
    format,
    parse,
    startOfWeek,
    getDay,
    locales,
});

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8787';

interface Visit {
    id: string;
    requestedStartAt: string;
    durationMinutes: number;
    client: { fullName: string };
    psw?: { fullName: string };
    assignedPswId?: string;
    status: string;
}

export default function Schedule() {
    const { showToast } = useNotification();
    const [events, setEvents] = useState<any[]>([]);
    const [visits, setVisits] = useState<Visit[]>([]);
    const [psws, setPsws] = useState<any[]>([]);
    const [selectedVisit, setSelectedVisit] = useState<Visit | null>(null);
    const [isAssignModalOpen, setIsAssignModalOpen] = useState(false);
    const [assignedPswId, setAssignedPswId] = useState('');
    const [isCreateVisitModalOpen, setIsCreateVisitModalOpen] = useState(false);
    const [viewMode, setViewMode] = useState<'calendar' | 'list'>('calendar');

    const [searchParams] = useSearchParams();

    useEffect(() => {
        fetchVisits();
        fetchPsws();
    }, [searchParams]); // Re-fetch or re-filter when params change

    const fetchVisits = async () => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS}`, {
                headers: { Authorization: `Bearer ${token}` }
            });
            const data = await res.json();

            if (Array.isArray(data)) {
                let filteredData = data;
                const statusFilter = searchParams.get('status');

                if (statusFilter) {
                    filteredData = data.filter((v: Visit) => v.status.toLowerCase() === statusFilter.toLowerCase());
                }

                setVisits(filteredData);
                const calendarEvents = filteredData.map((visit: Visit) => {
                    const start = new Date(visit.requestedStartAt);
                    const end = new Date(start.getTime() + visit.durationMinutes * 60000);
                    return {
                        id: visit.id,
                        title: `${visit.client?.fullName || 'Unknown Client'} (${visit.status})`,
                        start,
                        end,
                        resource: visit,
                        style: { backgroundColor: getStatusColor(visit.status) }
                    };
                });
                setEvents(calendarEvents);
            }
        } catch (err) {
            console.error(err);
        }
    };

    const fetchPsws = async () => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.USERS}`, {
                headers: { Authorization: `Bearer ${token}` }
            });
            const data = await res.json();
            // Filter only PSWs who are verified
            const filteredPsws = data.filter((u: any) => u.role === 'psw');
            setPsws(filteredPsws);
        } catch (err) {
            console.error(err);
        }
    };

    const handleAssign = async () => {
        if (!selectedVisit || !assignedPswId) return;

        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_ASSIGN}`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    visitId: selectedVisit.id,
                    pswId: assignedPswId
                })
            });

            if (response.ok) {
                setIsAssignModalOpen(false);
                fetchVisits();
                showToast(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_ASSIGN, 'success');
            }
        } catch (err) {
            showToast(ContentRegistry.SCHEDULE.MESSAGES.ERROR_ASSIGN, 'error');
        }
    };

    const getStatusColor = (status: string) => {
        switch (status.toLowerCase()) {
            case 'requested': return '#f57c00'; // Orange
            case 'scheduled': return '#1976d2'; // Blue
            case 'completed': return '#388e3c'; // Green
            default: return '#9e9e9e';
        }
    };

    const handleSelectEvent = (event: any) => {
        const visit = event.resource;
        setSelectedVisit(visit);
        setAssignedPswId(visit.assignedPswId || '');
        setIsAssignModalOpen(true);
    };

    const handleDeleteVisit = async () => {
        if (!selectedVisit) return;
        if (!confirm(ContentRegistry.SCHEDULE.MODAL.CONFIRM_DELETE)) return;

        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(selectedVisit.id)}`, {
                method: 'DELETE',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                setIsAssignModalOpen(false);
                fetchVisits();
                showToast(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_CANCEL, 'success');
            }
        } catch (err) {
            showToast(ContentRegistry.SCHEDULE.MESSAGES.ERROR_DELETE, 'error');
        }
    };

    const handleStatusChange = async (newStatus: string) => {
        if (!selectedVisit) return;
        try {
            const token = localStorage.getItem('token');
            await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(selectedVisit.id)}`, {
                method: 'PATCH',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ status: newStatus })
            });
            fetchVisits();
            setIsAssignModalOpen(false);
        } catch (err) {
            showToast(ContentRegistry.SCHEDULE.MESSAGES.ERROR_UPDATE, 'error');
        }
    };

    return (
        <div style={{ display: 'flex', flexDirection: 'column', height: '100%' }} data-cy="page.container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <div>
                    <SmartBreadcrumbs />
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }} data-cy="page.title">{ContentRegistry.SCHEDULE.TITLE}</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0', fontSize: '0.875rem' }} data-cy="page.header">{ContentRegistry.SCHEDULE.SUBTITLE}</p>
                </div>
                <button
                    data-cy="btn-create-visit"
                    onClick={() => {
                        setSelectedVisit(null);
                        setIsCreateVisitModalOpen(true);
                    }}
                    style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    {ContentRegistry.SCHEDULE.ACTIONS.CREATE}
                </button>
            </div>

            {searchParams.get('status') && (
                <div style={{ marginBottom: '1rem', display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                    <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>Active Filter:</span>
                    <span style={{ padding: '0.25rem 0.75rem', backgroundColor: '#fff7ed', color: '#c2410c', borderRadius: '9999px', fontSize: '0.875rem', fontWeight: 'bold' }}>
                        Status: {searchParams.get('status')?.toUpperCase()}
                    </span>
                    <a href="/admin/schedule" style={{ color: '#ef4444', textDecoration: 'none', fontSize: '0.875rem', cursor: 'pointer' }}>Clear</a>
                </div>
            )}

            <div style={{ marginBottom: '1rem', display: 'flex', justifyContent: 'flex-end', gap: '0.5rem' }}>
                <button
                    onClick={() => setViewMode('calendar')}
                    style={{
                        padding: '0.5rem 1rem',
                        backgroundColor: viewMode === 'calendar' ? '#e5e7eb' : 'white',
                        border: '1px solid #d1d5db',
                        borderRadius: '0.375rem',
                        cursor: 'pointer',
                        fontWeight: viewMode === 'calendar' ? 600 : 400
                    }}
                >
                    Calendar
                </button>
                <button
                    onClick={() => setViewMode('list')}
                    style={{
                        padding: '0.5rem 1rem',
                        backgroundColor: viewMode === 'list' ? '#e5e7eb' : 'white',
                        border: '1px solid #d1d5db',
                        borderRadius: '0.375rem',
                        cursor: 'pointer',
                        fontWeight: viewMode === 'list' ? 600 : 400
                    }}
                >
                    List View
                </button>
            </div>

            {viewMode === 'calendar' ? (
                <div style={{
                    flex: 1,
                    backgroundColor: 'white',
                    borderRadius: '0.75rem',
                    boxShadow: '0 1px 3px rgba(0,0,0,0.1)',
                    padding: '1.5rem',
                    minHeight: '600px'
                }} data-cy="calendar-container">
                    <Calendar
                        localizer={localizer}
                        events={events}
                        startAccessor="start"
                        endAccessor="end"
                        style={{ height: '100%', minHeight: '550px' }}
                        onSelectEvent={handleSelectEvent}
                        views={['month', 'week', 'day']}
                    />
                </div>
            ) : (
                <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', border: '1px solid #e5e7eb', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                        <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                            <tr>
                                <th style={{ padding: '1rem' }}>Date & Time</th>
                                <th style={{ padding: '1rem' }}>Client</th>
                                <th style={{ padding: '1rem' }}>Caregiver</th>
                                <th style={{ padding: '1rem' }}>Status</th>
                                <th style={{ padding: '1rem' }}>Quick Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {visits.map((visit) => (
                                <tr
                                    key={visit.id}
                                    onClick={() => { setSelectedVisit(visit); setAssignedPswId(visit.assignedPswId || ''); setIsAssignModalOpen(true); }}
                                    style={{ cursor: 'pointer', borderBottom: '1px solid #f3f4f6', transition: 'background-color 0.2s' }}
                                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f9fafb'}
                                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
                                >
                                    <td style={{ padding: '1rem' }}>
                                        {new Date(visit.requestedStartAt).toLocaleDateString()} <br />
                                        <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>
                                            {format(new Date(visit.requestedStartAt), 'h:mm a')}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem', fontWeight: 500 }}>{visit.client?.fullName}</td>
                                    <td style={{ padding: '1rem', color: visit.psw ? '#111827' : '#9ca3af' }}>
                                        {visit.psw?.fullName || 'Unassigned'}
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{
                                            padding: '0.25rem 0.625rem',
                                            borderRadius: '9999px',
                                            fontSize: '0.75rem',
                                            fontWeight: 600,
                                            backgroundColor: getStatusColor(visit.status),
                                            color: 'white'
                                        }}>
                                            {visit.status.toUpperCase()}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem' }} onClick={(e) => e.stopPropagation()}>
                                        <div style={{ display: 'flex', gap: '0.75rem', opacity: 0.8 }}>
                                            <button
                                                onClick={() => { setSelectedVisit(visit); setIsCreateVisitModalOpen(true); }}
                                                style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: 600 }}
                                            >
                                                Edit
                                            </button>
                                            {!visit.psw && (
                                                <button
                                                    onClick={() => { setSelectedVisit(visit); setAssignedPswId(''); setIsAssignModalOpen(true); }}
                                                    style={{ color: '#0369a1', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: 600 }}
                                                >
                                                    Assign
                                                </button>
                                            )}
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {isAssignModalOpen && selectedVisit && (
                <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
                    <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%' }}>
                        <h3 style={{ marginTop: 0 }}>{ContentRegistry.SCHEDULE.ACTIONS.ASSIGN}</h3>
                        <div style={{ margin: '1rem 0' }}>
                            <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Client:</strong> {selectedVisit.client?.fullName || 'N/A'}</p>
                            <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Visit:</strong> {new Date(selectedVisit.requestedStartAt).toLocaleString()}</p>
                            <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Status:</strong> {selectedVisit.status.toUpperCase()}</p>
                        </div>

                        <div style={{ marginTop: '1.5rem' }}>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{ContentRegistry.SCHEDULE.MODAL.SELECT_PSW}</label>
                            <select
                                data-cy="modal-select-psw"
                                value={assignedPswId}
                                onChange={(e) => setAssignedPswId(e.target.value)}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            >
                                <option value="">{ContentRegistry.SCHEDULE.MODAL.CHOOSE_WORKER}</option>
                                {psws.map(psw => (
                                    <option key={psw.id} value={psw.PswProfile?.id}>
                                        {psw.PswProfile?.fullName} (Verified)
                                    </option>
                                ))}
                            </select>
                        </div>

                        <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                            <button data-cy="btn-modal-cancel-visit" onClick={handleDeleteVisit} style={{ padding: '0.75rem', backgroundColor: '#fef2f2', color: '#991b1b', border: '1px solid #fecaca', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}>{ContentRegistry.SCHEDULE.ACTIONS.CANCEL_VISIT}</button>
                            <button
                                data-cy="btn-modal-edit-visit"
                                onClick={() => {
                                    setIsAssignModalOpen(false);
                                    setIsCreateVisitModalOpen(true);
                                }}
                                style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: '1px solid #d1d5db', borderRadius: '0.5rem', cursor: 'pointer', fontWeight: '600', color: '#374151' }}
                            >
                                {ContentRegistry.SCHEDULE.ACTIONS.EDIT}
                            </button>
                            <div style={{ flex: 1 }} />
                            <button data-cy="btn-modal-close" onClick={() => setIsAssignModalOpen(false)} style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}>{ContentRegistry.SCHEDULE.ACTIONS.CLOSE}</button>
                            <button
                                data-cy="btn-modal-confirm-assign"
                                onClick={handleAssign}
                                disabled={!assignedPswId}
                                style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', opacity: assignedPswId ? 1 : 0.5, cursor: 'pointer' }}
                            >
                                {ContentRegistry.SCHEDULE.ACTIONS.CONFIRM_ASSIGN}
                            </button>
                        </div>
                    </div>
                </div>
            )}

            <CreateVisitModal
                isOpen={isCreateVisitModalOpen}
                onClose={() => {
                    setIsCreateVisitModalOpen(false);
                    // Clear selected visit when closing create/edit modal if it was opened from edit
                    // But we might want to keep it if we want to return to assign modal?
                    // For now, let's just close.
                }}
                onSuccess={() => {
                    fetchVisits();
                    setSelectedVisit(null); // Clear selection after successful edit
                }}
                visit={selectedVisit} // Pass selected visit for editing
            />
        </div>
    );
}

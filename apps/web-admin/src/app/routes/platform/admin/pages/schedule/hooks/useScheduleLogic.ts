import { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';

const { ApiRegistry, ContentRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8787';

export interface Visit {
    id: string;
    requestedStartAt: string;
    durationMinutes: number;
    client: { fullName: string };
    psw?: { fullName: string };
    assignedPswId?: string;
    status: string;
    isSurgeActive?: boolean;
    surgeMultiplier?: number;
    service?: { providerRateHourly?: string | number };
}

export const useScheduleLogic = () => {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const [searchParams] = useSearchParams();

    const [events, setEvents] = useState<any[]>([]);
    const [visits, setVisits] = useState<Visit[]>([]);
    const [psws, setPsws] = useState<any[]>([]);
    const [selectedVisit, setSelectedVisit] = useState<Visit | null>(null);
    const [isAssignModalOpen, setIsAssignModalOpen] = useState(false);
    const [assignedPswId, setAssignedPswId] = useState('');
    const [isCreateVisitModalOpen, setIsCreateVisitModalOpen] = useState(false);
    const [viewMode, setViewMode] = useState<'calendar' | 'list'>('calendar');
    const [suggestions, setSuggestions] = useState<any[]>([]);
    const [isSuggesting, setIsSuggesting] = useState(false);
    const [isSurgeModalOpen, setIsSurgeModalOpen] = useState(false);
    const [surgeTargetVisit, setSurgeTargetVisit] = useState<Visit | null>(null);

    const getStatusColor = (status: string) => {
        switch (status.toLowerCase()) {
            case 'requested': return '#f57c00';
            case 'scheduled': return '#1976d2';
            case 'completed': return '#388e3c';
            case 'posted': return '#8e24aa';
            case 'offered': return '#00acc1';
            case 'accepted': return '#43a047';
            default: return '#9e9e9e';
        }
    };

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
            if (Array.isArray(data)) {
                const filteredPsws = data.filter((u: any) => u.role === 'psw');
                setPsws(filteredPsws);
            } else {
                setPsws([]);
            }
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
                showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_ASSIGN), 'success');
            }
        } catch (err) {
            showToast(t(ContentRegistry.SCHEDULE.MESSAGES.ERROR_ASSIGN), 'error');
        }
    };

    const fetchSuggestions = async () => {
        if (!selectedVisit) return;
        setIsSuggesting(true);
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(selectedVisit.id)}/suggest`, {
                headers: { Authorization: `Bearer ${token}` }
            });
            const data = await res.json();
            setSuggestions(data);
        } catch (err) {
            console.error(err);
        } finally {
            setIsSuggesting(false);
        }
    };

    const handleOffer = async (pswIds: string[]) => {
        if (!selectedVisit) return;
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(selectedVisit.id)}/offer`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ pswIds })
            });
            if (res.ok) {
                showToast(t(ContentRegistry.SCHEDULE.MESSAGES.OFFERS_SENT), 'success');
                setIsAssignModalOpen(false);
                fetchVisits();
            }
        } catch (err) {
            showToast(t(ContentRegistry.SCHEDULE.MESSAGES.OFFERS_FAILED), 'error');
        }
    };

    const handleApplySurge = async (visitId: string, surgeMultiplier: number, isSurgeActive: boolean) => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}/api/v1/admin/visits/${visitId}/surge`, {
                method: 'PATCH',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ surgeMultiplier, isSurgeActive })
            });

            if (res.ok) {
                showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SURGE_SUCCESS), 'success');
                setIsSurgeModalOpen(false);
                fetchVisits();
            } else {
                showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SURGE_ERROR), 'error');
            }
        } catch (err) {
            showToast(t(ContentRegistry.SCHEDULE.MESSAGES.NETWORK_ERROR), 'error');
        }
    };

    const handleDeleteVisit = async () => {
        if (!selectedVisit) return;
        if (!confirm(t(ContentRegistry.SCHEDULE.MODAL.CONFIRM_DELETE))) return;

        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(selectedVisit.id)}`, {
                method: 'DELETE',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                setIsAssignModalOpen(false);
                fetchVisits();
                showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_CANCEL), 'success');
            }
        } catch (err) {
            showToast(t(ContentRegistry.SCHEDULE.MESSAGES.ERROR_DELETE), 'error');
        }
    };

    const handleSelectEvent = (event: any) => {
        const visit = event.resource;
        setSelectedVisit(visit);
        setAssignedPswId(visit.assignedPswId || '');
        setIsAssignModalOpen(true);
    };

    useEffect(() => {
        fetchVisits();
        fetchPsws();
    }, [searchParams]);

    return {
        events, visits, psws, selectedVisit, isAssignModalOpen, assignedPswId,
        isCreateVisitModalOpen, viewMode, suggestions, isSuggesting,
        isSurgeModalOpen, surgeTargetVisit,
        setSelectedVisit, setIsAssignModalOpen, setAssignedPswId,
        setIsCreateVisitModalOpen, setViewMode, setIsSurgeModalOpen, setSurgeTargetVisit,
        fetchVisits, handleAssign, fetchSuggestions, handleOffer,
        handleApplySurge, handleDeleteVisit, handleSelectEvent, getStatusColor
    };
};

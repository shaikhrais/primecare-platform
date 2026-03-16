import { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useTranslation } from 'react-i18next';
import { useDialog } from '@/shared/hooks/useDialog';
import { type Visit, getStatusColor, apiFetchVisits, apiFetchPsws, apiAssignVisit, apiOfferVisit, apiFetchSuggestions, apiApplySurge, apiDeleteVisit } from './scheduleApi';

const { ContentRegistry } = AdminRegistry;

export type { Visit };
export { getStatusColor };

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

    const fetchVisits = async () => { try { const { visits: v, events: e } = await apiFetchVisits(searchParams.get('status')); setVisits(v); setEvents(e); } catch (err) { console.error(err); } };
    const fetchPsws = async () => { try { setPsws(await apiFetchPsws()); } catch (err) { console.error(err); } };

    const handleAssign = async () => {
        if (!selectedVisit || !assignedPswId) return;
        try { if (await apiAssignVisit(selectedVisit.id, assignedPswId)) { setIsAssignModalOpen(false); fetchVisits(); showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_ASSIGN), 'success'); } }
        catch { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.ERROR_ASSIGN), 'error'); }
    };

    const fetchSuggestions = async () => {
        if (!selectedVisit) return; setIsSuggesting(true);
        try { setSuggestions(await apiFetchSuggestions(selectedVisit.id)); } catch (err) { console.error(err); } finally { setIsSuggesting(false); }
    };

    const handleOffer = async (pswIds: string[]) => {
        if (!selectedVisit) return;
        try { if (await apiOfferVisit(selectedVisit.id, pswIds)) { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.OFFERS_SENT), 'success'); setIsAssignModalOpen(false); fetchVisits(); } }
        catch { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.OFFERS_FAILED), 'error'); }
    };

    const handleApplySurge = async (visitId: string, surgeMultiplier: number, isSurgeActive: boolean) => {
        try { if (await apiApplySurge(visitId, surgeMultiplier, isSurgeActive)) { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SURGE_SUCCESS), 'success'); setIsSurgeModalOpen(false); fetchVisits(); } else { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SURGE_ERROR), 'error'); } }
        catch { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.NETWORK_ERROR), 'error'); }
    };

    const handleDeleteVisit = async () => {
        if (!selectedVisit) return;
        if (!confirm(t(ContentRegistry.SCHEDULE.MODAL.CONFIRM_DELETE))) return;
        try { if (await apiDeleteVisit(selectedVisit.id)) { setIsAssignModalOpen(false); fetchVisits(); showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_CANCEL), 'success'); } }
        catch { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.ERROR_DELETE), 'error'); }
    };

    const handleSelectEvent = (event: any) => { const visit = event.resource; setSelectedVisit(visit); setAssignedPswId(visit.assignedPswId || ''); setIsAssignModalOpen(true); };

    useEffect(() => { fetchVisits(); fetchPsws(); }, [searchParams]);

    return {
        events, visits, psws, selectedVisit, isAssignModalOpen, assignedPswId,
        isCreateVisitModalOpen, viewMode, suggestions, isSuggesting,
        isSurgeModalOpen, surgeTargetVisit,
        setSelectedVisit, setIsAssignModalOpen, setAssignedPswId,
        setIsCreateVisitModalOpen, setViewMode, setIsSurgeModalOpen, setSurgeTargetVisit,
        fetchVisits, fetchPsws, handleAssign, fetchSuggestions, handleOffer,
        handleApplySurge, handleDeleteVisit, handleSelectEvent, getStatusColor
    };
};

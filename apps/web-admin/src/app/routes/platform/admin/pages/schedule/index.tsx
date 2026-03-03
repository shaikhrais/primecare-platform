import React from 'react';
import { useSearchParams } from 'react-router-dom';

// Components
import { ScheduleCalendar } from './components/ScheduleCalendar';
import { ScheduleList } from './components/ScheduleList';
import { ScheduleHeader } from './components/ScheduleHeader';
import { ViewToggle } from './components/ViewToggle';
import { ScheduleModalsContainer } from './components/ScheduleModalsContainer';

// Logic
import { useScheduleLogic } from './hooks/useScheduleLogic';

export default function Schedule() {
    const [searchParams] = useSearchParams();
    const {
        events, visits, psws, selectedVisit, isAssignModalOpen, assignedPswId,
        isCreateVisitModalOpen, viewMode, suggestions, isSuggesting,
        isSurgeModalOpen, surgeTargetVisit,
        setSelectedVisit, setIsAssignModalOpen, setAssignedPswId,
        setIsCreateVisitModalOpen, setViewMode, setIsSurgeModalOpen, setSurgeTargetVisit,
        fetchVisits, handleAssign, fetchSuggestions, handleOffer,
        handleApplySurge, handleDeleteVisit, handleSelectEvent, getStatusColor
    } = useScheduleLogic();

    return (
        <div style={{ display: 'flex', flexDirection: 'column', height: '100%' }} data-cy="page.container">
            <ScheduleHeader onCreateVisit={() => {
                setSelectedVisit(null);
                setIsCreateVisitModalOpen(true);
            }} />

            {searchParams.get('status') && (
                <div style={{ marginBottom: '1rem', display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                    <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>Active Filter:</span>
                    <span style={{ padding: '0.25rem 0.75rem', backgroundColor: '#fff7ed', color: '#c2410c', borderRadius: '9999px', fontSize: '0.875rem', fontWeight: 'bold' }}>
                        Status: {searchParams.get('status')?.toUpperCase()}
                    </span>
                    <a href="/admin/schedule" style={{ color: '#ef4444', textDecoration: 'none', fontSize: '0.875rem', cursor: 'pointer' }}>Clear</a>
                </div>
            )}

            <ViewToggle viewMode={viewMode} setViewMode={setViewMode} />

            {viewMode === 'calendar' ? (
                <ScheduleCalendar
                    events={events}
                    onSelectEvent={handleSelectEvent}
                />
            ) : (
                <ScheduleList
                    visits={visits}
                    getStatusColor={getStatusColor}
                    onEdit={(visit) => {
                        setSelectedVisit(visit);
                        setIsCreateVisitModalOpen(true);
                    }}
                    onAssign={(visit) => {
                        setSelectedVisit(visit);
                        setAssignedPswId(visit.assignedPswId || '');
                        setIsAssignModalOpen(true);
                    }}
                    onSurge={(visit) => {
                        setSurgeTargetVisit(visit);
                        setIsSurgeModalOpen(true);
                    }}
                />
            )}

            <ScheduleModalsContainer
                isAssignModalOpen={isAssignModalOpen}
                setIsAssignModalOpen={setIsAssignModalOpen}
                selectedVisit={selectedVisit}
                psws={psws}
                assignedPswId={assignedPswId}
                setAssignedPswId={setAssignedPswId}
                handleAssign={handleAssign}
                handleDeleteVisit={handleDeleteVisit}
                setIsCreateVisitModalOpen={setIsCreateVisitModalOpen}
                suggestions={suggestions}
                fetchSuggestions={fetchSuggestions}
                handleOffer={handleOffer}
                isSuggesting={isSuggesting}
                isCreateVisitModalOpen={isCreateVisitModalOpen}
                fetchVisits={fetchVisits}
                setSelectedVisit={setSelectedVisit}
                isSurgeModalOpen={isSurgeModalOpen}
                surgeTargetVisit={surgeTargetVisit}
                setIsSurgeModalOpen={setIsSurgeModalOpen}
                handleApplySurge={handleApplySurge}
            />
        </div>
    );
}

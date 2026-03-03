import React from 'react';
import { AssignShiftModal } from './AssignShiftModal';
import { CreateVisitModal } from '@/shared/components/modals/CreateVisitModal';
import { SurgePricingModal } from './SurgePricingModal';

interface ScheduleModalsContainerProps {
    isAssignModalOpen: boolean;
    setIsAssignModalOpen: (open: boolean) => void;
    selectedVisit: any;
    psws: any[];
    assignedPswId: string;
    setAssignedPswId: (id: string) => void;
    handleAssign: () => Promise<void>;
    handleDeleteVisit: () => Promise<void>;
    setIsCreateVisitModalOpen: (open: boolean) => void;
    suggestions: any[];
    fetchSuggestions: () => Promise<void>;
    handleOffer: (pswIds: string[]) => Promise<void>;
    isSuggesting: boolean;
    isCreateVisitModalOpen: boolean;
    fetchVisits: () => Promise<void>;
    setSelectedVisit: (visit: any) => void;
    isSurgeModalOpen: boolean;
    surgeTargetVisit: any;
    setIsSurgeModalOpen: (open: boolean) => void;
    handleApplySurge: (visitId: string, surgeMultiplier: number, isSurgeActive: boolean) => Promise<void>;
}

export function ScheduleModalsContainer({
    isAssignModalOpen,
    setIsAssignModalOpen,
    selectedVisit,
    psws,
    assignedPswId,
    setAssignedPswId,
    handleAssign,
    handleDeleteVisit,
    setIsCreateVisitModalOpen,
    suggestions,
    fetchSuggestions,
    handleOffer,
    isSuggesting,
    isCreateVisitModalOpen,
    fetchVisits,
    setSelectedVisit,
    isSurgeModalOpen,
    surgeTargetVisit,
    setIsSurgeModalOpen,
    handleApplySurge
}: ScheduleModalsContainerProps) {
    return (
        <>
            <AssignShiftModal
                isOpen={isAssignModalOpen}
                onClose={() => setIsAssignModalOpen(false)}
                selectedVisit={selectedVisit}
                psws={psws}
                assignedPswId={assignedPswId}
                setAssignedPswId={setAssignedPswId}
                handleAssign={handleAssign}
                handleDeleteVisit={handleDeleteVisit}
                openEditModal={() => {
                    setIsAssignModalOpen(false);
                    setIsCreateVisitModalOpen(true);
                }}
                suggestions={suggestions}
                onFetchSuggestions={fetchSuggestions}
                onOffer={handleOffer}
                isSuggesting={isSuggesting}
            />

            <CreateVisitModal
                isOpen={isCreateVisitModalOpen}
                onClose={() => {
                    setIsCreateVisitModalOpen(false);
                }}
                onSuccess={() => {
                    fetchVisits();
                    setSelectedVisit(null);
                }}
                visit={selectedVisit}
            />

            {isSurgeModalOpen && surgeTargetVisit && (
                <SurgePricingModal
                    visitId={surgeTargetVisit.id}
                    clientName={surgeTargetVisit.client?.fullName || 'the client'}
                    currentMultiplier={surgeTargetVisit.surgeMultiplier || 1.0}
                    isActive={surgeTargetVisit.isSurgeActive || false}
                    basePayout={Number(surgeTargetVisit.service?.providerRateHourly || 25) * (surgeTargetVisit.durationMinutes / 60)}
                    onClose={() => setIsSurgeModalOpen(false)}
                    onSave={handleApplySurge}
                />
            )}
        </>
    );
}

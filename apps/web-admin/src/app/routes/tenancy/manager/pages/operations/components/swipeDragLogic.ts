// ApprovalSwipeStack: drag physics and API handlers extracted
import { apiClient } from '@/shared/utils/apiClient';

export function useDragHandlers(
    isDragging: boolean,
    startX: number,
    setIsDragging: (v: boolean) => void,
    setStartX: (v: number) => void,
    setDragX: (v: number) => void,
) {
    const handleStart = (e: React.MouseEvent | React.TouchEvent) => {
        setIsDragging(true);
        const clientX = 'touches' in e ? e.touches[0].clientX : e.clientX;
        setStartX(clientX);
    };

    const handleMove = (e: React.MouseEvent | React.TouchEvent) => {
        if (!isDragging) return;
        const clientX = 'touches' in e ? e.touches[0].clientX : e.clientX;
        setDragX(clientX - startX);
    };

    const handleEnd = (dragX: number, stack: any[], onApprove: (id: string) => void, onReject: (id: string) => void) => {
        if (!isDragging) return;
        setIsDragging(false);
        const activeCard = stack[0];
        if (!activeCard) return;
        if (dragX > 100) { onApprove(activeCard.id); }
        else if (dragX < -100) { onReject(activeCard.id); }
        else { setDragX(0); }
    };

    return { handleStart, handleMove, handleEnd };
}

export async function approveItem(id: string): Promise<void> {
    await apiClient.post(`/v1/manager/ops/approvals/${id}/approve`);
}

export async function rejectItem(id: string): Promise<void> {
    await apiClient.post(`/v1/manager/ops/approvals/${id}/reject`);
}

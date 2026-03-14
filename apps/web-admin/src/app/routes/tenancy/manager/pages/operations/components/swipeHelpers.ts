// ApprovalSwipeStack: type + physics + card background extracted
export interface ApprovalItem { id: string; type: 'Timesheet' | 'Expense'; employee: string; amount: string; date: string; tags: string[]; }

export function getSwipeBackgroundColor(isDragging: boolean, dragX: number): string {
    if (!isDragging) return 'white';
    if (dragX > 50) return '#ECFDF5';
    if (dragX < -50) return '#FEF2F2';
    return 'white';
}

export interface EarningRecord {
    id: string;
    date: string;
    shiftId: string;
    client: string;
    psw: string;
    hours: number;
    revenue: number;
    payroll: number;
    profit: number;
    paymentStatus: 'Paid' | 'Unpaid' | 'Partial';
    payoutStatus: 'Paid' | 'Pending';
}

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

export const MOCK_EARNINGS: EarningRecord[] = [
    { id: 'INV-1001', date: '2026-02-12', shiftId: 'SH-003', client: 'Alice J.', psw: 'Shaikh R.', hours: 4, revenue: 160.00, payroll: 100.00, profit: 60.00, paymentStatus: 'Paid', payoutStatus: 'Pending' },
    { id: 'INV-1002', date: '2026-02-11', shiftId: 'SH-004', client: 'John D.', psw: 'Sara K.', hours: 6, revenue: 240.00, payroll: 150.00, profit: 90.00, paymentStatus: 'Paid', payoutStatus: 'Paid' },
    { id: 'INV-1003', date: '2026-02-10', shiftId: 'SH-005', client: 'Mary L.', psw: 'Shaikh R.', hours: 8, revenue: 320.00, payroll: 200.00, profit: 120.00, paymentStatus: 'Unpaid', payoutStatus: 'Pending' },
    { id: 'INV-1004', date: '2026-02-05', shiftId: 'SH-006', client: 'Robert D.', psw: 'Emily W.', hours: 5, revenue: 200.00, payroll: 125.00, profit: 75.00, paymentStatus: 'Paid', payoutStatus: 'Paid' },
    { id: 'INV-1005', date: '2026-01-28', shiftId: 'SH-007', client: 'Sarah M.', psw: 'John S.', hours: 10, revenue: 400.00, payroll: 250.00, profit: 150.00, paymentStatus: 'Paid', payoutStatus: 'Paid' },
];

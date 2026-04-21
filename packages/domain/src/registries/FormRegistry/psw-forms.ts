import type { FormEntry } from '../01_I_form_registry';

export const PSW_FORMS: FormEntry[] = [
    {
        id: 'psw.handover',
        label: 'Shift Handover',
        route: '/tenancy/psw/handover',
        apiEndpoint: '/v1/psw/handover',
        method: 'POST',
        dataCyPrefix: 'handover',
        category: 'psw',
        fields: [
            { name: 'visitId', label: 'Visit', type: 'select', required: true, fetchOptionsFrom: '/v1/psw/schedule/visits' },
            { name: 'clientCondition', label: 'Client Condition Summary', type: 'textarea', required: true },
            { name: 'tasksCompleted', label: 'Tasks Completed', type: 'textarea', required: true },
            { name: 'tasksRemaining', label: 'Outstanding Tasks', type: 'textarea', required: false },
            { name: 'urgentNotes', label: 'Urgent Notes', type: 'textarea', required: false },
        ],
    },
    {
        id: 'psw.expenses',
        label: 'Expense Claim',
        route: '/tenancy/psw/expenses',
        apiEndpoint: '/v1/psw/expenses',
        method: 'POST',
        dataCyPrefix: 'expense',
        category: 'psw',
        fields: [
            { name: 'category', label: 'Expense Category', type: 'select', required: true },
            { name: 'amount', label: 'Amount ($)', type: 'number', required: true },
            { name: 'date', label: 'Date', type: 'date', required: true },
            { name: 'receipt', label: 'Receipt Upload', type: 'file', required: true },
            { name: 'description', label: 'Description', type: 'textarea', required: false },
        ],
    },
    {
        id: 'psw.availability',
        label: 'Availability Schedule',
        route: '/tenancy/psw/availability',
        apiEndpoint: '/v1/psw/availability/sync',
        method: 'POST',
        dataCyPrefix: 'availability',
        category: 'psw',
        fields: [
            { name: 'dayOfWeek', label: 'Day of Week', type: 'select', required: true },
            { name: 'startTime', label: 'Start Time', type: 'time', required: true },
            { name: 'endTime', label: 'End Time', type: 'time', required: true },
            { name: 'isRecurring', label: 'Recurring Weekly', type: 'checkbox', required: false },
        ],
    },
];

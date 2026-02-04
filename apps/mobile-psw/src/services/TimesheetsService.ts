// @ts-ignore
import { API_URL, MOBILE_APP_KEY } from '@env';
import { PswRegistry } from 'prime-care-shared';

const { ApiRegistry } = PswRegistry;

export interface TimesheetEntry {
    id: string;
    date: string;
    hours: number;
    earnings: number;
    status: 'pending' | 'approved' | 'paid';
}

export const TimesheetsService = {
    getTimesheets: async (): Promise<TimesheetEntry[]> => {
        // Mock data for now since backend might not be ready
        return [
            { id: '1', date: '2023-10-25', hours: 5.5, earnings: 137.50, status: 'approved' },
            { id: '2', date: '2023-10-26', hours: 4.0, earnings: 100.00, status: 'pending' },
        ];

        /* Uncomment when API is ready
        const response = await fetch(`${API_URL}${ApiRegistry.PSW.TIMESHEETS}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
        });
        if (!response.ok) throw new Error('Failed to fetch timesheets');
        return await response.json();
        */
    }
};

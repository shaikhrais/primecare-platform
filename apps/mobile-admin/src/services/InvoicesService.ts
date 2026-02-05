// @ts-ignore
import { API_URL, MOBILE_APP_KEY } from '@env';
import { ClientRegistry } from 'prime-care-shared';

const { ApiRegistry } = ClientRegistry;

export interface Invoice {
    id: string;
    amount: number;
    status: 'pending' | 'paid' | 'overdue';
    dueDate: string;
    description: string;
}

export const InvoicesService = {
    getInvoices: async (): Promise<Invoice[]> => {
        const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.INVOICES}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
        });
        if (!response.ok) throw new Error('Failed to fetch invoices');
        return await response.json();
    }
};

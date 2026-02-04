// @ts-ignore
import { API_URL, MOBILE_APP_KEY } from '@env';
import { ClientRegistry } from '@primecare/shared';

const { ApiRegistry } = ClientRegistry;

export interface Service {
    id: string;
    name: string;
    description: string;
    price: number;
}

export interface Booking {
    id: string;
    service: { name: string };
    requestedStartAt: string;
    status: string;
}

export const BookingsService = {
    getServices: async (): Promise<Service[]> => {
        const response = await fetch(`${API_URL}${ApiRegistry.PUBLIC.SERVICES}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
        });
        if (!response.ok) throw new Error('Failed to fetch services');
        return await response.json();
    },

    getBookings: async (): Promise<Booking[]> => {
        const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.BOOKINGS}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
        });
        if (!response.ok) throw new Error('Failed to fetch bookings');
        return await response.json();
    },

    createBooking: async (serviceId: string, requestedStartAt: string, comments?: string) => {
        const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.BOOKINGS}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
            body: JSON.stringify({ serviceId, requestedStartAt, comments }),
        });
        if (!response.ok) throw new Error('Booking failed');
        return await response.json();
    }
};

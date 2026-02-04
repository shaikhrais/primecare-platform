// @ts-ignore
import { API_URL, MOBILE_APP_KEY } from '@env';
import { PswRegistry } from '@primecare/shared';

const { ApiRegistry } = PswRegistry;

interface Visit {
    id: string;
    clientId: string;
    serviceId: string;
    requestedStartAt: string;
    durationMinutes: number;
    status: string;
    client: {
        fullName: string;
        addressLine1: string;
        city: string;
    };
    service: {
        name: string;
    };
}

export const VisitsService = {
    getVisits: async (): Promise<Visit[]> => {
        try {
            const response = await fetch(`${API_URL}${ApiRegistry.PSW.VISITS}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'x-mobile-app-key': MOBILE_APP_KEY,
                },
            });

            if (!response.ok) {
                throw new Error('Failed to fetch visits');
            }

            return await response.json();
        } catch (error) {
            console.error('getVisits Error:', error);
            throw error;
        }
    },

    checkIn: async (visitId: string, lat: number, lng: number) => {
        const response = await fetch(`${API_URL}${ApiRegistry.PSW.CHECK_IN(visitId)}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
            body: JSON.stringify({ lat, lng, accuracy: 10 }),
        });
        if (!response.ok) throw new Error('Check-in failed');
        return await response.json();
    },

    checkOut: async (visitId: string, lat: number, lng: number) => {
        const response = await fetch(`${API_URL}${ApiRegistry.PSW.CHECK_OUT(visitId)}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
            body: JSON.stringify({ lat, lng, accuracy: 10 }),
        });
        if (!response.ok) throw new Error('Check-out failed');
        return await response.json();
    }
};

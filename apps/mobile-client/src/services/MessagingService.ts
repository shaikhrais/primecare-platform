// @ts-ignore
import { API_URL, MOBILE_APP_KEY } from '@env';
import { ClientRegistry } from '@primecare/shared';

const { ApiRegistry } = ClientRegistry;

export interface Message {
    id: string;
    sender: 'user' | 'support';
    text: string;
    timestamp: string;
}

export const MessagingService = {
    getMessages: async (): Promise<Message[]> => {
        // Mocking response for now as backend might not have this endpoint fully ready or populated
        return [
            { id: '1', sender: 'support', text: 'Welcome to PrimeCare! How can we help?', timestamp: new Date().toISOString() }
        ];

        /* Uncomment when API is ready
        const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.MESSAGES}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
        });
        if (!response.ok) throw new Error('Failed to fetch messages');
        return await response.json();
        */
    },

    sendMessage: async (text: string): Promise<Message> => {
        // Mock send
        return {
            id: Date.now().toString(),
            sender: 'user',
            text,
            timestamp: new Date().toISOString()
        };

        /* Uncomment when API is ready
        const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.MESSAGES}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'x-mobile-app-key': MOBILE_APP_KEY,
            },
            body: JSON.stringify({ text }),
        });
        if (!response.ok) throw new Error('Failed to send message');
        return await response.json();
        */
    }
};

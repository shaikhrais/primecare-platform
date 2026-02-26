
class WebChatService {
    private socket: WebSocket | null = null;
    private listeners: ((message: any) => void)[] = [];
    private reconnectInterval: any = null;
    private userId: string | null = null;
    private url: string = import.meta.env.VITE_API_URL || 'http://localhost:8787';

    constructor() {
        this.url = this.url.replace('http', 'ws') + '/ws/chat';
    }

    connect(userId: string) {
        this.userId = userId;
        if (this.socket) {
            this.socket.close();
        }

        const wsUrl = `${this.url}?userId=${userId}`;
        console.log('Connecting to Chat:', wsUrl);

        try {
            this.socket = new WebSocket(wsUrl);

            this.socket.onopen = () => {
                console.log('Chat Connected');
                if (this.reconnectInterval) {
                    clearInterval(this.reconnectInterval);
                    this.reconnectInterval = null;
                }
            };

            this.socket.onmessage = (event) => {
                try {
                    const data = JSON.parse(event.data);
                    this.listeners.forEach(listener => listener(data));
                } catch (e) {
                    this.listeners.forEach(listener => listener({ message: event.data, sender: 'System' }));
                }
            };

            this.socket.onclose = (e) => {
                console.log('Chat Disconnected', e.reason);
                if (!this.reconnectInterval) {
                    this.reconnectInterval = setInterval(() => {
                        if (this.userId) this.connect(this.userId);
                    }, 5000);
                }
            };

            this.socket.onerror = (e) => {
                console.log('Chat Error:', e);
            };
        } catch (e) {
            console.error('Socket creation error:', e);
        }
    }

    sendMessage(message: string) {
        if (this.socket && this.socket.readyState === WebSocket.OPEN) {
            this.socket.send(JSON.stringify({ message, userId: this.userId, timestamp: new Date().toISOString() }));
        } else {
            console.warn('Socket not open');
        }
    }

    addListener(callback: (message: any) => void) {
        this.listeners.push(callback);
        return () => {
            this.listeners = this.listeners.filter(l => l !== callback);
        };
    }

    disconnect() {
        if (this.socket) {
            this.socket.close();
            this.socket = null;
        }
        if (this.reconnectInterval) {
            clearInterval(this.reconnectInterval);
            this.reconnectInterval = null;
        }
    }
}

export const webChatService = new WebChatService();

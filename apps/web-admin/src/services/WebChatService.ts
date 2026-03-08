
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

        // R17: Include auth cookie in WebSocket connection
        // Note: WebSocket API sends cookies automatically for same-origin.
        // For cross-origin, the browser includes cookies if withCredentials-like behavior is set at the server.
        // The userId is still sent as a hint, but the server MUST validate the JWT cookie.
        const wsUrl = `${this.url}?userId=${userId}`;

        try {
            this.socket = new WebSocket(wsUrl);

            this.socket.onopen = () => {
                // R17: Don't log WebSocket connection details
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
                // R17: Don't log disconnect reasons
                if (!this.reconnectInterval) {
                    this.reconnectInterval = setInterval(() => {
                        if (this.userId) this.connect(this.userId);
                    }, 5000);
                }
            };

            this.socket.onerror = () => {
                // R17: Don't log WebSocket errors to console
            };
        } catch {
            // R17: Silent fail — reconnect will retry
        }
    }

    sendMessage(message: string) {
        if (this.socket && this.socket.readyState === WebSocket.OPEN) {
            this.socket.send(JSON.stringify({ message, userId: this.userId, timestamp: new Date().toISOString() }));
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

import { randomUUID } from 'crypto';

/**
 * Epic 45: Suspicious Download Alerting
 * 
 * Simulated backend worker that monitors high-volume GET requests targeting the 
 * document repository (PDFs, PPTs, Training MP4s). If an authenticated session
 * attempts to scrape the entire library rapidly, it triggers a SOC alert 
 * to prevent intellectual property theft.
 */

interface DownloadEvent {
    userId: string;
    assetId: string;
    timestamp: number;
    ipAddress: string;
}

export class SuspiciousDownloadAlerter {
    private static DOWNLOAD_THRESHOLD = 50; // Max allowed downloads in 5 minutes
    private static TIME_WINDOW_MS = 5 * 60 * 1000;

    /**
     * Synthetically analyzes an event stream of asset downloads logs
     */
    static async analyzeDownloadVelocity(recentEvents: DownloadEvent[]): Promise<void> {
        console.log(`[Security Worker] Analyzing ${recentEvents.length} recent asset downloads...`);

        // Group events by User ID
        const userActivity = new Map<string, DownloadEvent[]>();
        
        for (const event of recentEvents) {
            const history = userActivity.get(event.userId) || [];
            history.push(event);
            userActivity.set(event.userId, history);
        }

        const now = Date.now();

        for (const [userId, events] of userActivity.entries()) {
            // Filter events within the trailing 5-minute window
            const recentHits = events.filter(e => now - e.timestamp < this.TIME_WINDOW_MS);

            if (recentHits.length >= this.DOWNLOAD_THRESHOLD) {
                const uniqueAssets = new Set(recentHits.map(e => e.assetId)).size;
                
                console.error(`\n[CRITICAL ALERT] Potential Data Exfiltration Detected!`);
                console.error(`- User ID: ${userId}`);
                console.error(`- Source IP: ${recentHits[0].ipAddress}`);
                console.error(`- Velocity: ${recentHits.length} downloads in ${this.TIME_WINDOW_MS / 1000 / 60} minutes`);
                console.error(`- Unique Files Scraped: ${uniqueAssets}`);
                
                await this.triggerSocAlert(userId, recentHits.length);
            }
        }
    }

    private static async triggerSocAlert(userId: string, count: number) {
        console.warn(`[API] Dispatching webhook to PagerDuty/Slack for Security Operations Center...`);
        // Simulate remote network latency
        await new Promise(res => setTimeout(res, 800));
        console.warn(`[Security Worker] Account '${userId}' automatically temporarily locked pending review.\n`);
    }

    /**
     * Helper to mock data for terminal demonstrations
     */
    static triggerMockScrapeAttack() {
        const mockBadActorId = 'usr_9x8f2_malicious';
        const simulatedEvents: DownloadEvent[] = [];
        
        for (let i = 0; i < 75; i++) {
            simulatedEvents.push({
                userId: mockBadActorId,
                assetId: `doc_${randomUUID()}`,
                timestamp: Date.now() - (Math.random() * 200000), // Within last ~3 mins
                ipAddress: '192.168.1.145'
            });
        }

        this.analyzeDownloadVelocity(simulatedEvents);
    }
}

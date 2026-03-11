/**
 * Epic 50: AI 'Ghost' Training
 * 
 * Interactive sandbox module that trains new Coordinators/Dispatchers.
 * It simulates a busy environment by generating hyper-realistic synthetic
 * text messages from "field staff" calling off or reporting delays, 
 * evaluating how the trainee responds to the crisis.
 */

interface SimulationEvent {
    id: string;
    type: 'CALL_OFF' | 'TRAFFIC_DELAY' | 'INCIDENT_REPORT';
    simulatedWorkerId: string;
    messageText: string;
    timestamp: number;
}

export class GhostDispatcher {

    /**
     * Generates a random chaotic event based on LLM profiles.
     */
    static triggerSyntheticCrisis(): SimulationEvent {
        const events = [
            { type: 'CALL_OFF' as const, text: "Hey it's Mark. My car won't start and I'm supposed to be at Mrs. Henderson's in 20 minutes. Can't make it." },
            { type: 'TRAFFIC_DELAY' as const, text: "Accident on the 401. Going to be at least 45 mins late to my 3PM shift." },
            { type: 'INCIDENT_REPORT' as const, text: "Client slipped on the rug. He's okay but has a bruise on his elbow. Do I call 911 or just fill the form?" }
        ];

        const randomEvent = events[Math.floor(Math.random() * events.length)];

        console.log(`[Ghost AI] Generated synthetic training event: ${randomEvent.type}`);

        return {
            id: `sim_${Math.random().toString(36).substring(7)}`,
            type: randomEvent.type,
            simulatedWorkerId: `mock_w_${Math.floor(Math.random() * 10)}`,
            messageText: randomEvent.text,
            timestamp: new Date().getTime()
        };
    }

    /**
     * Evaluates a trainee's response to an event using simple heuristics
     */
    static evaluateTraineeResponse(eventId: string, responseAction: string): { grade: string, feedback: string } {
        // Mocks an LLM analysis of the dispatcher's text/action
        // E.g., if responseAction length is short and doesn't re-assign the shift
        if (responseAction.includes("reassign") || responseAction.includes("call backup")) {
            return { grade: 'A', feedback: 'Excellent. You successfully identified the risk and prioritized covering the shift.' };
        }
        
        return { grade: 'C-', feedback: 'You need to proactively re-assign the shift before it becomes a missed visit violation.' };
    }
}

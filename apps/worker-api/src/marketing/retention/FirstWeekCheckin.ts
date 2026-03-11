/**
 * Epic 43: First Week Automated Check-In
 * 
 * Simulated backend worker that intercepts 'Buyer's Remorse'.
 * Home care cancellation rates are highest in the first 7 days.
 * This worker runs daily, checking for contracts signed exactly 7 days ago.
 * It sends an automated SMS to the family asking "How did week 1 go?". 
 * If they reply negatively, it instantly alerts the CMO to save the account.
 */

interface NewContract {
    contractId: string;
    patientName: string;
    startDate: string; // ISO format
    familyPhone: string;
    leadValue: number;
}

export class FirstWeekCheckin {

    static async executeDailyCheckins() {
        console.log(`[Retention Engine] Scanning for "Week 1" anniversary accounts...`);
        
        // Simulating DB fetch
        await new Promise(res => setTimeout(res, 800));

        // Let's pretend today is exactly 7 days after these start dates
        const contracts: NewContract[] = [
            { contractId: 'CON_882', patientName: 'Robert M.', startDate: '7_DAYS_AGO', familyPhone: '+15555551212', leadValue: 12500 },
            { contractId: 'CON_914', patientName: 'Betty C.', startDate: '7_DAYS_AGO', familyPhone: '+15555559898', leadValue: 45000 }
        ];

        console.log(`[Retention Engine] Found ${contracts.length} accounts hitting the critical 7-day milestone. Deploying interception SMS...`);

        for (const contract of contracts) {
            console.log(`\n--- Automating Touchpoint for ${contract.patientName} [$${contract.leadValue.toLocaleString()}/yr LTV] ---`);
            console.log(`>> [Twilio SMS Dispatch] TO: ${contract.familyPhone}`);
            console.log(`   "Hi there, this is the PrimeCare Clinical Team. You've just finished your first week of service! How is everything going so far? Please reply with a number 1-5 (5 being Excellent).`);
        }

        console.log(`\n[Retention Engine] Surveys dispatched. Awaiting Webhook replies...`);
        
        // Simulating a negative reply
        await new Promise(res => setTimeout(res, 1500));
        console.log(`\n🚨 [WEBHOOK RECEIVED] Reply from ${contracts[1].familyPhone} (Betty C.): "2. The nurse was late on Tuesday."`);
        
        console.log(`>> [Escalation Workflow Triggered] Churn risk detected during honeymoon phase.`);
        console.log(`>> Sending urgent Slack alert to Clinical Director & CMO to call Betty C.'s family immediately before they cancel the $45k contract.\n`);
    }

    /**
     * Helper to mock data for terminal demonstrations
     */
    static runDemo() {
        this.executeDailyCheckins();
    }
}

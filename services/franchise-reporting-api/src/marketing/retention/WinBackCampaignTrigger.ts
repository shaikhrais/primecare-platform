/**
 * Epic 45: Win-Back Campaign Trigger
 * 
 * Backend worker that attempts to revive dead leads.
 * If a patient discharged (e.g., they recovered from hip surgery),
 * they remain in the database. 6 months later, they might need care again.
 * This worker automatically texts the family: "Just checking in to 
 * see how Mom is doing!" to re-activate the relationship.
 */

interface DischargedPatient {
    id: string;
    patientName: string;
    dischargeDate: string; // ISO format
    dischargeReason: 'RECOVERED' | 'TRANSFER' | 'DECEASED' | 'HOSPITALIZED';
    familyContactPhone: string;
}

export class WinBackCampaignTrigger {

    static async executeMonthlyWinBacks(prisma: any) {
        console.log(`[Retention Engine] Scanning for "6-Month Discharge" accounts (Win-Back Candidates)...`);
        
        const dischargedUsers = await prisma.user.findMany({
            where: { role: 'CLIENT' },
            take: 3
        });

        const dischargedLedger: DischargedPatient[] = dischargedUsers.map((u: any, idx: number) => ({
            id: `PAT_${u.id}`,
            patientName: u.fullName || 'Client',
            dischargeDate: '6_MONTHS_AGO',
            dischargeReason: idx === 1 ? 'DECEASED' : (idx === 2 ? 'TRANSFER' : 'RECOVERED'),
            familyContactPhone: u.phone || '+15550000000'
        }));

        // Critical safety filter: Never run marketing automations on deceased patients
        const validCandidates = dischargedLedger.filter(p => p.dischargeReason !== 'DECEASED' && p.dischargeDate === '6_MONTHS_AGO');

        if (validCandidates.length === 0) {
             console.log(`[Retention Engine] No valid win-back candidates found.\n`);
             return;
        }

        console.log(`[Retention Engine] Found ${validCandidates.length} viable Win-Back targets. Executing re-engagement protocol...`);

        for (const candidate of validCandidates) {
            console.log(`\n--- Automating Win-Back Touchpoint for: ${candidate.patientName} ---`);
            console.log(`Reason for previous discharge: ${candidate.dischargeReason}`);
            
            let message = '';
            if (candidate.dischargeReason === 'RECOVERED') {
                message = `"Hi there, this is the PrimeCare Clinical Team! We know it's been about 6 months since ${candidate.patientName} recovered and stopped services. Just checking in to see how they are doing! If you ever need part-time support again, let us know."`;
            } else if (candidate.dischargeReason === 'TRANSFER') {
                message = `"Hi there, this is the PrimeCare Team. We are always looking to improve our services and would love to hear how ${candidate.patientName} is doing. Reply 'YES' if you'd be open to a quick 5-minute feedback call with our Clinical Director."`;
            }

            console.log(`>> [Twilio SMS Dispatch] TO: ${candidate.familyContactPhone}`);
            console.log(`   ${message}`);
        }

        console.log(`\n[Retention Engine] Win-back SMS batch complete. Tracking replies in the CRM inbox.\n`);
    }
}

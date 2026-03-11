/**
 * Epic 42: Patient Birthday Automator
 * 
 * Simulated backend worker that runs nightly via cron.
 * It queries the database for active patients whose birthday matches today.
 * To boost retention and humanize the brand, it automatically queues up an
 * SMS/Email to the family, and crucially, pages the assigned caregiver
 * reminding them to say "Happy Birthday" when they arrive for shift.
 */

interface ActivePatient {
    id: string;
    name: string;
    dateOfBirth: string; // ISO format
    primaryCaregiverId: string;
    familyContactPhone: string;
}

export class PatientBirthdayAutomator {

    static async executeNightlyBirthdayBatch(prisma: any) {
        console.log(`[Retention Engine] Scanning active patient ledger for birthdays...`);
        
        const todayStr = new Date().toISOString().substring(5, 10); // '-MM-DD'

        // Simulating DB fetch
        await new Promise(res => setTimeout(res, 800));

        const patients: ActivePatient[] = [
            { id: 'PAT_1092', name: 'Eleanor F.', dateOfBirth: '1945-11-20', primaryCaregiverId: 'CG_92', familyContactPhone: '+15551234567' },
            { id: 'PAT_3341', name: 'Arthur D.', dateOfBirth: `1938${todayStr}`, primaryCaregiverId: 'CG_14', familyContactPhone: '+15559876543' }
        ];

        const birthdayPatients = patients.filter(p => p.dateOfBirth.endsWith(todayStr));

        if (birthdayPatients.length === 0) {
            console.log(`[Retention Engine] No birthdays found today.\n`);
            return;
        }

        console.log(`[Retention Engine] Found ${birthdayPatients.length} birthdays today. Executing outreach automation...`);

        for (const patient of birthdayPatients) {
            const age = new Date().getFullYear() - parseInt(patient.dateOfBirth.substring(0, 4));
            
            console.log(`\n--- Dispatching Automations for: ${patient.name} (Turning ${age}) ---`);
            
            await prisma.communicationLog.create({
                data: {
                    recipientId: patient.familyContactPhone,
                    channel: 'SMS',
                    status: 'processed',
                    metadata: JSON.stringify({ type: 'birthday_greeting', patientId: patient.id })
                }
            });

            // 1. Alert the caregiver
            console.log(`>> [Twilio SMS] Paging Caregiver ${patient.primaryCaregiverId}: "Friendly reminder! Today is ${patient.name}'s birthday! Please be sure to wish them a happy birthday when you arrive for shift today!"`);
            
            // 2. Alert the family
            console.log(`>> [Twilio SMS] Texting Family (${patient.familyContactPhone}): "Happy Birthday to ${patient.name} from the entire PrimeCare team! We are honored to be a part of their care journey."`);
        }

        console.log(`\n[Retention Engine] Birthday batch complete.\n`);
    }

    /**
     * Helper to mock data for terminal demonstrations
     */
    static runDemo(prisma: any) {
        this.executeNightlyBirthdayBatch(prisma);
    }
}

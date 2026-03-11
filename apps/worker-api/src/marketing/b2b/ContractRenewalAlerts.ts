/**
 * Epic 19: Contract Renewal Alerts
 * 
 * Simulated backend CRON job. Scans the 'B2B Contracts' database nightly.
 * If a lucrative Preferred Provider contract with a hospital is within 
 * 90 days of expiration, it automatically emails the CMO and assigned 
 * Account Executive to begin renegotiations immediately to prevent revenue loss.
 */

export class ContractRenewalAlerts {

    static async scanExpiringAgreements() {
        console.log(`[Legal/Sales Bot] Scanning B2B Master Service Agreements for impending expiration...`);
        
        // Simulating DB query
        await new Promise(res => setTimeout(res, 800));

        const expirationThresholdDays = 90;
        const now = new Date();

        // Mapped mock data
        const activeContracts = [
            { id: 'MSA_1', facility: 'Trinity Health System', expires: new Date(now.getTime() + 14 * 24 * 60 * 60 * 1000), rep: 'Elena Rostova', status: 'CRITICAL', value: '$2.4M' }, // 14 days
            { id: 'MSA_2', facility: 'Downtown Cardiology', expires: new Date(now.getTime() + 85 * 24 * 60 * 60 * 1000), rep: 'Marcus Cole', status: 'WARNING', value: '$850K' }, // 85 days
            { id: 'MSA_3', facility: 'St. Jude Rehab', expires: new Date(now.getTime() + 210 * 24 * 60 * 60 * 1000), rep: 'Sarah Jenkins', status: 'HEALTHY', value: '$1.1M' } // 210 days
        ];

        let alertsSent = 0;

        for (const contract of activeContracts) {
            const daysUntilExpiration = Math.floor((contract.expires.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));

            if (daysUntilExpiration <= expirationThresholdDays) {
                console.log(`\n⚠️ [RENEWAL ALERT] Contract ${contract.id} (${contract.facility}) expires in ${daysUntilExpiration} days!`);
                console.log(`- Annual Value At Risk: ${contract.value}`);
                console.log(`- Drafting urgent email to Account Exec (${contract.rep}) & CMO...`);
                await this.sendWarningEmail(contract);
                alertsSent++;
            }
        }

        console.log(`\n[Legal/Sales Bot] Scan complete. ${alertsSent} renewal alerts dispatched to the sales team.\n`);
    }

    private static async sendWarningEmail(contract: any) {
        // Sleep to mock network request to Sendgrid/Hubspot
        await new Promise(res => setTimeout(res, 400));
        console.log(`[SendGrid Proxy] -> Email Sent to ${contract.rep}: "ACTION REQUIRED: Initiate Renewal for ${contract.facility} immediately."`);
    }
}

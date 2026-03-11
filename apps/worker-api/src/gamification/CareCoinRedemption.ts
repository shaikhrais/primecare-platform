/**
 * Epic 42: Redeemable 'Care Coins'
 * 
 * Simulated API handler processing the Redemption of internal gamification tokens
 * ("Care Coins") in exchange for real-world monetary value via integrated
 * third-party vendor APIs like Tremendous.
 */

interface RedemptionRequest {
    workerId: string;
    coinAmount: number;
    rewardType: 'STARBUCKS_10' | 'AMAZON_25' | 'UBER_50';
}

export class CareCoinRedemption {

    private static VENDOR_COST_MAP: Record<string, number> = {
        'STARBUCKS_10': 1000,
        'AMAZON_25': 2500,
        'UBER_50': 5000
    };

    /**
     * Mocks fetching the current coin balance of a worker from the DB.
     */
    private static async getWorkerWalletBalance(prisma: any, workerId: string): Promise<number> {
        const profile = await prisma.gamificationProfile.findUnique({
            where: { userId: workerId }
        });
        return profile?.careCoins || 0;
    }

    /**
     * Mocks an external API call to Tremendous or Tango Card to generate a gift card link.
     */
    private static async invokeVendorAPI(rewardType: string, workerEmail: string): Promise<string> {
        console.log(`[Tremendous API] Generating ${rewardType} gift link for ${workerEmail}...`);
        await new Promise(resolve => setTimeout(resolve, 800)); // Latency mock
        return `https://reward.vendor.mock/redeem/${Math.random().toString(36).substring(7)}`;
    }

    /**
     * Process the full gamification redemption transaction.
     */
    static async processRedemption(prisma: any, request: RedemptionRequest, workerEmail: string): Promise<{ success: boolean; link?: string; message?: string }> {
        console.log(`[CareCoin Bank] Processing redemption request for ${request.workerId}...`);

        const requiredCoins = this.VENDOR_COST_MAP[request.rewardType];
        if (!requiredCoins) {
            return { success: false, message: 'Invalid Reward Type.' };
        }

        const currentBalance = await this.getWorkerWalletBalance(prisma, request.workerId);

        if (currentBalance < requiredCoins) {
            console.warn(`[CareCoin Bank] Insufficient Funds. Worker has ${currentBalance}, needs ${requiredCoins}.`);
            return { success: false, message: 'Insufficient Care Coins.' };
        }

        // Simulating wrapping this in a SQL Transaction (deduct coins, log redemption)
        console.log(`[CareCoin Bank] Abstracting ${requiredCoins} coins from ${request.workerId}'s wallet. New Balance: ${currentBalance - requiredCoins}`);

        try {
            const rewardLink = await this.invokeVendorAPI(request.rewardType, workerEmail);
            console.log(`[CareCoin Bank] Redemption Successful! Link generated: ${rewardLink}`);

            // Deduct from Gamification Profile
            await prisma.gamificationProfile.update({
                where: { userId: request.workerId },
                data: { careCoins: { decrement: requiredCoins } }
            });

            return { success: true, link: rewardLink };
        } catch (e) {
            console.error(`[CareCoin Bank] Vendor API failure. Rolling back coin deduction.`, e);
            return { success: false, message: 'Vendor API Offline. Coins refunded.' };
        }
    }
}

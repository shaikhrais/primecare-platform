// Governance - Category: service | Purpose: Creates a Stripe Connect Express account for a new Tenant.
import Stripe from 'stripe';

export class StripeService {
    private stripe: Stripe;

    constructor(apiKey: string) {
        this.stripe = new Stripe(apiKey, {
            apiVersion: '2023-10-16' as any,
        });
    }

    /**
     * Creates a Stripe Connect Express account for a new Tenant.
     */
    async createConnectAccount(email: string, businessName: string) {
        return await this.stripe.accounts.create({
            type: 'express',
            email,
            business_profile: {
                name: businessName,
            },
            capabilities: {
                card_payments: { requested: true },
                transfers: { requested: true },
            },
        });
    }

    /**
     * Generates an onboarding link for the Tenant's Stripe account.
     */
    async createAccountLink(accountId: string, refreshUrl: string, returnUrl: string) {
        return await this.stripe.accountLinks.create({
            account: accountId,
            refresh_url: refreshUrl,
            return_url: returnUrl,
            type: 'account_onboarding',
        });
    }

    /**
     * Calculates the platform fee for a given amount.
     * Default: 5%
     */
    calculatePlatformFee(amount: number, percentage = 0.05): number {
        return Math.round(amount * percentage);
    }
}

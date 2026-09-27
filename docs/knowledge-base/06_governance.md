# Platform Governance: Ruling the Ecosystem

When you transition from a linear software app to a Fractal SaaS, you stop being a product manager and start being a digital governor. As a Super Admin at HQ, your role is to maintain the integrity, security, and financial viability of the entire interconnected network. 

You are the referee, not a player.

## The Threat Landscape
In traditional models, if an agency goes rogue and starts dispatching nurses with expired licenses, they eventually get sued, go bankrupt, and fade away. 

In a unified payment ecosystem powered by Stripe Connect, a rogue Child Agency that triggers massive hospital chargebacks or fraud can threaten the reputation of the Master Franchise, and ultimately, the standing of the Platform HQ merchant rails. The ecosystem must defend itself autonomously.

## The Risk Surveillance Engine
Because it is physically impossible for HQ to manually audit thousands of Child Agencies, we built the Risk Surveillance Engine.

This backend worker autonomously and perpetually monitors all Tenants (Master and Child) globally. It calculates real-time risk scores based on programmatic telemetry:
*   **Compliance Breaches:** High rates of attempting to dispatch staff whose credentials expired in the last 24 hours.
*   **Financial Instability:** Large numbers of disputed Stripe transactions or insufficient float balances for Instant Settlements.
*   **Operational Failure:** Abnormal shift cancellation rates, or providers abandoning shifts mid-care.

## Automated Enforcement Actions
When a Tenant breaches defined risk thresholds, the system does not wait for human intervention. HQ algorithms execute automated defensive actions:
1.  **Throttling:** The tenant's ability to broadcast new shifts to the Auto-Pilot is paused. They cannot take on new risk.
2.  **Financial Freezing:** Stripe Connect distributions are halted. Funds are held in escrow until an audit is resolved.
3.  **Quarantine:** The tenant is physically sandboxed and disconnected from the Master Franchise's Private Marketplace to prevent the contagion from spreading to compliant agencies.
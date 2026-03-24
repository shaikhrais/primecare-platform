# Platform Governance & Super Admin Controls

As a Super Admin at HQ, your primary role shifts from "feature building" to "ecosystem governance". You are the referee, not the player.

## The Risk Surveillance Engine
Because HQ carries the reputational risk of the payment rails, you must oversee global metrics. 

The system autonomously monitors all Tenants (Master and Child) for violations, such as:
*   High rates of dispatching staff with expired credentials.
*   Large numbers of disputed Stripe transactions.
*   Abnormal shift cancellation rates.

## Enforcement Actions
If a Tenant breaches compliance thresholds, HQ can:
1.  **Throttle Operations:** Disable their Auto-Pilot matchmaking.
2.  **Freeze Payouts:** Pause Stripe Connect distributions.
3.  **Quarantine:** Isolate the tenant entirely from the network until an audit is passed.

---

## Visual Reference & Application Route

**UI Home Link:** [Access the Super Admin Command Center Here](/admin)

_The global view of platform metrics and health from the top of the fractal._

![Super Admin Command Center Screenshot](https://placehold.co/800x400/F3F4F6/1E293B?text=Platform+Governance+Home)

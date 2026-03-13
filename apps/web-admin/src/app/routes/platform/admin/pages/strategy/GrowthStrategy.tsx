import React from 'react';

const GrowthStrategy: React.FC = () => {
    return (
        <div data-cy="page.container" style={{ padding: '24px', maxWidth: '1000px', margin: '0 auto' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: '#F0F9FF', padding: '16px', borderRadius: '12px', fontSize: '32px' }}>
                    📈
                </div>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: '#111827' }}>Franchise Growth Model</h1>
                    <p style={{ color: '#6B7280', margin: '4px 0 0 0' }}>The Fractal SaaS Architecture: Empowering Master Tenants to scale their own networks.</p>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '32px' }}>

                {/* Intro */}
                <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E5E7EB', boxShadow: '0 1px 2px rgba(0,0,0,0.05)' }}>
                    <p style={{ fontSize: '16px', lineHeight: '1.6', color: '#374151', margin: 0 }}>
                        The way we have built the system in Phase 10 (The Fractal SaaS) completely shifts the burden of growth off of the Platform HQ and onto <strong>Master Tenants (Franchisees)</strong>. Here is exactly how the business hierarchy allows for exponential scaling:
                    </p>
                </div>

                {/* The 4 Levels */}
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '24px' }}>

                    {/* Level 1 */}
                    <div style={{ backgroundColor: '#F8FAFC', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0', position: 'relative' }}>
                        <div style={{ position: 'absolute', top: '-16px', left: '24px', backgroundColor: '#0F172A', color: 'white', padding: '4px 12px', borderRadius: '16px', fontSize: '12px', fontWeight: 'bold', textTransform: 'uppercase', letterSpacing: '1px' }}>
                            Level 1
                        </div>
                        <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#0F172A', marginTop: '8px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            🏛️ The Platform (HQ)
                        </h2>
                        <p style={{ fontSize: '14px', color: '#475569', lineHeight: '1.5' }}>
                            <strong>You provide the underlying infrastructure.</strong> You do not employ the service providers, and you do not operate the local territories. You are the technology provider making recurring revenue through software subscription fees and transaction micro-fees (via Stripe Connect).
                        </p>
                    </div>

                    {/* Level 2 */}
                    <div style={{ backgroundColor: '#F0FDF4', borderRadius: '12px', padding: '24px', border: '1px solid #BBF7D0', position: 'relative' }}>
                        <div style={{ position: 'absolute', top: '-16px', left: '24px', backgroundColor: '#166534', color: 'white', padding: '4px 12px', borderRadius: '16px', fontSize: '12px', fontWeight: 'bold', textTransform: 'uppercase', letterSpacing: '1px' }}>
                            Level 2
                        </div>
                        <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#14532D', marginTop: '8px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            👑 The Root Tenant
                        </h2>
                        <ul style={{ fontSize: '14px', color: '#166534', paddingLeft: '20px', margin: '12px 0 0 0', lineHeight: '1.5', display: 'flex', flexDirection: 'column', gap: '8px' }}>
                            <li><strong>White-Labeling:</strong> They customize brand, colors, and domains to act as the "Master Agency" for a large region.</li>
                            <li><strong>Contracting:</strong> They use the platform to onboard and directly contract with local Service Providers. The platform automates background checks.</li>
                        </ul>
                    </div>

                    {/* Level 3 */}
                    <div style={{ backgroundColor: '#EFF6FF', borderRadius: '12px', padding: '24px', border: '1px solid #BFDBFE', position: 'relative' }}>
                        <div style={{ position: 'absolute', top: '-16px', left: '24px', backgroundColor: '#1E40AF', color: 'white', padding: '4px 12px', borderRadius: '16px', fontSize: '12px', fontWeight: 'bold', textTransform: 'uppercase', letterSpacing: '1px' }}>
                            Level 3
                        </div>
                        <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#1E3A8A', marginTop: '8px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            🏢 Child Tenants
                        </h2>
                        <p style={{ fontSize: '14px', color: '#1E40AF', lineHeight: '1.5', margin: '12px 0 0 0' }}>
                            <strong>Sub-Franchises & Local Branches:</strong> Because of Recursive Multi-Tenancy, Master Franchisees can use their <em>Reseller Hub</em> to click "Spawn Sub-Tenant" and create an isolated environment for local entrepreneurs. They act as software resellers, and HQ takes a seamless cut of the fees in the background.
                        </p>
                    </div>

                    {/* Level 4 */}
                    <div style={{ backgroundColor: '#FEF2F2', borderRadius: '12px', padding: '24px', border: '1px solid #FECACA', position: 'relative' }}>
                        <div style={{ position: 'absolute', top: '-16px', left: '24px', backgroundColor: '#991B1B', color: 'white', padding: '4px 12px', borderRadius: '16px', fontSize: '12px', fontWeight: 'bold', textTransform: 'uppercase', letterSpacing: '1px' }}>
                            Level 4
                        </div>
                        <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#7F1D1D', marginTop: '8px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            👩‍⚕️ Service Providers
                        </h2>
                        <ul style={{ fontSize: '14px', color: '#991B1B', paddingLeft: '20px', margin: '12px 0 0 0', lineHeight: '1.5', display: 'flex', flexDirection: 'column', gap: '8px' }}>
                            <li>Employed by Franchisees, picking up shifts via Auto-Pilot.</li>
                            <li><strong>Instant Settlements:</strong> When shifts complete (Check-out), funds route automatically: Patient → Franchisee (keeps cut) → Provider (settled via Stripe Connect).</li>
                        </ul>
                    </div>
                </div>

                {/* Conclusion / GTM Strategy */}
                <div style={{ backgroundColor: '#FFFBEB', borderRadius: '12px', padding: '32px', border: '1px solid #FDE68A', display: 'flex', gap: '24px', alignItems: 'flex-start' }}>
                    <div style={{ fontSize: '40px' }}>🚀</div>
                    <div>
                        <h3 style={{ fontSize: '20px', fontWeight: '700', color: '#92400E', margin: '0 0 12px 0' }}>Go-To-Market Execution</h3>
                        <p style={{ fontSize: '16px', color: '#B45309', margin: '0 0 16px 0', lineHeight: '1.6' }}>
                            Instead of trying to sell software to 1,000 tiny local agencies (which is slow and expensive), you only need to sell to <strong>5 large Master Distributors</strong>.
                        </p>
                        <p style={{ fontSize: '16px', color: '#B45309', margin: 0, lineHeight: '1.6' }}>
                            Provide those 5 distributors the "Reseller" tools we just built. They naturally recruit the 1,000 sub-agencies because it's profitable for them. The platform captures a fraction of a percent off every visit, background check, and instant settlement occurring anywhere within the fractal hierarchy.
                        </p>
                    </div>
                </div>

            </div>
        </div>
    );
};

export default GrowthStrategy;

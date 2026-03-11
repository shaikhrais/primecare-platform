import React from 'react';

import { SocialMediaCredentialVault } from '../../platform/marketing/pages/syndication/SocialMediaCredentialVault';
import { MarketingRevenueAttribution } from '../../platform/marketing/pages/retention/MarketingRevenueAttribution';
import { EventRegistrationBuilder } from '../../platform/marketing/pages/retention/EventRegistrationBuilder';
import { ChurnRiskPredictor } from '../../platform/marketing/pages/retention/ChurnRiskPredictor';
import { NewsletterSubscriberDb } from '../../platform/marketing/pages/retention/NewsletterSubscriberDb';
import { PromotionalDiscountEngine } from '../../platform/marketing/pages/retention/PromotionalDiscountEngine';
import { DripEmailSequenceBuilder } from '../../platform/marketing/pages/retention/DripEmailSequenceBuilder';

import { NotificationProvider } from '../../../../shared/context/NotificationContext';
import { NotificationCenterProvider } from '../../../../shared/context/NotificationCenterContext';

const MarketingShowcase = () => {
    return (
        <NotificationProvider>
            <NotificationCenterProvider>
                <div style={{ padding: '40px', backgroundColor: '#F1F5F9', minHeight: '100vh' }}>
                    <h1 style={{ fontSize: '2.5rem', fontWeight: 900, color: '#0F172A', marginBottom: '8px' }}>CMO Dashboard Showcase</h1>
                    <p style={{ fontSize: '1.2rem', color: '#64748B', marginBottom: '40px' }}>Viewing the newly built Theme 5 & Bonus Theme components.</p>
                    
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '40px' }}>
                        <section>
                            <h2 style={{ color: '#334155', borderBottom: '2px solid #CBD5E1', paddingBottom: '8px' }}>Bonus Epic 51: Social Media Hub</h2>
                            <SocialMediaCredentialVault />
                        </section>

                        <section>
                            <h2 style={{ color: '#334155', borderBottom: '2px solid #CBD5E1', paddingBottom: '8px' }}>Epic 50: The Holy Grail (MRA)</h2>
                            <MarketingRevenueAttribution />
                        </section>

                        <section>
                            <h2 style={{ color: '#334155', borderBottom: '2px solid #CBD5E1', paddingBottom: '8px' }}>Epic 41: Drip Email Sequence Builder</h2>
                            <DripEmailSequenceBuilder />
                        </section>

                        <section>
                            <h2 style={{ color: '#334155', borderBottom: '2px solid #CBD5E1', paddingBottom: '8px' }}>Epic 44: Churn Risk Predictor</h2>
                            <ChurnRiskPredictor />
                        </section>

                        <section>
                            <h2 style={{ color: '#334155', borderBottom: '2px solid #CBD5E1', paddingBottom: '8px' }}>Epic 46: Newsletter DB</h2>
                            <NewsletterSubscriberDb />
                        </section>

                        <section>
                            <h2 style={{ color: '#334155', borderBottom: '2px solid #CBD5E1', paddingBottom: '8px' }}>Epic 47: Event Builder</h2>
                            <EventRegistrationBuilder />
                        </section>

                        <section>
                            <h2 style={{ color: '#334155', borderBottom: '2px solid #CBD5E1', paddingBottom: '8px' }}>Epic 49: Promo Engine</h2>
                            <PromotionalDiscountEngine />
                        </section>

                    </div>
                </div>
            </NotificationCenterProvider>
        </NotificationProvider>
    );
};

export default MarketingShowcase;

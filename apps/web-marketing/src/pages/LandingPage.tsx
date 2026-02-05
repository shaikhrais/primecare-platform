import React from 'react';
import { Helmet } from 'react-helmet-async';
import { MarketingRegistry } from 'prime-care-shared';

// Modular Landing Page Components
import {
    HeroSection,
    StatsSection,
    ServicesSection,
    WhyChooseUsSection,
    TestimonialsSection,
    MissionSection,
    CTASection,
} from '../components/landing';

const { ContentRegistry } = MarketingRegistry;

export default function LandingPage() {
    // Set promo end date to 7 days from now
    const promoEndDate = new Date();
    promoEndDate.setDate(promoEndDate.getDate() + 7);

    return (
        <div style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }}>
            <Helmet>
                <title>{ContentRegistry.APP.NAME} - Compassionate Healthcare at Home</title>
                <meta name="description" content="Professional home care, foot care nursing, senior support, and healthcare education services in Ontario." />
            </Helmet>

            {/* Hero Section with Countdown Timer */}
            <HeroSection promoEndDate={promoEndDate} />

            {/* Statistics Section */}
            <StatsSection />

            {/* Services Overview */}
            <ServicesSection />

            {/* Why Choose Us */}
            <WhyChooseUsSection />

            {/* Testimonials */}
            <TestimonialsSection />

            {/* Mission Statement */}
            <MissionSection />

            {/* Call to Action */}
            <CTASection />
        </div>
    );
}

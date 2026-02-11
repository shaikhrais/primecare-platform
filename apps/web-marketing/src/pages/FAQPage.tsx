import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function FAQPage() {
    const [openIndex, setOpenIndex] = useState<number | null>(null);

    const faqs = [
        {
            category: 'Senior Care', items: [
                { q: 'What services do PSWs provide?', a: 'Personal Support Workers help with daily activities including bathing, dressing, meal preparation, medication reminders, mobility assistance, and companionship.' },
                { q: 'How quickly can you start care?', a: 'We can often start within 24-48 hours for urgent cases. For non-urgent needs, we schedule an assessment within a week.' },
                { q: 'Do you provide overnight care?', a: 'Yes, we offer 24-hour care including overnight shifts. Caregivers can provide bedside support and assist with nighttime needs.' },
            ]
        },
        {
            category: 'Foot Care', items: [
                { q: 'What does diabetic foot care include?', a: 'Our foot care includes nail trimming, callus and corn removal, treatment of ingrown nails, fungal nail care, and diabetic foot assessment.' },
                { q: 'Do you come to my home?', a: 'Yes! Our foot care nurses travel to homes, retirement facilities, and long-term care homes across Toronto and GTA.' },
                { q: 'How much does foot care cost?', a: 'Initial assessments start at $75. Regular visits are $60-80 depending on services needed. Contact us for facility pricing.' },
            ]
        },
        {
            category: 'Education', items: [
                { q: 'Who can enroll in the Foot Care Nurse program?', a: 'Registered Nurses (RN) and Registered Practical Nurses (RPN) with current CNO registration can enroll.' },
                { q: 'How long is the certificate program?', a: 'The Basic to Advanced Diabetic Foot Care program is 40 hours of theory plus clinical placement hours.' },
                { q: 'Do you offer clinical placements?', a: 'Yes, we arrange placements at Long Term Care and Retirement Homes across North York, Scarborough, and Markham.' },
            ]
        },
        {
            category: 'Billing & Insurance', items: [
                { q: 'Do you accept insurance?', a: 'Many services are covered by extended health benefits. We provide detailed receipts for insurance claims.' },
                { q: 'What payment methods do you accept?', a: 'We accept credit cards, debit, e-transfer, and cheques. Payment plans available for ongoing care.' },
            ]
        },
    ];

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif' }} data-cy="faq-page-container">
            <Helmet>
                <title>Frequently Asked Questions | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <header style={{ background: 'linear-gradient(135deg, rgba(0,77,64,0.9), rgba(0,105,92,0.85))', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>Frequently Asked Questions</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95 }}>Find answers to common questions about our services</p>
                </AnimatedSection>
            </header>

            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                    {faqs.map((category, catIdx) => (
                        <div key={catIdx} style={{ marginBottom: '3rem' }}>
                            <h2 style={{ fontSize: '1.5rem', color: '#00897b', marginBottom: '1.5rem', borderBottom: '2px solid #00897b', paddingBottom: '0.5rem' }}>
                                {category.category}
                            </h2>
                            {category.items.map((faq, i) => {
                                const idx = catIdx * 100 + i;
                                const isOpen = openIndex === idx;
                                return (
                                    <div key={i} style={{ marginBottom: '1rem', border: '1px solid #eee', borderRadius: '8px', overflow: 'hidden' }}>
                                        <button
                                            data-cy={`faq-toggle-${idx}`}
                                            onClick={() => setOpenIndex(isOpen ? null : idx)}
                                            style={{ width: '100%', padding: '1rem 1.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center', background: isOpen ? '#f8f9fa' : 'white', border: 'none', cursor: 'pointer', textAlign: 'left', fontSize: '1rem', fontWeight: 'bold', color: '#333' }}
                                        >
                                            {faq.q}
                                            <span style={{ transform: isOpen ? 'rotate(180deg)' : 'none', transition: 'transform 0.2s' }}>▼</span>
                                        </button>
                                        {isOpen && (
                                            <div style={{ padding: '1rem 1.5rem', backgroundColor: '#f8f9fa', color: '#666', lineHeight: '1.6' }}>{faq.a}</div>
                                        )}
                                    </div>
                                );
                            })}
                        </div>
                    ))}
                </div>
            </section>

            <section style={{ padding: '4rem 2rem', backgroundColor: '#f8f9fa', textAlign: 'center' }}>
                <h2 style={{ fontSize: '1.5rem', marginBottom: '1rem', color: '#333' }}>Still have questions?</h2>
                <p style={{ color: '#666', marginBottom: '2rem' }}>Contact us and we'll be happy to help</p>
                <Link to={RouteRegistry.CONTACT} data-cy="btn-faq-contact" style={{ padding: '1rem 2rem', backgroundColor: '#00897b', color: 'white', textDecoration: 'none', borderRadius: '50px', fontWeight: 'bold' }}>Contact Us</Link>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}

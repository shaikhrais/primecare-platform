// ================================================================
// PAGE IDENTITY: H8 � Knowledge Base
// Registry ID:   page.admin.knowledge-base
// Type:          Hub
// Owner:         admin
// ================================================================
import React from 'react';
import { Link } from 'react-router-dom';

const outline = [
    {
        title: "The Executive Overview",
        icon: "🌐",
        articles: [
            { title: "The PrimeCare Vision & Mission", slug: "01-vision-mission" },
            { title: "Understanding the Fractal SaaS Architecture", slug: "02-fractal-saas" },
            { title: "Value Proposition by Stakeholder Level", slug: "03-value-proposition" }
        ]
    },
    {
        title: "Level 1: Platform Command (HQ / You)",
        icon: "🏛️",
        articles: [
            { title: "The Software Provider Business Model", slug: "04-hq-business-model" },
            { title: "Revenue Streams: Subscriptions & Transaction Micro-Fees", slug: "05-revenue-streams" },
            { title: "Platform Governance & Super Admin Controls", slug: "06-governance" }
        ]
    },
    {
        title: "Level 2: Master Franchisees (Root Tenants)",
        icon: "👑",
        articles: [
            { title: "The Master Agency Profile", slug: "07-master-franchise" },
            { title: "White-Labeling & Brand Customization", slug: "08-white-labeling" },
            { title: "Territory Acquisition & Management", slug: "09-territory-management" },
            { title: "The Reseller Hub: Spawning Child Agencies", slug: "10-reseller-hub" }
        ]
    },
    {
        title: "Level 3: Local Branches (Child Tenants)",
        icon: "🏢",
        articles: [
            { title: "The Local Entrepreneur / Sub-Franchise Profile", slug: "11-child-tenant" },
            { title: "Operating within the Master Network", slug: "12-child-operations" },
            { title: "Accessing the Private Resource Marketplace", slug: "13-private-marketplace" }
        ]
    },
    {
        title: "Level 4: The Workforce & Care Delivery",
        icon: "👩‍⚕️",
        articles: [
            { title: "Service Provider (Nurse/PSW) Onboarding & Compliance", slug: "14-provider-onboarding" },
            { title: "Clinical Auto-Pilot: Algorithmic Shift Matching", slug: "15-clinical-autopilot" }
        ]
    },
    {
        title: "Financial Architecture & Settlements",
        icon: "💸",
        articles: [
            { title: "Stripe Connect Integration Overview", slug: "16-stripe-connect" },
            { title: "The 'Instant Settlements' Advantage", slug: "17-instant-settlements" },
            { title: "Automated Fee Routing & Multi-Party Splits", slug: "18-fee-routing" }
        ]
    },
    {
        title: "Go-To-Market (GTM) Strategy",
        icon: "🚀",
        articles: [
            { title: "Targeting the 'Top 5' Distributors vs. 1,000 Small Agencies", slug: "19-gtm-distributors" },
            { title: "Network Effects: How Franchisees Drive Your Growth", slug: "20-network-effects" }
        ]
    },
    {
        title: "Risk, Compliance & Security",
        icon: "🛡️",
        articles: [
            { title: "Automated Risk Surveillance Engine", slug: "21-risk-surveillance" },
            { title: "Interoperability (FHIR/HL7) & Standards", slug: "22-interoperability" },
            { title: "Data Sovereignty & W3C Decentralized Identity", slug: "23-data-sovereignty" }
        ]
    },
    {
        title: "Role-Based Deep Dives & Gap Analysis",
        icon: "🎭",
        articles: [
            { title: "Super Admin (Platform HQ) Playbook", slug: "role-super-admin" },
            { title: "Admin (Master Franchise) Playbook", slug: "role-admin" },
            { title: "Regional Manager Playbook", slug: "role-regional-manager" },
            { title: "Operations Manager Playbook", slug: "role-operations-manager" },
            { title: "HR Manager Playbook", slug: "role-hr-manager" },
            { title: "Clinical Manager Playbook", slug: "role-clinical-manager" },
            { title: "Finance Manager Playbook", slug: "role-finance-manager" },
            { title: "Marketing Manager Playbook", slug: "role-marketing-manager" },
            { title: "Recruiting Manager Playbook", slug: "role-recruiting-manager" },
            { title: "Manager (General) Playbook", slug: "role-manager" },
            { title: "Coordinator Playbook", slug: "role-coordinator" },
            { title: "Staff Playbook", slug: "role-staff" },
            { title: "Finance Clerk Playbook", slug: "role-finance" },
            { title: "Client Playbook", slug: "role-client" },
            { title: "Registered Nurse (RN) Playbook", slug: "role-rn" },
            { title: "Personal Support Worker (PSW) Playbook", slug: "role-psw" },
            { title: "Registered Massage Therapist (RMT) Playbook", slug: "role-rmt" },
            { title: "Registered Physiotherapist (RPT) Playbook", slug: "role-rpt" },
            { title: "Registered Community Health Worker (RCH) Playbook", slug: "role-rch" }
        ]
    }
];

const KnowledgeBaseIndex: React.FC = () => {
    return (
        <div data-cy="page.container" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: '#F3E8FF', padding: '16px', borderRadius: '12px', fontSize: '32px' }}>
                    📚
                </div>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: '#111827' }}>Business Knowledge Base</h1>
                    <p style={{ color: '#6B7280', margin: '4px 0 0 0' }}>The comprehensive guide to the PrimeCare Fractal SaaS architecture and growth strategy.</p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '24px' }}>
                {outline.map((section, idx) => (
                    <div key={idx} style={{ backgroundColor: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E5E7EB', boxShadow: '0 1px 2px rgba(0,0,0,0.05)' }}>
                        <h2 style={{ fontSize: '18px', fontWeight: '700', color: '#111827', margin: '0 0 16px 0', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <span>{section.icon}</span> {section.title}
                        </h2>
                        <ul style={{ listStyleType: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '12px' }}>
                            {section.articles.map(article => (
                                <li key={article.slug}>
                                    <Link
                                        to={`/admin/knowledge-base/${article.slug}`}
                                        style={{
                                            textDecoration: 'none',
                                            color: '#4F46E5',
                                            fontSize: '14px',
                                            fontWeight: '500',
                                            display: 'flex',
                                            alignItems: 'center',
                                            gap: '8px',
                                            padding: '8px 12px',
                                            backgroundColor: '#F5F3FF',
                                            borderRadius: '6px',
                                            transition: 'background-color 0.2s'
                                        }}
                                        onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#EDE9FE'}
                                        onMouseOut={(e) => e.currentTarget.style.backgroundColor = '#F5F3FF'}
                                    >
                                        📄 {article.title}
                                    </Link>
                                </li>
                            ))}
                        </ul>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default KnowledgeBaseIndex;

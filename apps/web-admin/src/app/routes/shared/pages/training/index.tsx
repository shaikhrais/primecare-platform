import { useAuth } from '@/shared/context/AuthContext';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry } = AdminRegistry;

interface TrainingModule {
    title: string;
    description: string;
    icon: string;
    steps: string[];
}

const roleTrainingData: Record<string, TrainingModule[]> = {
    admin: [
        {
            title: "Managing Platform Users",
            description: "Learn how to provision new staff, manage credentials, and audit access.",
            icon: "👥",
            steps: ["Navigate to User Management", "Click 'Invite User'", "Select Role & Permissions", "Monitor activation status"]
        },
        {
            title: "Financial Settlements",
            description: "Oversee automated payouts and transaction micro-fees.",
            icon: "💰",
            steps: ["View Earnings Dashboard", "Check payout schedules", "Audit Stripe Connect status"]
        }
    ],
    psw: [
        {
            title: "Managing Your Schedule",
            description: "How to accept shifts and set your availability.",
            icon: "📅",
            steps: ["Go to 'Open Shifts'", "Review shift details & location", "Click 'Accept' to join", "Update availability in Profile"]
        },
        {
            title: "Visit Completion",
            description: "Using the system to clock in/out and log notes.",
            icon: "⏱️",
            steps: ["Open active visit", "Complete check-in protocol", "Log clinical notes", "Clock-out to trigger settlement"]
        }
    ],
    client: [
        {
            title: "Booking Care Visits",
            description: "How to request a nurse or PSW for your family.",
            icon: "🏡",
            steps: ["Click 'Request Booking'", "Select service type & date", "Choose preferred provider", "Confirm & Pay"]
        }
    ],
    manager: [
        {
            title: "Operational Oversight",
            description: "Monitor branch health and staff performance.",
            icon: "📈",
            steps: ["Review Daily Portfolio", "Approve pending timesheets", "Address critical incidents"]
        }
    ]
};

const UserTrainingPage: React.FC = () => {
    const { t } = useTranslation();
    const { user } = useAuth();
    const role = user?.activeRole || 'client';
    const modules = roleTrainingData[role] || roleTrainingData['client'];

    return (
        <div style={{ padding: '40px', maxWidth: '1000px', margin: '0 auto' }}>
            <header style={{ marginBottom: '48px', textAlign: 'center' }}>
                <h1 style={{ fontSize: '36px', fontWeight: '900', color: '#111827', marginBottom: '16px', letterSpacing: '-0.025em' }}>
                    {t(ContentRegistry.LEARN.TITLE)}
                </h1>
                <p style={{ fontSize: '18px', color: '#6B7280', maxWidth: '600px', margin: '0 auto' }}>
                    {t(ContentRegistry.LEARN.SUBTITLE)} (<strong>{role.toUpperCase()}</strong> perspective)
                </p>
            </header>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr', gap: '32px' }}>
                {modules.map((module, idx) => (
                    <div
                        key={idx}
                        style={{
                            backgroundColor: 'white',
                            borderRadius: '24px',
                            padding: '32px',
                            border: '1px solid #E5E7EB',
                            boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.05)',
                            display: 'flex',
                            gap: '24px'
                        }}
                    >
                        <div style={{
                            fontSize: '48px',
                            backgroundColor: '#F3F4F6',
                            width: '100px',
                            height: '100px',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            borderRadius: '20px'
                        }}>
                            {module.icon}
                        </div>
                        <div style={{ flex: 1 }}>
                            <h2 data-cy="h2-shared.index-0" style={{ fontSize: '22px', fontWeight: '800', color: '#111827', marginBottom: '8px' }}>{module.title}</h2>
                            <p style={{ color: '#4B5563', marginBottom: '24px', lineHeight: '1.6' }}>{module.description}</p>

                            <div style={{ backgroundColor: '#F9FAFB', borderRadius: '16px', padding: '24px' }}>
                                <h3 data-cy="h3-shared.index-0" style={{ fontSize: '14px', fontWeight: '700', textTransform: 'uppercase', letterSpacing: '0.05em', color: '#6B7280', marginBottom: '16px' }}>
                                    {t(ContentRegistry.LEARN.WHAT_YOU_CAN_DO)}
                                </h3>
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                                    {module.steps.map((step, sIdx) => (
                                        <div key={sIdx} style={{ display: 'flex', alignItems: 'center', gap: '12px', fontSize: '15px', color: '#374151' }}>
                                            <span style={{
                                                width: '24px',
                                                height: '24px',
                                                borderRadius: '50%',
                                                backgroundColor: '#004d40',
                                                color: 'white',
                                                display: 'flex',
                                                alignItems: 'center',
                                                justifyContent: 'center',
                                                fontSize: '12px',
                                                fontWeight: 'bold'
                                            }}>
                                                {sIdx + 1}
                                            </span>
                                            {step}
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>
                ))}
            </div>

            <footer style={{ marginTop: '64px', padding: '32px', backgroundColor: '#F0FDFA', borderRadius: '24px', textAlign: 'center', border: '1px solid #CCFBF1' }}>
                <h3 data-cy="h3-shared.index-1" style={{ color: '#134E4A', fontSize: '20px', fontWeight: '800', marginBottom: '8px' }}>Need more help?</h3>
                <p style={{ color: '#115E59', marginBottom: '20px' }}>Our premium support team is available 24/7 to assist with complex cases.</p>
                <button data-cy="btn-shared.index-0" style={{
                    backgroundColor: '#004d40',
                    color: 'white',
                    padding: '12px 32px',
                    borderRadius: '12px',
                    border: 'none',
                    fontWeight: '700',
                    cursor: 'pointer',
                    boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
                }}>
                    Contact Support
                </button>
            </footer>
        </div>
    );
};

export default UserTrainingPage;

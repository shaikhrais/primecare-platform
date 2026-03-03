import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface ImplementationAudit {
    pageCount: number;
    files: Array<{ name: string; path: string; purpose: string; route: string }>;
    apis: Array<{ endpoint: string; method: string; description: string }>;
}

const auditData: Record<string, ImplementationAudit> = {
    admin: {
        pageCount: 15,
        files: [
            { name: "UserList.tsx", path: "routes/platform/admin/pages/users/UserList.tsx", purpose: "Staff/User CRUD & Audit", route: RouteRegistry.ADMIN.USERS },
            { name: "AdminDashboard.tsx", path: "routes/platform/admin/pages/dashboard/index.tsx", purpose: "Platform KPI & Health", route: RouteRegistry.ADMIN.DASHBOARD },
            { name: "TemplateEditor.tsx", path: "routes/platform/admin/pages/template-editor/index.tsx", purpose: "Communication Branding", route: RouteRegistry.ADMIN.TEMPLATE_EDITOR }
        ],
        apis: [
            { endpoint: "/v1/admin/users", method: "GET/POST", description: "Manage platform-wide users" },
            { endpoint: "/v1/admin/stats", method: "GET", description: "Fetch platform health metrics" }
        ]
    },
    psw: {
        pageCount: 8,
        files: [
            { name: "PswSchedule.tsx", path: "routes/tenancy/psw/pages/schedule/index.tsx", purpose: "Shift Management", route: RouteRegistry.PSW.SCHEDULE },
            { name: "PswEarnings.tsx", path: "routes/tenancy/psw/pages/earnings/index.tsx", purpose: "Payroll & Payouts", route: RouteRegistry.PSW.EARNINGS }
        ],
        apis: [
            { endpoint: "/v1/psw/shifts", method: "GET", description: "Fetch available and assigned shifts" },
            { endpoint: "/v1/psw/earnings", method: "GET", description: "Retrieve settlement history" }
        ]
    },
    client: {
        pageCount: 6,
        files: [
            { name: "ClientDashboard.tsx", path: "routes/tenancy/client/pages/dashboard/index.tsx", purpose: "Family Care Hub", route: RouteRegistry.CLIENT.DASHBOARD },
            { name: "RequestBooking.tsx", path: "routes/tenancy/client/pages/request-booking/index.tsx", purpose: "Care Intake Flow", route: RouteRegistry.CLIENT.REQUEST_BOOKING }
        ],
        apis: [
            { endpoint: "/v1/client/bookings", method: "POST", description: "Create new care requests" }
        ]
    }
};

const DeveloperKBPage: React.FC = () => {
    const [selectedRole, setSelectedRole] = useState<string>('admin');
    const audit = auditData[selectedRole] || auditData['admin'];

    return (
        <div style={{ padding: '40px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '40px' }}>
                <div>
                    <h1 style={{ fontSize: '32px', fontWeight: '900', color: '#111827', margin: 0 }}>Developer Implementation Audit</h1>
                    <p style={{ color: '#6B7280', marginTop: '8px' }}>Technical reference for role-based features and infrastructure.</p>
                </div>
                <div style={{ display: 'flex', gap: '8px', padding: '6px', backgroundColor: '#F3F4F6', borderRadius: '12px' }}>
                    {Object.keys(auditData).map(role => (
                        <button
                            key={role}
                            onClick={() => setSelectedRole(role)}
                            style={{
                                padding: '8px 16px',
                                borderRadius: '8px',
                                border: 'none',
                                fontWeight: '700',
                                cursor: 'pointer',
                                textTransform: 'uppercase',
                                fontSize: '12px',
                                transition: 'all 0.2s',
                                backgroundColor: selectedRole === role ? 'white' : 'transparent',
                                color: selectedRole === role ? '#111827' : '#6B7280',
                                boxShadow: selectedRole === role ? '0 1px 3px rgba(0,0,0,0.1)' : 'none'
                            }}
                        >
                            {role}
                        </button>
                    ))}
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 300px', gap: '32px' }}>
                <section>
                    <div style={{ backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', overflow: 'hidden' }}>
                        <div style={{ padding: '24px', borderBottom: '1px solid #E5E7EB', backgroundColor: '#F9FAFB' }}>
                            <h2 style={{ fontSize: '18px', fontWeight: '800', margin: 0 }}>Implementation Specs: {selectedRole.toUpperCase()}</h2>
                        </div>
                        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                            <thead>
                                <tr style={{ borderBottom: '1px solid #E5E7EB' }}>
                                    <th style={{ padding: '16px 24px', fontSize: '13px', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase' }}>File / Section</th>
                                    <th style={{ padding: '16px 24px', fontSize: '13px', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase' }}>Route Variable</th>
                                    <th style={{ padding: '16px 24px', fontSize: '13px', fontWeight: '700', color: '#6B7280', textTransform: 'uppercase' }}>Purpose</th>
                                </tr>
                            </thead>
                            <tbody>
                                {audit.files.map((file, idx) => (
                                    <tr key={idx} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                        <td style={{ padding: '20px 24px' }}>
                                            <div style={{ fontWeight: '600', color: '#111827' }}>{file.name}</div>
                                            <div style={{ fontSize: '12px', color: '#9CA3AF', fontFamily: 'monospace', marginTop: '4px' }}>{file.path}</div>
                                        </td>
                                        <td style={{ padding: '20px 24px' }}>
                                            <span style={{ backgroundColor: '#EEF2FF', color: '#4F46E5', padding: '4px 8px', borderRadius: '4px', fontSize: '12px', fontFamily: 'monospace' }}>
                                                {file.route}
                                            </span>
                                        </td>
                                        <td style={{ padding: '20px 24px', color: '#4B5563', fontSize: '14px' }}>{file.purpose}</td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>

                    <div style={{ marginTop: '32px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', overflow: 'hidden' }}>
                        <div style={{ padding: '24px', borderBottom: '1px solid #E5E7EB', backgroundColor: '#F9FAFB' }}>
                            <h2 style={{ fontSize: '18px', fontWeight: '800', margin: 0 }}>API Endpoint Map</h2>
                        </div>
                        <div style={{ padding: '24px' }}>
                            {audit.apis.map((api, idx) => (
                                <div key={idx} style={{ padding: '16px', borderRadius: '12px', border: '1px solid #F3F4F6', marginBottom: '12px', display: 'flex', alignItems: 'center', gap: '16px' }}>
                                    <span style={{ backgroundColor: '#004d40', color: 'white', padding: '4px 8px', borderRadius: '6px', fontSize: '10px', fontWeight: '900' }}>{api.method}</span>
                                    <div style={{ flex: 1 }}>
                                        <div style={{ fontWeight: '700', color: '#111827', fontFamily: 'monospace' }}>{api.endpoint}</div>
                                        <div style={{ fontSize: '13px', color: '#6B7280' }}>{api.description}</div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                </section>

                <aside>
                    <div style={{ backgroundColor: '#F0F9FF', borderRadius: '16px', padding: '24px', border: '1px solid #BAE6FD' }}>
                        <h3 style={{ fontSize: '14px', fontWeight: '800', color: '#0369A1', textTransform: 'uppercase', marginBottom: '16px' }}>Summary Metrics</h3>
                        <div style={{ fontSize: '48px', fontWeight: '900', color: '#0C4A6E' }}>{audit.pageCount}</div>
                        <div style={{ fontSize: '14px', color: '#0369A1', fontWeight: '600' }}>Pages Implemented</div>
                        <hr style={{ margin: '24px 0', border: 'none', borderTop: '1px solid #BAE6FD' }} />
                        <div style={{ fontSize: '13px', lineHeight: '1.6', color: '#0C4A6E' }}>
                            All pages utilize the <strong>Fractal Tiering System</strong>. Components are lazy-loaded with <code>index.tsx</code> entry points for architectural compliance.
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    );
};

export default DeveloperKBPage;

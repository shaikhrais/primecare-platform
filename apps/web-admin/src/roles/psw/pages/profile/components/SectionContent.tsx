import React from 'react';
import { DocWell, InputField, PrimaryButton, ToggleRow } from './ProfileUI';

export function SectionContent({ activeSection, data, onChange, onSave, isSaving }: any) {
    switch (activeSection) {
        case 'Personal':
            return (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2.5rem' }}>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.75rem', fontWeight: 900, color: '#111827' }}>Personal Identity</h3>
                        <p style={{ color: '#6B7280', marginTop: '4px', fontWeight: 500 }}>Grouped information for your enterprise identity.</p>
                    </div>

                    <div style={{
                        padding: '32px',
                        backgroundColor: '#F9FAFB',
                        borderRadius: '24px',
                        border: '1px solid #F3F4F6',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '20px'
                    }}>
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
                            <InputField
                                label="First Name"
                                name="firstName"
                                value={data?.firstName}
                                onChange={onChange}
                                icon="👤"
                            />
                            <InputField
                                label="Last Name"
                                name="lastName"
                                value={data?.lastName}
                                onChange={onChange}
                                icon="👤"
                            />
                        </div>
                        <InputField
                            label="Email Address"
                            name="email"
                            value={data?.email}
                            disabled
                            icon="📧"
                        />
                    </div>

                    <div style={{
                        padding: '32px',
                        backgroundColor: '#F9FAFB',
                        borderRadius: '24px',
                        border: '1px solid #F3F4F6',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '20px'
                    }}>
                        <InputField
                            label="Contact Number"
                            name="phoneNumber"
                            value={data?.phoneNumber || data?.phone}
                            onChange={onChange}
                            icon="📞"
                            placeholder="+1 (555) 000-0000"
                        />
                        <InputField
                            label="Residential Address"
                            name="address"
                            value={data?.address}
                            onChange={onChange}
                            icon="🏠"
                            placeholder="Street, City, Province, Postal Code"
                        />
                    </div>

                    <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: '1rem' }}>
                        <PrimaryButton
                            text={isSaving ? "Synchronizing..." : "Save Profile Changes"}
                            onClick={onSave}
                            disabled={isSaving}
                        />
                    </div>
                </div>
            );
        case 'Security':
            return (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2.5rem' }}>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.75rem', fontWeight: 900, color: '#111827' }}>Access & Security</h3>
                        <p style={{ color: '#6B7280', marginTop: '4px', fontWeight: 500 }}>Manage your authentication methods and data safety.</p>
                    </div>

                    <div style={{
                        padding: '24px',
                        backgroundColor: '#FFFBEB',
                        borderRadius: '24px',
                        border: '1px solid #FDE68A',
                        display: 'flex',
                        gap: '20px',
                        alignItems: 'center'
                    }}>
                        <div style={{ fontSize: '2rem' }}>🔐</div>
                        <div>
                            <div style={{ fontWeight: 900, color: '#92400E', fontSize: '1.1rem' }}>Two-Factor Authentication</div>
                            <p style={{ margin: '4px 0 12px 0', fontSize: '0.95rem', color: '#92400E', opacity: 0.8 }}>Secure your session with an secondary device verification.</p>
                            <button style={{ background: '#000000', color: 'white', border: 'none', padding: '10px 20px', borderRadius: '12px', fontWeight: 800, cursor: 'pointer', fontSize: '0.85rem' }}>Setup 2FA Now</button>
                        </div>
                    </div>

                    <div style={{
                        padding: '32px',
                        backgroundColor: '#F9FAFB',
                        borderRadius: '24px',
                        border: '1px solid #F3F4F6',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '20px'
                    }}>
                        <InputField label="Current Password" type="password" placeholder="••••••••" icon="🔑" />
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
                            <InputField label="New Password" type="password" placeholder="••••••••" icon="🆕" />
                            <InputField label="Confirm New Password" type="password" placeholder="••••••••" icon="🆕" />
                        </div>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
                        <PrimaryButton text="Update Security Credentials" />
                    </div>
                </div>
            );
        case 'Notifications':
            return (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2.5rem' }}>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.75rem', fontWeight: 900, color: '#111827' }}>Alert Preferences</h3>
                        <p style={{ color: '#6B7280', marginTop: '4px', fontWeight: 500 }}>Control how and when you receive enterprise updates.</p>
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                        <ToggleRow title="Instant Shift Alerts" description="Priority notifications for new visit assignments." initialValue={true} />
                        <ToggleRow title="Financial Reports" description="Monthly breakdown of earnings and payouts." initialValue={true} />
                        <ToggleRow title="compliance pulse" description="Weekly status update on your professional documents." initialValue={true} />
                        <ToggleRow title="Corporate Broadcasts" description="General announcements and system news." initialValue={false} />
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: '1rem' }}>
                        <PrimaryButton text="Save Alert Settings" />
                    </div>
                </div>
            );
        case 'Documents':
            return (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2.5rem' }}>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.75rem', fontWeight: 900, color: '#111827' }}>Professional Vault</h3>
                        <p style={{ color: '#6B7280', marginTop: '4px', fontWeight: 500 }}>Secure storage for your certifications and identity documents.</p>
                    </div>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
                        <DocWell title="PSW Class A License" sub="Verified · Exp: Mar 2026" status="Verified" icon="🎖️" />
                        <DocWell title="First Aid & CPR-C" sub="Verified · Exp: Dec 2025" status="Verified" icon="🩹" />
                        <DocWell title="Vulnerable Sector Check" sub="Expiring in 8 days" status="Expiring" icon="👮" />
                        <DocWell title="Government ID" sub="Uploaded Jan 2024" status="Verified" icon="🆔" />
                    </div>
                    <div style={{
                        padding: '40px',
                        border: '2px dashed #D1D5DB',
                        borderRadius: '32px',
                        textAlign: 'center',
                        cursor: 'pointer',
                        backgroundColor: '#F9FAFB',
                        transition: 'all 0.3s'
                    }}
                        onMouseEnter={(e) => e.currentTarget.style.borderColor = '#00875A'}
                        onMouseLeave={(e) => e.currentTarget.style.borderColor = '#D1D5DB'}
                    >
                        <div style={{ fontSize: '2.5rem', marginBottom: '16px' }}>📤</div>
                        <div style={{ fontWeight: 900, color: '#111827', fontSize: '1.25rem' }}>Upload Document to Vault</div>
                        <div style={{ fontSize: '0.9rem', color: '#6B7280', marginTop: '4px' }}>Securely upload PDF or images up to 10MB</div>
                    </div>
                </div>
            );
        default:
            return null;
    }
}

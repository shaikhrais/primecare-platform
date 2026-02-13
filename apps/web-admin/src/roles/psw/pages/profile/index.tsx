import React, { useState } from 'react';
import { Breadcrumb } from '../../components/Breadcrumb';
import { SecureSessionGuard } from '../../components/SecureSessionGuard';

export default function ProfilePage() {
    const [activeSection, setActiveSection] = useState('Personal');

    return (
        <SecureSessionGuard allowedRoles={['psw', 'admin']}>
            <div style={{ padding: '2rem', display: 'flex', flexDirection: 'column', gap: '2rem', animation: 'fadeIn 0.5s ease-out' }}>
                <div style={{ flex: 1 }}>
                    <Breadcrumb />
                    <h1 style={{ margin: '0.5rem 0 0 0', fontSize: '2.5rem', fontWeight: 900, color: '#111827' }}>Profile</h1>
                    <p style={{ margin: '4px 0 0 0', color: '#6B7280', fontWeight: 500 }}>Manage your personal information and security settings</p>
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '2.5rem', alignItems: 'start' }}>
                    {/* --- LEFT COLUMN: OVERVIEW & TABS --- */}
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                        <div style={{
                            padding: '32px',
                            backgroundColor: '#FFFFFF',
                            borderRadius: '24px',
                            border: '1px solid #E5E7EB',
                            boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)',
                            textAlign: 'center'
                        }}>
                            <div style={{
                                width: '120px',
                                height: '120px',
                                backgroundColor: '#00875A',
                                borderRadius: '50%',
                                margin: '0 auto 20px auto',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                fontSize: '3rem',
                                color: 'white',
                                fontWeight: 900,
                                boxShadow: '0 10px 15px -3px rgba(0, 135, 90, 0.3)'
                            }}>
                                JD
                            </div>
                            <h2 style={{ margin: '0 0 4px 0', fontSize: '1.5rem', fontWeight: 900 }}>John Doe</h2>
                            <div style={{
                                display: 'inline-block',
                                padding: '4px 12px',
                                backgroundColor: '#E6F4EF',
                                color: '#00875A',
                                borderRadius: '20px',
                                fontSize: '0.8rem',
                                fontWeight: 800,
                                textTransform: 'uppercase',
                                marginBottom: '16px'
                            }}>
                                Personal Support Worker
                            </div>
                            <div style={{ borderTop: '1px solid #F3F4F6', paddingTop: '16px', color: '#6B7280', fontSize: '0.9rem' }}>
                                john.doe@primecare.com<br />
                                Joined March 2024
                            </div>
                        </div>

                        <div style={{
                            backgroundColor: '#FFFFFF',
                            borderRadius: '24px',
                            border: '1px solid #E5E7EB',
                            overflow: 'hidden'
                        }}>
                            {['Personal', 'Security', 'Notifications', 'Documents'].map(section => (
                                <button
                                    key={section}
                                    onClick={() => setActiveSection(section)}
                                    style={{
                                        width: '100%',
                                        padding: '20px 24px',
                                        textAlign: 'left',
                                        border: 'none',
                                        background: activeSection === section ? '#F9FAFB' : 'transparent',
                                        borderLeft: activeSection === section ? '4px solid #00875A' : '4px solid transparent',
                                        color: activeSection === section ? '#00875A' : '#111827',
                                        fontWeight: 800,
                                        fontSize: '1rem',
                                        cursor: 'pointer',
                                        transition: 'all 0.2s'
                                    }}
                                >
                                    {section}
                                </button>
                            ))}
                        </div>
                    </div>

                    {/* --- RIGHT COLUMN: ACTIVE SECTION FORM --- */}
                    <div style={{
                        backgroundColor: '#FFFFFF',
                        padding: '40px',
                        borderRadius: '24px',
                        border: '1px solid #E5E7EB',
                        minHeight: '600px',
                        boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.05)'
                    }}>
                        <SectionContent activeSection={activeSection} />
                    </div>
                </div>
            </div>

            <style>{`
                    @keyframes fadeIn {
                        from { opacity: 0; transform: translateY(10px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                    input:focus {
                        border-color: #00875A !important;
                        outline: none;
                    }
                </style>
            </>
        </SecureSessionGuard >
    );
}

function SectionContent({ activeSection }: { activeSection: string }) {
    switch (activeSection) {
        case 'Personal':
            return (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                    <h3 style={{ margin: 0, fontSize: '1.5rem', fontWeight: 900 }}>Personal Information</h3>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                        <InputField label="First Name" value="John" />
                        <InputField label="Last Name" value="Doe" />
                    </div>
                    <InputField label="Email Address" value="john.doe@primecare.com" disabled />
                    <InputField label="Contact Number" value="+1 (555) 000-0000" />
                    <InputField label="Residential Address" value="123 Care Street, Toronto, ON" />
                    <PrimaryButton text="Save Changes" />
                </div>
            );
        case 'Security':
            return (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                    <h3 style={{ margin: 0, fontSize: '1.5rem', fontWeight: 900 }}>Security Settings</h3>
                    <div style={{ padding: '20px', backgroundColor: '#FEE2E2', borderRadius: '16px', border: '1px solid #EF4444' }}>
                        <div style={{ fontWeight: 800, color: '#B91C1C', marginBottom: '4px' }}>Two-Factor Authentication</div>
                        <p style={{ margin: 0, fontSize: '0.85rem', color: '#B91C1C' }}>Add an extra layer of security to your account.</p>
                        <button style={{ marginTop: '12px', background: '#B91C1C', color: 'white', border: 'none', padding: '8px 16px', borderRadius: '8px', fontWeight: 800, cursor: 'pointer' }}>Enable 2FA</button>
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                        <InputField label="Current Password" type="password" placeholder="••••••••" />
                        <InputField label="New Password" type="password" placeholder="••••••••" />
                        <InputField label="Confirm New Password" type="password" placeholder="••••••••" />
                    </div>
                    <PrimaryButton text="Update Password" />
                </div>
            );
        case 'Notifications':
            return (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                    <h3 style={{ margin: 0, fontSize: '1.5rem', fontWeight: 900 }}>Notification Preferences</h3>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                        <ToggleRow title="New Shift Alerts" description="Get notified when a new visit is assigned to you." initialValue={true} />
                        <ToggleRow title="Payment Summaries" description="Receive monthly earning reports via email." initialValue={true} />
                        <ToggleRow title="Compliance Reminders" description="Alerts for certificate expirations." initialValue={true} />
                        <ToggleRow title="System Updates" description="Major platform enhancements." initialValue={false} />
                    </div>
                    <PrimaryButton text="Save Preferences" />
                </div>
            );
        case 'Documents':
            return (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                    <h3 style={{ margin: 0, fontSize: '1.5rem', fontWeight: 900 }}>Document Center</h3>
                    <p style={{ color: '#6B7280', margin: '-1rem 0 0 0' }}>Manage your professional certifications and identification.</p>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                        <DocRow title="PSW Certification" sub="Verified - Exp: Mar 2026" status="Verified" />
                        <DocRow title="CPR/First Aid" sub="Verified - Exp: Dec 2025" status="Verified" />
                        <DocRow title="Police Vulnerable Sector Check" sub="Expires in 12 days" status="Expiring" />
                        <DocRow title="Government Issued ID" sub="Uploaded Jan 2024" status="Verified" />
                    </div>
                    <div style={{ padding: '24px', border: '2px dashed #E5E7EB', borderRadius: '16px', textAlign: 'center', cursor: 'pointer' }}>
                        <div style={{ fontSize: '1.5rem', marginBottom: '8px' }}>📤</div>
                        <div style={{ fontWeight: 800, color: '#111827' }}>Upload New Document</div>
                        <div style={{ fontSize: '0.8rem', color: '#9CA3AF' }}>Support PDF, JPG, PNG (Max 5MB)</div>
                    </div>
                </div>
            );
        default:
            return null;
    }
}

function InputField({ label, value, type = 'text', disabled = false, placeholder = '' }: any) {
    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#374151' }}>{label}</label>
            <input
                type={type}
                defaultValue={value}
                disabled={disabled}
                placeholder={placeholder}
                style={{
                    padding: '14px 16px',
                    borderRadius: '12px',
                    border: '1px solid #E5E7EB',
                    backgroundColor: disabled ? '#F9FAFB' : '#FFFFFF',
                    color: disabled ? '#9CA3AF' : '#111827',
                    fontWeight: 600,
                    fontSize: '1rem',
                    cursor: disabled ? 'not-allowed' : 'text'
                }}
            />
        </div>
    );
}

function ToggleRow({ title, description, initialValue }: any) {
    return (
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', borderRadius: '16px', backgroundColor: '#F9FAFB' }}>
            <div style={{ flex: 1 }}>
                <div style={{ fontWeight: 800, fontSize: '1rem' }}>{title}</div>
                <div style={{ fontSize: '0.85rem', color: '#6B7280' }}>{description}</div>
            </div>
            <div style={{
                width: '48px',
                height: '24px',
                backgroundColor: initialValue ? '#00875A' : '#E5E7EB',
                borderRadius: '12px',
                position: 'relative',
                cursor: 'pointer'
            }}>
                <div style={{
                    width: '18px',
                    height: '18px',
                    backgroundColor: 'white',
                    borderRadius: '50%',
                    position: 'absolute',
                    top: '3px',
                    left: initialValue ? '27px' : '3px',
                    transition: 'all 0.2s'
                }} />
            </div>
        </div>
    );
}

function DocRow({ title, sub, status }: any) {
    const isExpiring = status === 'Expiring';
    return (
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', backgroundColor: '#FFFFFF', border: '1px solid #F3F4F6', borderRadius: '16px' }}>
            <div>
                <div style={{ fontWeight: 800, fontSize: '0.9rem' }}>{title}</div>
                <div style={{ fontSize: '0.8rem', color: isExpiring ? '#B91C1C' : '#9CA3AF', fontWeight: isExpiring ? 700 : 500 }}>{sub}</div>
            </div>
            <div style={{
                padding: '4px 12px',
                backgroundColor: isExpiring ? '#FEE2E2' : '#E6F4EF',
                color: isExpiring ? '#B91C1C' : '#00875A',
                borderRadius: '20px',
                fontSize: '0.7rem',
                fontWeight: 800,
                textTransform: 'uppercase'
            }}>
                {status}
            </div>
        </div>
    );
}

function PrimaryButton({ text }: { text: string }) {
    return (
        <button style={{
            padding: '16px',
            backgroundColor: '#00875A',
            color: 'white',
            border: 'none',
            borderRadius: '12px',
            fontWeight: 800,
            fontSize: '1rem',
            cursor: 'pointer',
            boxShadow: '0 4px 14px 0 rgba(0, 135, 90, 0.3)'
        }}>
            {text}
        </button>
    );
}

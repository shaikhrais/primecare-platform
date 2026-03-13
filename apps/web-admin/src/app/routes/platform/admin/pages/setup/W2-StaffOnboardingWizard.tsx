import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';

const { RouteRegistry, ApiRegistry, ContentRegistry } = AdminRegistry;

export default function StaffOnboardingWizard() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [step, setStep] = useState(1);
    const [loading, setLoading] = useState(false);
    const [formData, setFormData] = useState({
        fullName: '',
        email: '',
        role: 'psw',
        sin: ''
    });

    const handleCreateAccount = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            const response = await apiClient.post(ApiRegistry.ADMIN.USERS, {
                email: formData.email,
                fullName: formData.fullName,
                roles: [formData.role],
                sin: formData.sin
            });
            if (response.ok) {
                showToast(ContentRegistry.STAFF_WIZARD.FORM.SUCCESS, 'success');
                setStep(2);
            } else {
                showToast('Failed to create account', 'error');
            }
        } catch (error) {
            showToast('Network error', 'error');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: '800px', margin: '2rem auto', padding: '2rem', background: 'white', borderRadius: '1.5rem', border: '1px solid #e5e7eb', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)' }}>
            <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
                <h1 style={{ fontSize: '2rem', fontWeight: '800', marginBottom: '0.5rem' }}>🛡️ {t(ContentRegistry.STAFF_WIZARD.TITLE)}</h1>
                <p style={{ color: '#6b7280' }}>{t(ContentRegistry.STAFF_WIZARD.SUBTITLE)}</p>
            </div>

            <div style={{ marginBottom: '3rem', display: 'flex', gap: '1rem', position: 'relative' }}>
                {ContentRegistry.STAFF_WIZARD.STEPS.map((label, i) => (
                    <div key={label} style={{ flex: 1 }}>
                        <div style={{ height: '4px', background: (i + 1) <= step ? '#004d40' : '#e5e7eb', borderRadius: '2px', transition: 'background 0.3s', marginBottom: '0.5rem' }} />
                        <span style={{ fontSize: '0.75rem', fontWeight: '700', textTransform: 'uppercase', color: (i + 1) === step ? '#004d40' : '#9ca3af' }}>{label}</span>
                    </div>
                ))}
            </div>

            {step === 1 && (
                <form onSubmit={handleCreateAccount}>
                    <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>Step 1: {ContentRegistry.STAFF_WIZARD.STEPS[0]}</h2>
                    <div style={{ display: 'grid', gap: '1.5rem' }}>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>{t(ContentRegistry.STAFF_WIZARD.FORM.NAME_LABEL)}</label>
                            <input
                                placeholder={t(ContentRegistry.STAFF_WIZARD.FORM.NAME_PLACEHOLDER)}
                                value={formData.fullName}
                                onChange={e => setFormData({ ...formData, fullName: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #d1d5db', borderRadius: '0.5rem' }}
                                required
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>{t(ContentRegistry.STAFF_WIZARD.FORM.EMAIL_LABEL)}</label>
                            <input
                                type="email"
                                placeholder={t(ContentRegistry.STAFF_WIZARD.FORM.EMAIL_PLACEHOLDER)}
                                value={formData.email}
                                onChange={e => setFormData({ ...formData, email: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #d1d5db', borderRadius: '0.5rem' }}
                                required
                            />
                        </div>
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>{t(ContentRegistry.STAFF_WIZARD.FORM.ROLE_LABEL)}</label>
                                <select
                                    value={formData.role}
                                    onChange={e => setFormData({ ...formData, role: e.target.value })}
                                    style={{ width: '100%', padding: '0.75rem', border: '1px solid #d1d5db', borderRadius: '0.5rem' }}
                                >
                                    <option value="psw">PSW (Personal Support)</option>
                                    <option value="rn">RN (Registered Nurse)</option>
                                    <option value="staff">Administrative Staff</option>
                                </select>
                            </div>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>{t(ContentRegistry.STAFF_WIZARD.FORM.SIN_LABEL)}</label>
                                <input
                                    placeholder={t(ContentRegistry.STAFF_WIZARD.FORM.SIN_PLACEHOLDER)}
                                    value={formData.sin}
                                    onChange={e => setFormData({ ...formData, sin: e.target.value })}
                                    style={{ width: '100%', padding: '0.75rem', border: '1px solid #d1d5db', borderRadius: '0.5rem' }}
                                    required
                                />
                            </div>
                        </div>
                    </div>
                    <div style={{ marginTop: '3rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                        <button type="button" onClick={() => navigate(RouteRegistry.ADMIN.WIZARD_HUB)} style={{ padding: '0.75rem 1.5rem', borderRadius: '0.75rem', border: '1px solid #d1d5db', background: 'white', fontWeight: '600' }}>Cancel</button>
                        <button type="submit" disabled={loading} style={{ padding: '0.75rem 2rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '0.75rem', border: 'none', cursor: 'pointer' }}>
                            {loading ? t(ContentRegistry.STAFF_WIZARD.FORM.SUBMITTING) : 'Continue to Compliance'}
                        </button>
                    </div>
                </form>
            )}

            {step === 2 && (
                <div>
                    <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>Step 2: {ContentRegistry.STAFF_WIZARD.STEPS[1]}</h2>
                    <p style={{ color: '#6b7280', marginBottom: '2rem' }}>Upload mandatory clearance documents for <strong>{formData.fullName}</strong>.</p>
                    <div style={{ display: 'grid', gap: '1rem' }}>
                        <div style={{ border: '2px dashed #d1d5db', padding: '2rem', textAlign: 'center', borderRadius: '1rem', color: '#6b7280' }}>
                            <div style={{ fontSize: '1.5rem', marginBottom: '0.5rem' }}>📄</div>
                            <div style={{ fontWeight: '600', color: '#374151' }}>{t(ContentRegistry.STAFF_WIZARD.FORM.VSS_LABEL)}</div>
                            <div style={{ fontSize: '0.875rem' }}>Click or drag PDF to upload</div>
                        </div>
                        <div style={{ border: '2px dashed #d1d5db', padding: '2rem', textAlign: 'center', borderRadius: '1rem', color: '#6b7280' }}>
                            <div style={{ fontSize: '1.5rem', marginBottom: '0.5rem' }}>📜</div>
                            <div style={{ fontWeight: '600', color: '#374151' }}>{formData.role.toUpperCase()} {t(ContentRegistry.STAFF_WIZARD.FORM.LICENSE_LABEL)}</div>
                            <div style={{ fontSize: '0.875rem' }}>Click or drag PDF to upload</div>
                        </div>
                    </div>
                    <div style={{ marginTop: '3rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                        <button onClick={() => setStep(1)} style={{ padding: '0.75rem 1.5rem', borderRadius: '0.75rem', border: '1px solid #d1d5db', background: 'white', fontWeight: '600' }}>Back</button>
                        <button onClick={() => setStep(3)} style={{ padding: '0.75rem 2rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '0.75rem', border: 'none', cursor: 'pointer' }}>Skip for Now</button>
                    </div>
                </div>
            )}

            {step === 3 && (
                <div style={{ textAlign: 'center', padding: '2rem' }}>
                    <div style={{ fontSize: '4rem', marginBottom: '1.5rem' }}>✅</div>
                    <h2 style={{ fontSize: '1.75rem', fontWeight: '800', marginBottom: '1rem' }}>Onboarding Complete</h2>
                    <p style={{ color: '#6b7280', marginBottom: '2.5rem', fontSize: '1.125rem' }}>
                        {formData.fullName} has been added to your staff registry.
                        They can now be assigned to shifts once their documents are verified.
                    </p>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                        <button onClick={() => navigate(RouteRegistry.ADMIN.BUSINESS_STATUS)} style={{ padding: '1.25rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '1rem', border: 'none', cursor: 'pointer', fontSize: '1rem' }}>
                            Return to Command Center
                        </button>
                        <button onClick={() => { setStep(1); setFormData({ fullName: '', email: '', role: 'psw', sin: '' }); }} style={{ padding: '1rem', background: 'transparent', color: '#004d40', fontWeight: '700', borderRadius: '1rem', border: 'none', cursor: 'pointer' }}>
                            Add Another Staff Member
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}

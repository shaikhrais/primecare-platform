import { AdminRegistry } from 'prime-care-shared';
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

const { ContentRegistry } = AdminRegistry;

export default function PswOnboardingForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        fullName: '',
        email: '',
        phone: '',
        address: '',
        sin: '',
        certifications: [] as string[],
        backgroundCheckStatus: ContentRegistry.ONBOARDING.FORM.STATUS_OPTIONS.PENDING
    });

    // Unsaved changes guard (Native)
    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty]);

    const handleCertChange = (cert: string) => {
        setIsDirty(true);
        if (formData.certifications.includes(cert)) {
            setFormData({ ...formData, certifications: formData.certifications.filter(c => c !== cert) });
        } else {
            setFormData({ ...formData, certifications: [...formData.certifications, cert] });
        }
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const response = await apiClient.post('/v1/admin/psw/onboard', formData);

            if (response.ok) {
                showToast(ContentRegistry.ONBOARDING.MESSAGES.SUCCESS, 'success');
                setIsDirty(false);
                navigate(AdminRegistry.RouteRegistry.ADMIN.USERS);
            } else {
                showToast(ContentRegistry.ONBOARDING.MESSAGES.ERROR, 'error');
            }
        } catch (error) {
            showToast(ContentRegistry.ONBOARDING.MESSAGES.ERROR_SUBMISSION, 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.psw.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', border: '1px solid #e5e7eb', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 style={{ marginTop: 0 }}>{ContentRegistry.ONBOARDING.FORM.DISCARD_TITLE}</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>{ContentRegistry.ONBOARDING.FORM.DISCARD_DESC}</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">{ContentRegistry.ONBOARDING.TITLE}</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">{ContentRegistry.ONBOARDING.SUBTITLE}</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.ONBOARDING.FORM.FULL_NAME}</label>
                        <input
                            data-cy="form.psw.fullname"
                            type="text"
                            required
                            value={formData.fullName}
                            onChange={(e) => { setFormData({ ...formData, fullName: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.ONBOARDING.FORM.EMAIL}</label>
                        <input
                            data-cy="form.psw.email"
                            type="email"
                            required
                            value={formData.email}
                            onChange={(e) => { setFormData({ ...formData, email: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.ONBOARDING.FORM.PHONE}</label>
                        <input
                            data-cy="form.psw.phone"
                            type="tel"
                            required
                            value={formData.phone}
                            onChange={(e) => { setFormData({ ...formData, phone: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.ONBOARDING.FORM.ADDRESS}</label>
                        <input
                            data-cy="form.psw.address"
                            type="text"
                            required
                            value={formData.address}
                            onChange={(e) => { setFormData({ ...formData, address: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.ONBOARDING.FORM.SIN}</label>
                        <input
                            data-cy="form.psw.sin"
                            type="password"
                            required
                            value={formData.sin}
                            onChange={(e) => { setFormData({ ...formData, sin: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.ONBOARDING.FORM.BACKGROUND_CHECK}</label>
                        <select
                            data-cy="form.psw.backgroundCheck"
                            value={formData.backgroundCheckStatus}
                            onChange={(e) => { setFormData({ ...formData, backgroundCheckStatus: e.target.value as any }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value={ContentRegistry.ONBOARDING.FORM.STATUS_OPTIONS.PENDING}>{ContentRegistry.ONBOARDING.FORM.STATUS_OPTIONS.PENDING}</option>
                            <option value={ContentRegistry.ONBOARDING.FORM.STATUS_OPTIONS.CLEARED}>{ContentRegistry.ONBOARDING.FORM.STATUS_OPTIONS.CLEARED}</option>
                            <option value={ContentRegistry.ONBOARDING.FORM.STATUS_OPTIONS.FLAGGED}>{ContentRegistry.ONBOARDING.FORM.STATUS_OPTIONS.FLAGGED}</option>
                        </select>
                    </div>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.ONBOARDING.FORM.CERTIFICATIONS}</label>
                        <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap' }} data-cy="form.psw.certifications">
                            {['PSW Certified', 'First Aid', 'CPR', 'Vulnerable Sector Check'].map(cert => (
                                <label key={cert} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', padding: '0.5rem 1rem', background: '#f9fafb', borderRadius: '0.375rem', cursor: 'pointer' }} data-cy={`lbl-psw-cert-${cert.toLowerCase().replace(/\s+/g, '-')}`}>
                                    <input type="checkbox" checked={formData.certifications.includes(cert)} onChange={() => handleCertChange(cert)} data-cy={`chk-psw-cert-${cert.toLowerCase().replace(/\s+/g, '-')}`} />
                                    {cert}
                                </label>
                            ))}
                        </div>
                    </div>
                </div>

                <div style={{ marginTop: '2.5rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        data-cy="btn-cancel"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        {ContentRegistry.ONBOARDING.FORM.CANCEL}
                    </button>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.psw.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? ContentRegistry.ONBOARDING.FORM.PROCESSING : ContentRegistry.ONBOARDING.FORM.SUBMIT}
                    </button>
                </div>
            </form>
        </div>
    );
}

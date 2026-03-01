import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

const { RouteRegistry, ApiRegistry, ContentRegistry } = AdminRegistry;

export default function CarePlanWizard() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [step, setStep] = useState(1);
    const [loading, setLoading] = useState(false);
    const [formData, setFormData] = useState({
        fullName: '',
        email: '',
        phone: '',
        address: '',
        emergencyContact: '',
        medicalNotes: '',
        activities: [] as string[]
    });

    const handleAdmitClient = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            const response = await apiClient.post(ApiRegistry.ADMIN.CLIENTS, {
                email: formData.email,
                fullName: formData.fullName,
                phone: formData.phone,
                address: formData.address,
                emergencyContact: formData.emergencyContact,
                medicalNotes: formData.medicalNotes
            });
            if (response.ok) {
                showToast(ContentRegistry.CARE_WIZARD.FORM.ADMITTING, 'success');
                setStep(2);
            } else {
                showToast('Admission failed', 'error');
            }
        } catch (error) {
            showToast('Network error', 'error');
        } finally {
            setLoading(false);
        }
    };

    const toggleActivity = (activity: string) => {
        setFormData(prev => ({
            ...prev,
            activities: prev.activities.includes(activity)
                ? prev.activities.filter(a => a !== activity)
                : [...prev.activities, activity]
        }));
    };

    return (
        <div style={{ maxWidth: '900px', margin: '2rem auto', padding: '2.5rem', background: 'white', borderRadius: '2rem', border: '1px solid #e5e7eb', boxShadow: '0 10px 25px -5px rgba(0, 0, 0, 0.05)' }}>
            <div style={{ textAlign: 'center', marginBottom: '3rem' }}>
                <h1 style={{ fontSize: '2.25rem', fontWeight: '900', color: '#111827', marginBottom: '0.5rem' }}>🏥 {ContentRegistry.CARE_WIZARD.TITLE}</h1>
                <p style={{ color: '#6b7280', fontSize: '1.125rem' }}>{ContentRegistry.CARE_WIZARD.SUBTITLE}</p>
            </div>

            <div style={{ marginBottom: '3.5rem', display: 'flex', gap: '1.5rem' }}>
                {ContentRegistry.CARE_WIZARD.STEPS.map((label, i) => (
                    <div key={label} style={{ flex: 1 }}>
                        <div style={{ height: '6px', background: (i + 1) <= step ? '#004d40' : '#e5e7eb', borderRadius: '3px', marginBottom: '0.75rem', transition: 'all 0.4s ease' }} />
                        <span style={{ fontSize: '0.75rem', fontWeight: '700', textTransform: 'uppercase', color: (i + 1) === step ? '#004d40' : '#9ca3af' }}>{label}</span>
                    </div>
                ))}
            </div>

            {step === 1 && (
                <form onSubmit={handleAdmitClient}>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: '800', marginBottom: '2rem', color: '#111827' }}>Step 1: {ContentRegistry.CARE_WIZARD.STEPS[0]}</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '700', marginBottom: '0.5rem' }}>{ContentRegistry.CARE_WIZARD.FORM.NAME_LABEL}</label>
                            <input
                                placeholder={ContentRegistry.CARE_WIZARD.FORM.NAME_PLACEHOLDER}
                                value={formData.fullName}
                                onChange={e => setFormData({ ...formData, fullName: e.target.value })}
                                style={{ width: '100%', padding: '0.875rem', border: '1px solid #d1d5db', borderRadius: '0.75rem' }}
                                required
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '700', marginBottom: '0.5rem' }}>{ContentRegistry.CARE_WIZARD.FORM.EMAIL_LABEL}</label>
                            <input
                                type="email"
                                placeholder={ContentRegistry.CARE_WIZARD.FORM.EMAIL_PLACEHOLDER}
                                value={formData.email}
                                onChange={e => setFormData({ ...formData, email: e.target.value })}
                                style={{ width: '100%', padding: '0.875rem', border: '1px solid #d1d5db', borderRadius: '0.75rem' }}
                                required
                            />
                        </div>
                        <div style={{ gridColumn: 'span 2' }}>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '700', marginBottom: '0.5rem' }}>{ContentRegistry.CARE_WIZARD.FORM.ADDR_LABEL}</label>
                            <input
                                placeholder={ContentRegistry.CARE_WIZARD.FORM.ADDR_PLACEHOLDER}
                                value={formData.address}
                                onChange={e => setFormData({ ...formData, address: e.target.value })}
                                style={{ width: '100%', padding: '0.875rem', border: '1px solid #d1d5db', borderRadius: '0.75rem' }}
                                required
                            />
                        </div>
                    </div>
                    <div style={{ marginTop: '3rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                        <button type="button" onClick={() => navigate(RouteRegistry.BUSINESS_STATUS)} style={{ padding: '0.875rem 1.75rem', borderRadius: '1rem', border: '1px solid #d1d5db', background: 'white', fontWeight: '600' }}>Cancel</button>
                        <button type="submit" disabled={loading} style={{ padding: '0.875rem 2.5rem', background: '#004d40', color: 'white', fontWeight: '800', borderRadius: '1rem', border: 'none', cursor: 'pointer', boxShadow: '0 4px 14px 0 rgba(0,77,64,0.39)' }}>
                            {loading ? ContentRegistry.CARE_WIZARD.FORM.ADMITTING : ContentRegistry.CARE_WIZARD.FORM.NEXT_BTN}
                        </button>
                    </div>
                </form>
            )}

            {step === 2 && (
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: '800', marginBottom: '1.5rem', color: '#111827' }}>Step 2: {ContentRegistry.CARE_WIZARD.FORM.MEDICAL_TITLE}</h2>
                    <div style={{ background: '#f9fafb', padding: '2rem', borderRadius: '1.5rem', border: '1px solid #e5e7eb', marginBottom: '2rem' }}>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '700', marginBottom: '0.75rem' }}>{ContentRegistry.CARE_WIZARD.FORM.MEDICAL_LABEL}</label>
                        <textarea
                            rows={4}
                            placeholder={ContentRegistry.CARE_WIZARD.FORM.MEDICAL_PLACEHOLDER}
                            value={formData.medicalNotes}
                            onChange={e => setFormData({ ...formData, medicalNotes: e.target.value })}
                            style={{ width: '100%', padding: '1rem', border: '1px solid #d1d5db', borderRadius: '1rem', resize: 'none' }}
                        />
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                        <button onClick={() => setStep(1)} style={{ padding: '0.875rem 1.75rem', borderRadius: '1rem', border: '1px solid #d1d5db', background: 'white', fontWeight: '600' }}>{ContentRegistry.CARE_WIZARD.FORM.BACK_BTN}</button>
                        <button onClick={() => setStep(3)} style={{ padding: '0.875rem 2.5rem', background: '#004d40', color: 'white', fontWeight: '800', borderRadius: '1rem', border: 'none', cursor: 'pointer' }}>Proceed to ADLs</button>
                    </div>
                </div>
            )}

            {step === 3 && (
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: '800', marginBottom: '1.5rem', color: '#111827' }}>Step 3: {ContentRegistry.CARE_WIZARD.FORM.ADL_TITLE}</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '1rem', marginBottom: '3rem' }}>
                        {['Bathing', 'Dressing', 'Medication', 'Meal Prep', 'Mobility', 'Toileting'].map(adl => (
                            <div
                                key={adl}
                                onClick={() => toggleActivity(adl)}
                                style={{
                                    padding: '1.5rem',
                                    borderRadius: '1.25rem',
                                    border: '2px solid',
                                    borderColor: formData.activities.includes(adl) ? '#004d40' : '#e5e7eb',
                                    background: formData.activities.includes(adl) ? '#f0fdf4' : 'white',
                                    textAlign: 'center',
                                    cursor: 'pointer',
                                    transition: 'all 0.2s'
                                }}
                            >
                                <span style={{ fontWeight: '700', color: formData.activities.includes(adl) ? '#004d40' : '#374151' }}>{adl}</span>
                            </div>
                        ))}
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                        <button onClick={() => navigate(RouteRegistry.BUSINESS_STATUS)} style={{ padding: '1.25rem', background: '#004d40', color: 'white', fontWeight: '900', borderRadius: '1.25rem', border: 'none', cursor: 'pointer', fontSize: '1.125rem', boxShadow: '0 10px 15px -3px rgba(0, 77, 64, 0.4)' }}>
                            {ContentRegistry.CARE_WIZARD.FORM.SUBMIT_BTN}
                        </button>
                        <button onClick={() => setStep(1)} style={{ padding: '1rem', background: 'transparent', color: '#6b7280', fontWeight: '600', border: 'none', cursor: 'pointer' }}>Restart Wizard</button>
                    </div>
                </div>
            )}
        </div>
    );
}

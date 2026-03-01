import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

type Step = 'services' | 'staff' | 'clients' | 'success';

export default function BusinessSetupWizard() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [currentStep, setCurrentStep] = useState<Step>('services');
    const [loading, setLoading] = useState(false);

    // Form Data
    const [serviceData, setServiceData] = useState({ name: '', hourlyRate: 0, category: 'Senior Care', description: '' });
    const [staffData, setStaffData] = useState({ fullName: '', email: '', role: 'psw', sin: '' });
    const [clientData, setClientData] = useState({ fullName: '', email: '', phone: '', address: '', emergencyContact: '', medicalNotes: '' });

    const handleServiceSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            const response = await apiClient.post(ApiRegistry.ADMIN.SERVICES, serviceData);
            if (response.ok) {
                showToast('Service created successfully', 'success');
                setCurrentStep('staff');
            } else {
                showToast('Failed to create service', 'error');
            }
        } catch (error) {
            showToast('Network error', 'error');
        } finally {
            setLoading(false);
        }
    };

    const handleStaffSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            const response = await apiClient.post(ApiRegistry.ADMIN.USERS, {
                email: staffData.email,
                fullName: staffData.fullName,
                roles: [staffData.role],
                sin: staffData.sin // AdminUserService handles this
            });
            if (response.ok) {
                showToast('Staff onboarded successfully', 'success');
                setCurrentStep('clients');
            } else {
                showToast('Failed to onboard staff', 'error');
            }
        } catch (error) {
            showToast('Network error', 'error');
        } finally {
            setLoading(false);
        }
    };

    const handleClientSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            const response = await apiClient.post('/v1/admin/clients', clientData);
            if (response.ok) {
                showToast('Client admitted successfully', 'success');
                setCurrentStep('success');
            } else {
                showToast('Failed to admit client', 'error');
            }
        } catch (error) {
            showToast('Network error', 'error');
        } finally {
            setLoading(false);
        }
    };

    const renderProgress = () => {
        const steps: { key: Step; label: string }[] = [
            { key: 'services', label: ContentRegistry.SETUP_WIZARD.STEPS.SERVICES },
            { key: 'staff', label: ContentRegistry.SETUP_WIZARD.STEPS.STAFF },
            { key: 'clients', label: ContentRegistry.SETUP_WIZARD.STEPS.CLIENTS },
            { key: 'success', label: ContentRegistry.SETUP_WIZARD.STEPS.FINISH },
        ];

        return (
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '3rem', position: 'relative' }}>
                <div style={{ position: 'absolute', top: '15px', left: 0, right: 0, height: '2px', background: '#e5e7eb', zIndex: 0 }} />
                {steps.map((s, idx) => {
                    const isActive = currentStep === s.key;
                    const isCompleted = steps.findIndex(step => step.key === currentStep) > idx;
                    return (
                        <div key={s.key} style={{ zIndex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', width: '80px' }}>
                            <div style={{
                                width: '32px',
                                height: '32px',
                                borderRadius: '50%',
                                background: isActive ? '#004d40' : (isCompleted ? '#059669' : 'white'),
                                border: `2px solid ${isActive || isCompleted ? 'transparent' : '#d1d5db'}`,
                                color: isActive || isCompleted ? 'white' : '#6b7280',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                fontWeight: 'bold',
                                fontSize: '0.875rem',
                                marginBottom: '0.5rem',
                                boxShadow: isActive ? '0 0 0 4px rgba(0, 77, 64, 0.1)' : 'none'
                            }}>
                                {isCompleted ? '✓' : idx + 1}
                            </div>
                            <span style={{ fontSize: '0.75rem', fontWeight: isActive ? 'bold' : '500', color: isActive ? '#111827' : '#6b7280', textAlign: 'center' }}>{s.label}</span>
                        </div>
                    );
                })}
            </div>
        );
    };

    return (
        <div style={{ maxWidth: '800px', margin: '2rem auto', padding: '0 1rem' }}>
            <div style={{ textAlign: 'center', marginBottom: '3rem' }}>
                <h1 style={{ fontSize: '2rem', fontWeight: '800', color: '#111827', marginBottom: '0.5rem' }}>{ContentRegistry.SETUP_WIZARD.TITLE}</h1>
                <p style={{ color: '#6b7280' }}>{ContentRegistry.SETUP_WIZARD.SUBTITLE}</p>
            </div>

            {renderProgress()}

            <div style={{ background: 'white', padding: '2.5rem', borderRadius: '1.5rem', border: '1px solid #e5e7eb', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)' }}>
                {currentStep === 'services' && (
                    <form onSubmit={handleServiceSubmit}>
                        <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>Step 1: Define Your Care Services</h2>
                        <div style={{ display: 'grid', gap: '1.5rem' }}>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Service Name</label>
                                <input placeholder="e.g. Senior Daily Care" value={serviceData.name} onChange={e => setServiceData({ ...serviceData, name: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                            </div>
                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                                <div>
                                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Hourly Rate ($)</label>
                                    <input type="number" value={serviceData.hourlyRate} onChange={e => setServiceData({ ...serviceData, hourlyRate: parseFloat(e.target.value) })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                                </div>
                                <div>
                                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Category</label>
                                    <select value={serviceData.category} onChange={e => setServiceData({ ...serviceData, category: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}>
                                        <option>Senior Care</option>
                                        <option>Foot Care</option>
                                        <option>Consulting</option>
                                        <option>Training</option>
                                    </select>
                                </div>
                            </div>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Description</label>
                                <textarea rows={3} value={serviceData.description} onChange={e => setServiceData({ ...serviceData, description: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} />
                            </div>
                        </div>
                        <button type="submit" disabled={loading} style={{ width: '100%', marginTop: '2.5rem', padding: '1rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '0.75rem', border: 'none', cursor: 'pointer' }}>
                            {loading ? 'Saving...' : ContentRegistry.SETUP_WIZARD.BUTTONS.NEXT}
                        </button>
                    </form>
                )}

                {currentStep === 'staff' && (
                    <form onSubmit={handleStaffSubmit}>
                        <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>Step 2: Onboard Your First Healthcare Worker</h2>
                        <div style={{ display: 'grid', gap: '1.5rem' }}>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Full Name</label>
                                <input placeholder="e.g. Jane Doe" value={staffData.fullName} onChange={e => setStaffData({ ...staffData, fullName: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                            </div>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Email Address</label>
                                <input type="email" value={staffData.email} onChange={e => setStaffData({ ...staffData, email: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                            </div>
                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                                <div>
                                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Role</label>
                                    <select value={staffData.role} onChange={e => setStaffData({ ...staffData, role: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}>
                                        <option value="psw">PSW</option>
                                        <option value="rn">RN</option>
                                    </select>
                                </div>
                                <div>
                                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>SIN (For Payroll)</label>
                                    <input value={staffData.sin} onChange={e => setStaffData({ ...staffData, sin: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                                </div>
                            </div>
                        </div>
                        <div style={{ display: 'flex', gap: '1rem', marginTop: '2.5rem' }}>
                            <button type="button" onClick={() => setCurrentStep('services')} style={{ flex: 1, padding: '1rem', background: '#f3f4f6', fontWeight: '600', borderRadius: '0.75rem', border: '1px solid #d1d5db', cursor: 'pointer' }}>{ContentRegistry.SETUP_WIZARD.BUTTONS.BACK}</button>
                            <button type="submit" disabled={loading} style={{ flex: 2, padding: '1rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '0.75rem', border: 'none', cursor: 'pointer' }}>
                                {loading ? 'Saving...' : ContentRegistry.SETUP_WIZARD.BUTTONS.NEXT}
                            </button>
                        </div>
                    </form>
                )}

                {currentStep === 'clients' && (
                    <form onSubmit={handleClientSubmit}>
                        <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>Step 3: Admit Your First Client</h2>
                        <div style={{ display: 'grid', gap: '1.5rem' }}>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Client Full Name</label>
                                <input value={clientData.fullName} onChange={e => setClientData({ ...clientData, fullName: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                            </div>
                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                                <div>
                                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Email</label>
                                    <input type="email" value={clientData.email} onChange={e => setClientData({ ...clientData, email: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                                </div>
                                <div>
                                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Phone</label>
                                    <input type="tel" value={clientData.phone} onChange={e => setClientData({ ...clientData, phone: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                                </div>
                            </div>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Residential Address</label>
                                <input value={clientData.address} onChange={e => setClientData({ ...clientData, address: e.target.value })} style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }} required />
                            </div>
                        </div>
                        <div style={{ display: 'flex', gap: '1rem', marginTop: '2.5rem' }}>
                            <button type="button" onClick={() => setCurrentStep('staff')} style={{ flex: 1, padding: '1rem', background: '#f3f4f6', fontWeight: '600', borderRadius: '0.75rem', border: '1px solid #d1d5db', cursor: 'pointer' }}>{ContentRegistry.SETUP_WIZARD.BUTTONS.BACK}</button>
                            <button type="submit" disabled={loading} style={{ flex: 2, padding: '1rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '0.75rem', border: 'none', cursor: 'pointer' }}>
                                {loading ? 'Saving...' : ContentRegistry.SETUP_WIZARD.BUTTONS.FINISH}
                            </button>
                        </div>
                    </form>
                )}

                {currentStep === 'success' && (
                    <div style={{ textAlign: 'center', padding: '2rem 1rem' }}>
                        <div style={{ fontSize: '4rem', marginBottom: '1.5rem' }}>🎉</div>
                        <h2 style={{ fontSize: '1.75rem', fontWeight: '800', marginBottom: '1rem' }}>{ContentRegistry.SETUP_WIZARD.SUCCESS.TITLE}</h2>
                        <p style={{ color: '#6b7280', fontSize: '1.125rem', marginBottom: '2.5rem' }}>{ContentRegistry.SETUP_WIZARD.SUCCESS.MESSAGE}</p>
                        <button onClick={() => navigate(RouteRegistry.SCHEDULE)} style={{ width: '100%', padding: '1.25rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '1rem', border: 'none', cursor: 'pointer', fontSize: '1rem' }}>
                            Go to Schedule & Start Booking
                        </button>
                        <button onClick={() => navigate(RouteRegistry.DASHBOARD)} style={{ width: '100%', marginTop: '1rem', padding: '1rem', background: 'transparent', color: '#6b7280', fontWeight: '600', borderRadius: '1rem', border: 'none', cursor: 'pointer' }}>
                            Back to Dashboard
                        </button>
                    </div>
                )}
            </div>
        </div>
    );
}

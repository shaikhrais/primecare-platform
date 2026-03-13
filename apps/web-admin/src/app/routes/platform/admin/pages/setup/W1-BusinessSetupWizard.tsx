// ================================================================
// PAGE IDENTITY: W1 � Business Setup Wizard
// Registry ID:   page.admin.business-setup
// Type:          Wizard
// Owner:         admin
// ================================================================
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import { useTranslation } from 'react-i18next';

// Components
import { WizardProgress } from './components/wizard/WizardProgress';
import { ServiceStep } from './components/wizard/ServiceStep';
import { StaffStep } from './components/wizard/StaffStep';
import { ClientStep } from './components/wizard/ClientStep';
import { SuccessStep } from './components/wizard/SuccessStep';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

type Step = 'services' | 'staff' | 'clients' | 'success';

export default function BusinessSetupWizard() {
    const { t } = useTranslation();
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
                sin: staffData.sin
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

    return (
        <div data-cy="page.container" style={{ maxWidth: '800px', margin: '2rem auto', padding: '0 1rem' }}>
            <div style={{ textAlign: 'center', marginBottom: '3rem' }}>
                <h1 data-cy="page.title" style={{ fontSize: '2rem', fontWeight: '800', color: '#111827', marginBottom: '0.5rem' }}>{t(ContentRegistry.SETUP_WIZARD.TITLE)}</h1>
                <p style={{ color: '#6b7280' }}>{t(ContentRegistry.SETUP_WIZARD.SUBTITLE)}</p>
            </div>

            <WizardProgress currentStep={currentStep} />

            <div style={{ background: 'white', padding: '2.5rem', borderRadius: '1.5rem', border: '1px solid #e5e7eb', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)' }}>
                {currentStep === 'services' && (
                    <ServiceStep
                        data={serviceData}
                        setData={setServiceData}
                        onSubmit={handleServiceSubmit}
                        loading={loading}
                    />
                )}

                {currentStep === 'staff' && (
                    <StaffStep
                        data={staffData}
                        setData={setStaffData}
                        onBack={() => setCurrentStep('services')}
                        onSubmit={handleStaffSubmit}
                        loading={loading}
                    />
                )}

                {currentStep === 'clients' && (
                    <ClientStep
                        data={clientData}
                        setData={setClientData}
                        onBack={() => setCurrentStep('staff')}
                        onSubmit={handleClientSubmit}
                        loading={loading}
                    />
                )}

                {currentStep === 'success' && <SuccessStep />}
            </div>
        </div>
    );
}

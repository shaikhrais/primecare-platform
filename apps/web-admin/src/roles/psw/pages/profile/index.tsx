import React, { useState, useEffect, useCallback } from 'react';
import { Breadcrumb } from '../../components/Breadcrumb';
import { SecureSessionGuard } from '../../components/SecureSessionGuard';
import { apiClient } from '@/shared/utils/apiClient';
import { ApiRegistry } from 'prime-care-shared';

import { SectionContent } from './components/SectionContent';

export default function ProfilePage() {
    const [activeSection, setActiveSection] = useState('Personal');
    const [profileData, setProfileData] = useState<any>(null);
    const [isFetching, setIsFetching] = useState(true);
    const [isSaving, setIsSaving] = useState(false);
    const [message, setMessage] = useState<{ type: 'success' | 'error', text: string } | null>(null);

    const fetchProfile = useCallback(async () => {
        setIsFetching(true);
        try {
            const response = await apiClient.get(ApiRegistry.USER.PROFILE);
            if (response.ok) {
                const data = await response.json();
                setProfileData(data.profile || data);
            } else {
                setMessage({ type: 'error', text: 'Failed to load profile data.' });
            }
        } catch (error) {
            setMessage({ type: 'error', text: 'An error occurred while fetching profile.' });
        } finally {
            setIsFetching(false);
        }
    }, []);

    useEffect(() => {
        fetchProfile();
    }, [fetchProfile]);

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const { name, value } = e.target;
        setProfileData((prev: any) => ({ ...prev, [name]: value }));
    };

    const handleAvatarChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onloadend = () => {
            setProfileData((prev: any) => ({ ...prev, avatarUrl: reader.result as string }));
        };
        reader.readAsDataURL(file);
    };

    const handleSave = async () => {
        setIsSaving(true);
        setMessage(null);
        try {
            const response = await apiClient.put(ApiRegistry.USER.PROFILE, profileData);
            if (response.ok) {
                setMessage({ type: 'success', text: 'Profile updated successfully!' });
                setTimeout(() => setMessage(null), 3000);
            } else {
                setMessage({ type: 'error', text: 'Failed to save changes.' });
            }
        } catch (error) {
            setMessage({ type: 'error', text: 'Network error. Please try again.' });
        } finally {
            setIsSaving(false);
        }
    };

    if (isFetching) {
        return (
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', color: '#00875A' }}>
                <div style={{ fontWeight: 800, fontSize: '1.2rem' }}>Initializing Secure Profile...</div>
            </div>
        );
    }

    return (
        <SecureSessionGuard allowedRoles={['psw', 'admin']}>
            <div style={{ padding: '2.5rem', display: 'flex', flexDirection: 'column', gap: '2.5rem', maxWidth: '1400px', margin: '0 auto', animation: 'fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1)' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', borderBottom: '1px solid #E5E7EB', paddingBottom: '2rem' }}>
                    <div>
                        <Breadcrumb />
                        <h1 style={{ margin: '0.5rem 0 0 0', fontSize: '3rem', fontWeight: 900, color: '#111827', letterSpacing: '-1.5px' }}>Service Provider Profile</h1>
                        <p style={{ margin: '8px 0 0 0', color: '#6B7280', fontSize: '1.1rem', fontWeight: 500 }}>Manage your enterprise credentials and personal information</p>
                    </div>
                    {message && (
                        <div style={{
                            padding: '12px 24px',
                            backgroundColor: message.type === 'success' ? '#E6F4EF' : '#FEE2E2',
                            color: message.type === 'success' ? '#00875A' : '#B91C1C',
                            borderRadius: '16px',
                            fontWeight: 800,
                            fontSize: '0.95rem',
                            border: `1px solid ${message.type === 'success' ? '#00875A' : '#EF4444'}`,
                            animation: 'fadeIn 0.3s ease-in-out'
                        }}>
                            {message.type === 'success' ? '✓' : '⚠'} {message.text}
                        </div>
                    )}
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: '320px 1fr', gap: '3rem', alignItems: 'start' }}>
                    {/* --- LEFT SIDEBAR: PROFILE OVERVIEW & NAVIGATION --- */}
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem', position: 'sticky', top: '2rem' }}>
                        <div style={{
                            padding: '40px 32px',
                            backgroundColor: '#FFFFFF',
                            borderRadius: '32px',
                            border: '1px solid #E5E7EB',
                            boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.05)',
                            textAlign: 'center',
                            position: 'relative',
                            overflow: 'hidden'
                        }}>
                            <div style={{
                                position: 'absolute',
                                top: 0,
                                left: 0,
                                right: 0,
                                height: '80px',
                                background: 'linear-gradient(to right, #00875A, #000000)',
                                opacity: 0.1
                            }} />

                            <div
                                onClick={() => document.getElementById('avatar-input')?.click()}
                                style={{
                                    width: '140px',
                                    height: '140px',
                                    backgroundColor: '#00875A',
                                    borderRadius: '40px',
                                    margin: '0 auto 24px auto',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    fontSize: '3.5rem',
                                    color: 'white',
                                    fontWeight: 900,
                                    boxShadow: '0 20px 40px -10px rgba(0, 135, 90, 0.4)',
                                    position: 'relative',
                                    zIndex: 1,
                                    transform: 'rotate(-3deg)',
                                    cursor: 'pointer',
                                    overflow: 'hidden'
                                }}
                            >
                                {profileData?.avatarUrl ? (
                                    <img src={profileData.avatarUrl} alt="Avatar" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                                ) : (
                                    <>{profileData?.firstName?.[0]}{profileData?.lastName?.[0] || 'PSW'}</>
                                )}
                                <div style={{
                                    position: 'absolute',
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    background: 'rgba(0,0,0,0.5)',
                                    color: 'white',
                                    fontSize: '0.8rem',
                                    padding: '4px 0',
                                    opacity: 0,
                                    transition: 'opacity 0.2s',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center'
                                }}
                                    className="avatar-overlay"
                                >
                                    EDIT
                                </div>
                            </div>
                            <input
                                id="avatar-input"
                                type="file"
                                accept="image/*"
                                onChange={handleAvatarChange}
                                style={{ display: 'none' }}
                            />

                            <h2 style={{ margin: '0 0 8px 0', fontSize: '1.75rem', fontWeight: 900, color: '#111827', letterSpacing: '-0.5px' }}>
                                {profileData?.firstName} {profileData?.lastName}
                            </h2>
                            <div style={{
                                display: 'inline-flex',
                                alignItems: 'center',
                                gap: '8px',
                                padding: '6px 16px',
                                backgroundColor: '#000000',
                                color: 'white',
                                borderRadius: '20px',
                                fontSize: '0.75rem',
                                fontWeight: 800,
                                textTransform: 'uppercase',
                                letterSpacing: '1px',
                                marginBottom: '24px'
                            }}>
                                🛡️ Verified Service Provider
                            </div>

                            <div style={{
                                display: 'flex',
                                flexDirection: 'column',
                                gap: '12px',
                                borderTop: '1px solid #F3F4F6',
                                paddingTop: '24px',
                                color: '#4B5563',
                                fontSize: '0.95rem',
                                textAlign: 'left'
                            }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                    <span style={{ opacity: 0.5 }}>📧</span>
                                    <span style={{ fontWeight: 600 }}>{profileData?.email}</span>
                                </div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                    <span style={{ opacity: 0.5 }}>📅</span>
                                    <span>Joined {new Date(profileData?.createdAt || Date.now()).toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}</span>
                                </div>
                            </div>
                        </div>

                        <nav style={{
                            backgroundColor: '#FFFFFF',
                            borderRadius: '32px',
                            border: '1px solid #E5E7EB',
                            overflow: 'hidden',
                            padding: '8px'
                        }}>
                            {['Personal', 'Security', 'Notifications', 'Documents'].map(section => (
                                <button
                                    key={section}
                                    onClick={() => setActiveSection(section)}
                                    style={{
                                        width: '100%',
                                        padding: '16px 20px',
                                        textAlign: 'left',
                                        border: 'none',
                                        background: activeSection === section ? '#F9FAFB' : 'transparent',
                                        borderRadius: '20px',
                                        color: activeSection === section ? '#00875A' : '#4B5563',
                                        fontWeight: activeSection === section ? 900 : 600,
                                        fontSize: '1rem',
                                        cursor: 'pointer',
                                        transition: 'all 0.2s cubic-bezier(0.16, 1, 0.3, 1)',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'space-between'
                                    }}
                                >
                                    <span>{section}</span>
                                    {activeSection === section && <span style={{ fontSize: '1.2rem' }}>→</span>}
                                </button>
                            ))}
                        </nav>
                    </div>

                    {/* --- MAIN CONTENT: SECTION WELLS --- */}
                    <div style={{
                        backgroundColor: '#FFFFFF',
                        padding: '48px',
                        borderRadius: '40px',
                        border: '1px solid #E5E7EB',
                        minHeight: '700px',
                        boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.05)',
                        position: 'relative'
                    }}>
                        <SectionContent
                            activeSection={activeSection}
                            data={profileData}
                            onChange={handleInputChange}
                            onSave={handleSave}
                            isSaving={isSaving}
                        />
                    </div>
                </div>

                <style>{`
                    @keyframes fadeIn {
                        from { opacity: 0; transform: translateY(20px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                    input:focus {
                        border-color: #00875A !important;
                        box-shadow: 0 0 0 4px rgba(0, 135, 90, 0.1) !important;
                        outline: none;
                    }
                    button:active {
                        transform: scale(0.98);
                    }
                    div[onClick]:hover .avatar-overlay {
                        opacity: 1 !important;
                    }
                `}</style>
            </div>
        </SecureSessionGuard>
    );
}

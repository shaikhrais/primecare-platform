import React, { useState, useEffect } from 'react';
import { useNotification } from '../../App';

const API_URL = import.meta.env.VITE_API_URL;

export default function ProfilePage() {
    const { showToast } = useNotification();
    const [profile, setProfile] = useState<any>({ user: {} });
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);

    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const role = user.role;

    const fetchProfile = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const endpoint = role === 'psw' ? '/v1/psw/profile' : role === 'admin' || role === 'staff' ? '/v1/user/profile' : '/v1/client/profile';
            const response = await fetch(`${API_URL}${endpoint}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setProfile(data);
            } else if (response.status === 403 || response.status === 404) {
                // Fallback to local user data if profile endpoint not found for this role
                setProfile({ ...user, fullName: user.fullName || user.email?.split('@')[0] });
            }
        } catch (error) {
            console.error('Failed to fetch profile', error);
            showToast('Failed to load profile data', 'error');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchProfile();
    }, []);

    const handleSave = async (e: React.FormEvent) => {
        e.preventDefault();
        setSaving(true);
        try {
            const token = localStorage.getItem('token');
            const endpoint = role === 'psw' ? '/v1/psw/profile' : '/v1/client/profile';
            const response = await fetch(`${API_URL}${endpoint}`, {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(profile)
            });
            if (response.ok) {
                showToast('Profile updated successfully!', 'success');
            }
        } catch (error) {
            showToast('Failed to update profile', 'error');
        } finally {
            setSaving(false);
        }
    };

    if (loading) return <div style={{ padding: '2rem', textAlign: 'center' }}>Loading profile...</div>;

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '1rem' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }}>Account Profile</h2>
                <p style={{ color: '#6b7280' }}>Manage your personal information and preferences.</p>
            </div>

            <form onSubmit={handleSave} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Full Name</label>
                        <input
                            data-cy="inp-fullname"
                            type="text"
                            value={profile.fullName || ''}
                            onChange={(e) => setProfile({ ...profile, fullName: e.target.value })}
                            style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    {role === 'psw' ? (
                        <div style={{ gridColumn: 'span 2' }}>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Professional Bio</label>
                            <textarea
                                data-cy="inp-bio"
                                value={profile.bio || ''}
                                onChange={(e) => setProfile({ ...profile, bio: e.target.value })}
                                rows={4}
                                style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                    ) : (
                        <>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Address</label>
                                <input
                                    data-cy="inp-address"
                                    type="text"
                                    value={profile.addressLine1 || ''}
                                    onChange={(e) => setProfile({ ...profile, addressLine1: e.target.value })}
                                    style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                                />
                            </div>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>City</label>
                                <input
                                    data-cy="inp-city"
                                    type="text"
                                    value={profile.city || ''}
                                    onChange={(e) => setProfile({ ...profile, city: e.target.value })}
                                    style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                                />
                            </div>
                        </>
                    )}

                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Email (Unchangeable)</label>
                        <input
                            data-cy="inp-email-readonly"
                            type="email"
                            value={profile.user?.email || ''}
                            disabled
                            style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #e5e7eb', backgroundColor: '#f9fafb' }}
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Phone</label>
                        <input
                            data-cy="inp-phone-readonly"
                            type="text"
                            value={profile.user?.phone || ''}
                            disabled
                            style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #e5e7eb', backgroundColor: '#f9fafb' }}
                        />
                    </div>
                </div>

                <div style={{ marginTop: '2rem', display: 'flex', justifyContent: 'flex-end' }}>
                    <button
                        data-cy="btn-save-profile"
                        type="submit"
                        disabled={saving}
                        style={{
                            padding: '0.75rem 1.5rem',
                            backgroundColor: '#004d40',
                            color: 'white',
                            border: 'none',
                            borderRadius: '0.5rem',
                            fontWeight: '600',
                            cursor: 'pointer',
                            opacity: saving ? 0.7 : 1
                        }}
                    >
                        {saving ? 'Saving...' : 'Save Changes'}
                    </button>
                </div>
            </form>
        </div>
    );
}

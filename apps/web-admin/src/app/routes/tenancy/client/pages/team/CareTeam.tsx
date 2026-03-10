import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

interface TeamMember {
    id: string;
    name: string;
    role: string;
    specialty: string;
    rating: number;
    visits: number;
    bio: string;
}

export default function CareTeam() {
    const { t } = useTranslation();
    const [team] = useState<TeamMember[]>([
        { id: '1', name: 'Sarah Jenkins', role: 'Primary PSW', specialty: 'Dementia Care', rating: 4.9, visits: 124, bio: 'Sarah has over 8 years of experience in geriatric support and specialized memory care.' },
        { id: '2', name: 'Michael Chen', role: 'Relief PSW', specialty: 'Post-Op Recovery', rating: 4.8, visits: 42, bio: 'Michael specializes in assisting clients during their recovery from major orthopedic surgeries.' },
        { id: '3', name: 'Nurse Sarah', role: 'Nursing Lead', specialty: 'Clinical Oversight', rating: 5.0, visits: 12, bio: 'Sarah oversees clinical protocols and medication management for high-complexity clients.' },
    ]);

    return (
        <div style={{ padding: '2rem', maxWidth: '1200px', margin: '0 auto', fontFamily: 'var(--font-sans)', display: 'flex', flexDirection: 'column', gap: '2rem' }}>
            <header style={{
                display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#FFFFFF', border: '1px solid var(--line)',
                padding: '2.5rem', borderRadius: '1.5rem', boxShadow: 'var(--shadow-sm)', position: 'relative', overflow: 'hidden'
            }}>
                <div style={{ position: 'absolute', top: '0', right: '0', padding: '2rem', opacity: '0.05', fontSize: '6rem', transform: 'rotate(12deg) translateY(-1rem)' }}>
                    🤝
                </div>
                <div>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.5rem' }}>
                        <span style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: '#10B981' }} />
                        <span style={{ fontSize: '10px', fontWeight: '900', textTransform: 'uppercase', letterSpacing: '0.1em', color: '#059669' }}>Active Care Circle</span>
                    </div>
                    <h1 style={{ fontSize: '2rem', fontWeight: '900', letterSpacing: '-0.02em', textTransform: 'uppercase', margin: '0', color: 'var(--text-100)' }}>My Care Team</h1>
                    <p style={{ color: 'var(--text-300)', fontWeight: '500', marginTop: '0.5rem' }}>Meet the dedicated professionals supporting your family's health journey.</p>
                </div>
            </header>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '2rem' }}>
                {team.map(member => (
                    <div key={member.id} style={{
                        backgroundColor: '#FFFFFF', border: '1px solid var(--line)', borderRadius: '1.5rem', padding: '2rem',
                        transition: 'all 0.2s ease', position: 'relative', overflow: 'hidden', boxShadow: 'var(--shadow-sm)'
                    }}
                        onMouseEnter={(e) => { e.currentTarget.style.borderColor = 'var(--brand-300)'; e.currentTarget.style.boxShadow = 'var(--shadow-md)'; }}
                        onMouseLeave={(e) => { e.currentTarget.style.borderColor = 'var(--line)'; e.currentTarget.style.boxShadow = 'var(--shadow-sm)'; }}
                    >
                        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center', gap: '1.5rem', position: 'relative', zIndex: 10 }}>
                            <div style={{ position: 'relative' }}>
                                <div style={{
                                    width: '8rem', height: '8rem', borderRadius: '1.25rem', backgroundColor: '#F4F4F5', border: '4px solid #FFFFFF',
                                    boxShadow: 'var(--shadow-lg)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2.5rem', fontWeight: '900', color: 'var(--text-200)'
                                }}>
                                    {member.name.split(' ').map(n => n[0]).join('')}
                                </div>
                                <div style={{
                                    position: 'absolute', bottom: '-0.5rem', right: '-0.5rem', backgroundColor: '#FFFFFF', padding: '0.25rem 0.75rem',
                                    borderRadius: '9999px', border: '1px solid var(--line)', boxShadow: 'var(--shadow-sm)', display: 'flex', alignItems: 'center', gap: '0.25rem'
                                }}>
                                    <span style={{ fontSize: '10px', fontWeight: '900', color: '#F59E0B' }}>★</span>
                                    <span style={{ fontSize: '10px', fontWeight: '900', color: 'var(--text-100)' }}>{member.rating}</span>
                                </div>
                            </div>

                            <div>
                                <h3 style={{ fontSize: '1.25rem', fontWeight: '900', letterSpacing: '-0.02em', margin: '0', color: 'var(--text-100)' }}>{member.name}</h3>
                                <div style={{ fontSize: '10px', fontWeight: '900', textTransform: 'uppercase', letterSpacing: '0.1em', color: 'var(--brand-600)', marginTop: '0.25rem' }}>{member.role}</div>
                            </div>

                            <div style={{ backgroundColor: '#FAFAFA', border: '1px solid var(--line)', width: '100%', padding: '1rem', borderRadius: '1rem', display: 'flex', justifyContent: 'space-around' }}>
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '9px', fontWeight: '900', textTransform: 'uppercase', letterSpacing: '0.1em', color: 'var(--text-400)' }}>Visits</div>
                                    <div style={{ fontWeight: '900', fontSize: '0.875rem', color: 'var(--text-100)', marginTop: '0.25rem' }}>{member.visits}</div>
                                </div>
                                <div style={{ width: '1px', backgroundColor: 'var(--line)' }} />
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '9px', fontWeight: '900', textTransform: 'uppercase', letterSpacing: '0.1em', color: 'var(--text-400)' }}>Focus</div>
                                    <div style={{ fontWeight: '900', fontSize: '10px', textTransform: 'uppercase', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis', maxWidth: '80px', color: 'var(--text-100)', marginTop: '0.25rem' }}>{member.specialty}</div>
                                </div>
                            </div>

                            <p style={{ fontSize: '0.75rem', fontWeight: '500', color: 'var(--text-300)', lineHeight: '1.6', height: '3rem', overflow: 'hidden', textOverflow: 'ellipsis', fontStyle: 'italic', margin: '0' }}>
                                "{member.bio}"
                            </p>

                            <button style={{
                                width: '100%', backgroundColor: 'var(--text-100)', color: '#FFFFFF', padding: '1rem', borderRadius: '1rem',
                                fontWeight: '900', fontSize: '10px', textTransform: 'uppercase', letterSpacing: '0.1em', border: 'none', cursor: 'pointer', transition: 'background-color 0.2s ease', WebkitFontSmoothing: 'antialiased'
                            }}
                                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--brand-500)'}
                                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'var(--text-100)'}
                            >
                                Send Message
                            </button>
                        </div>
                    </div>
                ))}

                <div style={{
                    backgroundColor: '#FAFAFA', border: '2px dashed var(--line)', borderRadius: '1.5rem', padding: '2rem',
                    display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', textAlign: 'center', gap: '1rem', cursor: 'pointer', transition: 'all 0.2s ease'
                }}
                    onMouseEnter={(e) => { e.currentTarget.style.borderColor = 'var(--brand-300)'; e.currentTarget.style.backgroundColor = '#F5FBFA'; }}
                    onMouseLeave={(e) => { e.currentTarget.style.borderColor = 'var(--line)'; e.currentTarget.style.backgroundColor = '#FAFAFA'; }}
                >
                    <div style={{ fontSize: '2.25rem', opacity: '0.4', transition: 'opacity 0.2s ease' }}>➕</div>
                    <div>
                        <div style={{ fontWeight: '900', fontSize: '0.875rem', textTransform: 'uppercase', letterSpacing: '0.1em', color: 'var(--text-300)', transition: 'color 0.2s ease' }}>Request Specialist</div>
                        <p style={{ fontSize: '10px', fontWeight: '500', color: 'var(--text-400)', marginTop: '0.5rem', padding: '0 1.5rem', lineHeight: '1.6' }}>Need a physical therapist or specialized RMT? Call coordinate to add to team.</p>
                    </div>
                </div>
            </div>

            <div style={{ backgroundColor: '#FFFBEB', border: '2px solid #FEF3C7', padding: '2rem', borderRadius: '1.5rem', display: 'flex', alignItems: 'center', gap: '2rem' }}>
                <div style={{ backgroundColor: '#FEF3C7', padding: '1.5rem', borderRadius: '1rem', fontSize: '2rem' }}>🔐</div>
                <div>
                    <h3 style={{ fontSize: '0.875rem', fontWeight: '900', textTransform: 'uppercase', letterSpacing: '0.1em', color: '#78350F', margin: '0 0 0.5rem 0' }}>Clinically Verified Network</h3>
                    <p style={{ fontSize: '0.75rem', fontWeight: '500', color: '#92400E', lineHeight: '1.6', maxWidth: '42rem', margin: '0' }}>
                        Every professional in your care circle has undergone a mandatory criminal background check, vulnerable sector screening, and rigorous clinical credential verification.
                    </p>
                </div>
            </div>
        </div>
    );
}

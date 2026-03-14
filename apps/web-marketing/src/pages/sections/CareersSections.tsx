/**
 * CareersPage Data + Sub-Components
 * Extracted from CareersPage.tsx
 */
import React from 'react';
import { Link } from 'react-router-dom';
import { AnimatedSection } from '../../components/landing';

export interface JobListing {
    id: string; title: string; department: string; location: string; type: string; description: string;
}

export const jobListings: JobListing[] = [
    { id: '1', title: 'Personal Support Worker (PSW)', department: 'Care', location: 'Toronto, GTA', type: 'Full-time / Part-time', description: 'Provide compassionate care to seniors in their homes. Flexible scheduling available.' },
    { id: '2', title: 'Registered Practical Nurse (RPN)', department: 'Nursing', location: 'Toronto, GTA', type: 'Full-time', description: 'Join our nursing team providing foot care and wound care services.' },
    { id: '3', title: 'Foot Care Nurse', department: 'Nursing', location: 'Toronto, GTA', type: 'Contract', description: 'Certified foot care nurse to provide diabetic foot care services at client homes and facilities.' },
    { id: '4', title: 'Care Coordinator', department: 'Admin', location: 'Toronto (Hybrid)', type: 'Full-time', description: 'Coordinate care schedules, liaise with families, and manage caregiver assignments.' },
    { id: '5', title: 'Healthcare IT Specialist', department: 'IT', location: 'Remote', type: 'Full-time', description: 'Support EMR systems, develop healthcare applications, and ensure HIPAA compliance.' },
];

export const benefits = [
    { icon: '💰', title: 'Competitive Pay', text: 'Above-market wages with regular performance reviews' },
    { icon: '📚', title: 'Training & Development', text: 'Free continuing education and certification programs' },
    { icon: '⏰', title: 'Flexible Scheduling', text: 'Choose shifts that work for your lifestyle' },
    { icon: '🏥', title: 'Health Benefits', text: 'Medical and dental coverage for full-time staff' },
    { icon: '🚗', title: 'Travel Allowance', text: 'Mileage reimbursement for client visits' },
    { icon: '🎯', title: 'Career Growth', text: 'Clear paths for advancement within the company' },
];

export function BenefitsSection() {
    return (
        <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp"><h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '3rem', color: '#333' }}>Why Work With Us?</h2></AnimatedSection>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '2rem' }}>
                    {benefits.map((benefit, index) => (
                        <AnimatedSection key={index} animation="slideUp" delay={index * 0.1}>
                            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.05)', textAlign: 'center' }}>
                                <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>{benefit.icon}</div>
                                <h3 style={{ fontSize: '1.25rem', marginBottom: '0.5rem', color: '#00897b' }}>{benefit.title}</h3>
                                <p style={{ color: '#666' }}>{benefit.text}</p>
                            </div>
                        </AnimatedSection>
                    ))}
                </div>
            </div>
        </section>
    );
}

export function JobListingsSection({ selectedDepartment, setSelectedDepartment }: { selectedDepartment: string; setSelectedDepartment: (d: string) => void }) {
    const departments = ['all', ...new Set(jobListings.map(j => j.department))];
    const filteredJobs = selectedDepartment === 'all' ? jobListings : jobListings.filter(j => j.department === selectedDepartment);
    return (
        <section style={{ padding: '5rem 2rem' }}>
            <div style={{ maxWidth: '1000px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp"><h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '1rem', color: '#333' }}>Open Positions</h2><p style={{ textAlign: 'center', color: '#666', marginBottom: '2rem' }}>Find your next opportunity with us</p></AnimatedSection>
                <div style={{ display: 'flex', justifyContent: 'center', gap: '0.5rem', marginBottom: '2rem', flexWrap: 'wrap' }}>
                    {departments.map(dept => (
                        <button key={dept} data-cy={`filter-${dept}`} onClick={() => setSelectedDepartment(dept)} style={{ padding: '0.5rem 1rem', border: 'none', borderRadius: '50px', backgroundColor: selectedDepartment === dept ? '#00897b' : '#e0e0e0', color: selectedDepartment === dept ? 'white' : '#333', cursor: 'pointer', textTransform: 'capitalize', transition: 'all 0.2s' }}>{dept}</button>
                    ))}
                </div>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    {filteredJobs.map((job, index) => (
                        <AnimatedSection key={job.id} animation="fadeInUp" delay={index * 0.1}>
                            <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '12px', boxShadow: '0 2px 10px rgba(0,0,0,0.05)', border: '1px solid #eee' }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', flexWrap: 'wrap', gap: '1rem' }}>
                                    <div>
                                        <h3 style={{ fontSize: '1.25rem', marginBottom: '0.5rem', color: '#333' }}>{job.title}</h3>
                                        <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap', fontSize: '0.875rem', color: '#666' }}>
                                            <span data-cy="job-location">📍 {job.location}</span><span data-cy="job-dept">🏢 {job.department}</span><span data-cy="job-type">⏰ {job.type}</span>
                                        </div>
                                        <p style={{ marginTop: '1rem', color: '#666' }} data-cy="job-desc">{job.description}</p>
                                    </div>
                                    <Link to={`/careers/apply/${job.id}`} data-cy={`btn-apply-${job.id}`} style={{ padding: '0.75rem 1.5rem', backgroundColor: '#00897b', color: 'white', textDecoration: 'none', borderRadius: '8px', fontWeight: 'bold', whiteSpace: 'nowrap' }}>Apply Now</Link>
                                </div>
                            </div>
                        </AnimatedSection>
                    ))}
                </div>
            </div>
        </section>
    );
}

export function GeneralApplicationCTA() {
    return (
        <section style={{ padding: '5rem 2rem', background: 'linear-gradient(135deg, #00897b 0%, #00695c 100%)', color: 'white', textAlign: 'center' }}>
            <AnimatedSection animation="fadeInUp">
                <h2 style={{ fontSize: '2rem', marginBottom: '1rem' }}>Don't See the Right Fit?</h2>
                <p style={{ fontSize: '1.1rem', marginBottom: '2rem', opacity: 0.9 }}>Submit your resume for future opportunities. We're always looking for talented healthcare professionals.</p>
                <Link to="/careers/general-application" data-cy="btn-general-application" style={{ display: 'inline-block', padding: '1rem 2rem', backgroundColor: 'white', color: '#00897b', textDecoration: 'none', borderRadius: '50px', fontWeight: 'bold' }}>Submit General Application</Link>
            </AnimatedSection>
        </section>
    );
}

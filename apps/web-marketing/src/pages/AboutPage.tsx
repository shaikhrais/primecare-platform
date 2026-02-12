import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function AboutPage() {
    const team = [
        {
            name: 'Dr. Sarah Mitchell',
            role: 'Founder & CEO',
            image: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=300&h=300&fit=crop&crop=face',
            bio: 'With over 20 years in healthcare, Sarah founded PrimeCare to transform home care delivery.',
        },
        {
            name: 'Michael Chen',
            role: 'Director of Operations',
            image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop&crop=face',
            bio: 'Michael ensures seamless care coordination with 15 years of healthcare management experience.',
        },
        {
            name: 'Dr. Emily Brown',
            role: 'Clinical Director',
            image: 'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=300&h=300&fit=crop&crop=face',
            bio: 'Emily oversees clinical standards and training, ensuring top-quality care for every client.',
        },
        {
            name: 'James Wilson',
            role: 'Head of Education',
            image: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop&crop=face',
            bio: 'James leads our healthcare education programs, training the next generation of caregivers.',
        },
    ];

    const milestones = [
        { year: '2010', event: 'PrimeCare founded in Toronto' },
        { year: '2013', event: 'Launched PSW training program' },
        { year: '2016', event: 'Expanded to Ontario-wide coverage' },
        { year: '2019', event: 'Introduced mobile care app' },
        { year: '2022', event: 'Achieved 5,000+ clients milestone' },
        { year: '2024', event: 'Launched IT healthcare solutions' },
    ];

    return (
        <div style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }} data-cy="about-page-container">
            <Helmet>
                <title>About Us | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content="Learn about PrimeCare's mission to deliver compassionate, professional healthcare services in the comfort of your home." />
            </Helmet>

            {/* Hero */}
            <header style={{
                background: `linear-gradient(135deg, rgba(0,77,64,0.9) 0%, rgba(0,105,92,0.85) 100%), url('https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=1920&q=80')`,
                backgroundSize: 'cover',
                backgroundPosition: 'center',
                color: 'white',
                padding: '6rem 2rem',
                textAlign: 'center',
            }}>
                <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>
                    About {ContentRegistry.APP.NAME}
                </h1>
                <p style={{ fontSize: '1.25rem', opacity: 0.95, maxWidth: '700px', margin: '0 auto' }}>
                    Dedicated to delivering compassionate, professional healthcare in the comfort of your home since 2010.
                </p>
            </header>

            {/* Mission */}
            <section style={{ padding: '5rem 2rem' }}>
                <div style={{
                    maxWidth: '1200px',
                    margin: '0 auto',
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))',
                    gap: '4rem',
                    alignItems: 'center',
                }}>
                    <div>
                        <h2 style={{ fontSize: '2.5rem', marginBottom: '1.5rem', color: '#00897b' }}>
                            {ContentRegistry.ABOUT.MISSION}
                        </h2>
                        <p style={{ fontSize: '1.2rem', lineHeight: '1.8', color: '#444', marginBottom: '2rem' }} data-cy="about-mission-text">
                            {ContentRegistry.ABOUT.MISSION_TEXT}
                        </p>
                        <p style={{ fontSize: '1.1rem', lineHeight: '1.8', color: '#666' }}>
                            At PrimeCare, we believe that quality healthcare should be accessible to everyone,
                            regardless of age or ability. Our team of certified professionals is committed
                            to providing personalized care that respects the dignity and independence of every client.
                        </p>
                    </div>
                    <div>
                        <img
                            src="https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=600&q=80"
                            alt="Healthcare team"
                            style={{
                                width: '100%',
                                borderRadius: '20px',
                                boxShadow: '0 20px 50px rgba(0,0,0,0.15)',
                            }}
                        />
                    </div>
                </div>
            </section>

            {/* Values */}
            <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto', textAlign: 'center' }}>
                    <h2 style={{ fontSize: '2.5rem', marginBottom: '1rem', color: '#333' }}>Our Core Values</h2>
                    <p style={{ fontSize: '1.2rem', color: '#666', marginBottom: '4rem', maxWidth: '600px', margin: '0 auto 4rem auto' }}>
                        These principles guide everything we do
                    </p>

                    <div style={{
                        display: 'grid',
                        gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                        gap: '2rem'
                    }}>
                        {ContentRegistry.ABOUT.VALUES_LIST.map((value, index) => (
                            <div key={index} style={{
                                backgroundColor: 'white',
                                padding: '2.5rem',
                                borderRadius: '16px',
                                boxShadow: '0 4px 20px rgba(0,0,0,0.05)',
                            }}>
                                <div style={{
                                    width: '60px',
                                    height: '60px',
                                    backgroundColor: '#e0f2f1',
                                    borderRadius: '50%',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    margin: '0 auto 1.5rem auto',
                                    fontSize: '1.5rem',
                                    color: '#00897b',
                                }}>
                                    {index === 0 ? '❤️' : index === 1 ? '⭐' : index === 2 ? '🤝' : '🎯'}
                                </div>
                                <h3 style={{ fontSize: '1.25rem', marginBottom: '1rem', color: '#00897b' }}>
                                    {value.title}
                                </h3>
                                <p style={{ color: '#666', lineHeight: '1.6' }}>{value.text}</p>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            {/* Timeline */}
            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                    <h2 style={{ fontSize: '2.5rem', textAlign: 'center', marginBottom: '4rem', color: '#333' }}>
                        Our Journey
                    </h2>

                    <div style={{ position: 'relative' }}>
                        <div style={{
                            position: 'absolute',
                            left: '50%',
                            transform: 'translateX(-50%)',
                            width: '2px',
                            height: '100%',
                            backgroundColor: '#e0f2f1',
                        }} />

                        {milestones.map((milestone, index) => (
                            <div
                                key={index}
                                style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    marginBottom: '2rem',
                                    position: 'relative',
                                }}
                            >
                                <div style={{
                                    width: '50%',
                                    paddingRight: index % 2 === 0 ? '3rem' : 0,
                                    paddingLeft: index % 2 === 0 ? 0 : '3rem',
                                    textAlign: index % 2 === 0 ? 'right' : 'left',
                                    order: index % 2 === 0 ? 1 : 2,
                                }}>
                                    <div style={{ fontWeight: 'bold', color: '#00897b', fontSize: '1.25rem' }}>
                                        {milestone.year}
                                    </div>
                                    <div style={{ color: '#666' }}>{milestone.event}</div>
                                </div>
                                <div style={{
                                    width: '20px',
                                    height: '20px',
                                    backgroundColor: '#00897b',
                                    borderRadius: '50%',
                                    position: 'absolute',
                                    left: '50%',
                                    transform: 'translateX(-50%)',
                                    zIndex: 1,
                                }} />
                                <div style={{ width: '50%', order: index % 2 === 0 ? 2 : 1 }} />
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            {/* Team */}
            <section style={{ padding: '5rem 2rem', backgroundColor: '#f0f9f8' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto', textAlign: 'center' }}>
                    <h2 style={{ fontSize: '2.5rem', marginBottom: '1rem', color: '#333' }}>Our Leadership Team</h2>
                    <p style={{ fontSize: '1.2rem', color: '#666', marginBottom: '4rem' }}>
                        Meet the people dedicated to your care
                    </p>

                    <div style={{
                        display: 'grid',
                        gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                        gap: '2rem'
                    }}>
                        {team.map((member, index) => (
                            <div key={index} style={{
                                backgroundColor: 'white',
                                borderRadius: '16px',
                                overflow: 'hidden',
                                boxShadow: '0 4px 20px rgba(0,0,0,0.05)',
                            }}>
                                <img
                                    src={member.image}
                                    alt={member.name}
                                    style={{
                                        width: '100%',
                                        height: '250px',
                                        objectFit: 'cover',
                                    }}
                                />
                                <div style={{ padding: '1.5rem' }}>
                                    <h3 style={{ fontSize: '1.25rem', marginBottom: '0.25rem', color: '#333' }}>
                                        {member.name}
                                    </h3>
                                    <div style={{ color: '#00897b', fontWeight: 'bold', marginBottom: '1rem' }}>
                                        {member.role}
                                    </div>
                                    <p style={{ color: '#666', fontSize: '0.9rem', lineHeight: '1.6' }}>
                                        {member.bio}
                                    </p>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            {/* CTA */}
            <section style={{
                padding: '5rem 2rem',
                background: 'linear-gradient(135deg, #00897b 0%, #00695c 100%)',
                color: 'white',
                textAlign: 'center',
            }}>
                <h2 style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>Ready to Start Your Care Journey?</h2>
                <p style={{ fontSize: '1.25rem', marginBottom: '2rem', opacity: 0.9 }}>
                    Contact us today to learn how we can help you or your loved ones.
                </p>
                <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center', flexWrap: 'wrap' }}>
                    <Link
                        to={RouteRegistry.BOOKING}
                        data-cy="btn-about-booking"
                        style={{
                            padding: '1rem 2.5rem',
                            backgroundColor: 'white',
                            color: '#00897b',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontWeight: 'bold',
                        }}
                    >
                        Book Consultation
                    </Link>
                    <Link
                        to={RouteRegistry.CAREERS}
                        data-cy="btn-about-careers"
                        style={{
                            padding: '1rem 2.5rem',
                            backgroundColor: 'transparent',
                            color: 'white',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontWeight: 'bold',
                            border: '2px solid white',
                        }}
                    >
                        Join Our Team
                    </Link>
                </div>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>
                    ← Back to Home
                </Link>
            </div>
        </div>
    );
}

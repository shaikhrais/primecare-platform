import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export function MissionSection() {
    return (
        <section style={{
            padding: '6rem 2rem',
            background: 'linear-gradient(135deg, #004d40 0%, #00695c 100%)',
            color: 'white',
            textAlign: 'center',
        }}>
            <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                <h2 style={{ fontSize: '2.5rem', marginBottom: '1.5rem' }}>
                    {ContentRegistry.ABOUT.MISSION}
                </h2>
                <p style={{ fontSize: '1.3rem', lineHeight: '1.8', opacity: 0.95, marginBottom: '3rem' }}>
                    {ContentRegistry.ABOUT.MISSION_TEXT}
                </p>
                <Link
                    to={RouteRegistry.ABOUT}
                    style={{
                        display: 'inline-block',
                        padding: '1rem 2.5rem',
                        backgroundColor: 'white',
                        color: '#004d40',
                        textDecoration: 'none',
                        borderRadius: '50px',
                        fontWeight: 'bold',
                        fontSize: '1.1rem',
                    }}
                >
                    Learn About Us
                </Link>
            </div>
        </section>
    );
}

export default MissionSection;

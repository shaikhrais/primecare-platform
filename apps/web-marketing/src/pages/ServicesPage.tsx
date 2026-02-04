import React, { useEffect, useState } from 'react';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry, ApiRegistry } = MarketingRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Service {
    id: string;
    name: string;
    description: string;
    price: number;
}

export default function ServicesPage() {
    const [services, setServices] = useState<Service[]>([]);

    useEffect(() => {
        fetch(`${API_URL}${ApiRegistry.PUBLIC.SERVICES}`)
            .then(res => res.json())
            .then(data => setServices(data))
            .catch(err => console.error(err));
    }, []);

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif', maxWidth: '1200px', margin: '0 auto', padding: '4rem 2rem' }}>
            <h1 style={{ fontSize: '3rem', textAlign: 'center', marginBottom: '1rem', color: '#004d40' }}>{ContentRegistry.SERVICES.TITLE}</h1>
            <p style={{ textAlign: 'center', fontSize: '1.2rem', color: '#666', marginBottom: '4rem' }}>{ContentRegistry.SERVICES.SUBTITLE}</p>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '2rem' }}>
                {services.map(service => (
                    <div key={service.id} style={{ padding: '2rem', border: '1px solid #eee', borderRadius: '12px', boxShadow: '0 4px 6px rgba(0,0,0,0.05)' }}>
                        <h3 style={{ fontSize: '1.5rem', marginBottom: '0.5rem', color: '#333' }}>{service.name}</h3>
                        <div style={{ fontSize: '1.25rem', fontWeight: 'bold', color: '#004d40', marginBottom: '1rem' }}>${service.price} / hour</div>
                        <p style={{ color: '#666', lineHeight: '1.6' }}>{service.description}</p>
                    </div>
                ))}
            </div>
        </div>
    );
}

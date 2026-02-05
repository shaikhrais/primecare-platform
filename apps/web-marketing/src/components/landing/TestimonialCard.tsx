import React from 'react';

interface TestimonialCardProps {
    quote: string;
    author: string;
    role: string;
    image: string;
}

export function TestimonialCard({ quote, author, role, image }: TestimonialCardProps) {
    return (
        <div style={{
            backgroundColor: 'white',
            padding: '2rem',
            borderRadius: '16px',
            boxShadow: '0 10px 40px rgba(0,0,0,0.08)',
            display: 'flex',
            flexDirection: 'column',
            gap: '1.5rem',
        }}>
            <p style={{ fontSize: '1.1rem', lineHeight: '1.8', color: '#444', fontStyle: 'italic' }}>
                "{quote}"
            </p>
            <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                <img
                    src={image}
                    alt={author}
                    style={{ width: '50px', height: '50px', borderRadius: '50%', objectFit: 'cover' }}
                />
                <div>
                    <div style={{ fontWeight: 'bold', color: '#333' }}>{author}</div>
                    <div style={{ fontSize: '0.875rem', color: '#666' }}>{role}</div>
                </div>
            </div>
        </div>
    );
}

export default TestimonialCard;

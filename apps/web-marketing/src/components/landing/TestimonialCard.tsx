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
            backgroundColor: 'var(--bg-800)',
            padding: '2.5rem',
            borderRadius: '12px',
            border: '1px solid var(--line)',
            display: 'flex',
            flexDirection: 'column',
            gap: '1.5rem',
            height: '100%'
        }}>
            <p style={{ fontSize: '1rem', lineHeight: '1.8', color: 'var(--text)', fontStyle: 'italic' }}>
                "{quote}"
            </p>
            <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginTop: 'auto' }}>
                <img
                    src={image}
                    alt={author}
                    style={{ width: '44px', height: '44px', borderRadius: '50%', objectFit: 'cover', border: '1px solid var(--line)' }}
                />
                <div>
                    <div style={{ fontWeight: '700', color: 'var(--text)', fontSize: '0.95rem' }}>{author}</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', fontWeight: 600 }}>{role}</div>
                </div>
            </div>
        </div>
    );
}

export default TestimonialCard;

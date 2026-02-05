import React from 'react';
import { AnimatedCounter } from './AnimatedCounter';

interface Stat {
    value: number;
    suffix: string;
    label: string;
}

interface StatsSectionProps {
    stats?: Stat[];
}

const defaultStats: Stat[] = [
    { value: 5000, suffix: '+', label: 'Clients Served' },
    { value: 98, suffix: '%', label: 'Satisfaction Rate' },
    { value: 250, suffix: '+', label: 'Certified Caregivers' },
    { value: 15, suffix: '+', label: 'Years Experience' },
];

export function StatsSection({ stats = defaultStats }: StatsSectionProps) {
    return (
        <section style={{
            padding: '5rem 2rem',
            backgroundColor: '#004d40',
            color: 'white',
        }}>
            <div style={{
                maxWidth: '1200px',
                margin: '0 auto',
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
                gap: '3rem',
                textAlign: 'center',
            }}>
                {stats.map((stat, index) => (
                    <div key={index}>
                        <div style={{ fontSize: '3.5rem', fontWeight: 'bold', marginBottom: '0.5rem' }}>
                            <AnimatedCounter end={stat.value} suffix={stat.suffix} />
                        </div>
                        <div style={{ fontSize: '1rem', opacity: 0.9 }}>{stat.label}</div>
                    </div>
                ))}
            </div>
        </section>
    );
}

export default StatsSection;

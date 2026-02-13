import React from 'react';
import { AnimatedCounter } from './AnimatedCounter';
import { AnimatedSection } from './AnimatedSection';

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
            padding: '7rem 2rem',
            backgroundColor: 'var(--bg-900)',
            color: 'var(--text)',
            borderTop: '1px solid var(--line)',
            borderBottom: '1px solid var(--line)',
        }}>
            <div style={{
                maxWidth: '1200px',
                margin: '0 auto',
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))',
                gap: '4rem',
                textAlign: 'center',
            }}>
                {stats.map((stat, index) => (
                    <AnimatedSection
                        key={index}
                        animation="scaleUp"
                        delay={index * 0.15}
                    >
                        <div
                            data-cy={`stat-item-${index}`}
                            style={{
                                transition: 'transform 0.3s ease, border-color 0.3s ease, box-shadow 0.3s ease',
                                border: '1px solid var(--line)',
                                borderRadius: '8px',
                                padding: '2rem',
                                backgroundColor: 'var(--bg-800)',
                                cursor: 'default'
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.transform = 'translateY(-8px)';
                                e.currentTarget.style.borderColor = 'var(--brand-500)';
                                e.currentTarget.style.boxShadow = '0 10px 30px rgba(0,0,0,0.05)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.transform = 'translateY(0)';
                                e.currentTarget.style.borderColor = 'var(--line)';
                                e.currentTarget.style.boxShadow = 'none';
                            }}
                        >
                            <div style={{ fontSize: '4.5rem', fontWeight: 900, marginBottom: '0.75rem', color: 'var(--brand-500)', letterSpacing: '-2px' }}>
                                <AnimatedCounter end={stat.value} suffix={stat.suffix} />
                            </div>
                            <div style={{ fontSize: '0.85rem', fontWeight: 800, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '3px' }}>{stat.label}</div>
                        </div>
                    </AnimatedSection>
                ))}
            </div>
        </section>
    );
}

export default StatsSection;

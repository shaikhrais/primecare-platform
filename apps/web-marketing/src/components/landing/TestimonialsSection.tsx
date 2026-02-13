import React from 'react';
import { TestimonialCard } from './TestimonialCard';
import { AnimatedSection } from './AnimatedSection';

interface Testimonial {
    quote: string;
    author: string;
    role: string;
    image: string;
}

interface TestimonialsSectionProps {
    testimonials?: Testimonial[];
}

const defaultTestimonials: Testimonial[] = [
    {
        quote: "PrimeCare has been a blessing for our family. The caregivers are compassionate, professional, and truly care about my mother's wellbeing.",
        author: "Sarah Thompson",
        role: "Family Member",
        image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop&crop=face",
    },
    {
        quote: "The foot care services have dramatically improved my mobility and quality of life. I can't recommend them enough!",
        author: "Robert Chen",
        role: "Client",
        image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face",
    },
    {
        quote: "As a healthcare administrator, I appreciate PrimeCare's commitment to training and professional development. Their education programs are top-notch.",
        author: "Dr. Emily Brown",
        role: "Healthcare Director",
        image: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=100&h=100&fit=crop&crop=face",
    },
];

export function TestimonialsSection({ testimonials = defaultTestimonials }: TestimonialsSectionProps) {
    return (
        <section style={{ padding: '8rem 2rem', backgroundColor: 'var(--bg-900)' }} data-cy="testimonials-section">
            <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2 style={{ fontSize: '3rem', textAlign: 'center', marginBottom: '1rem', color: 'var(--text)', fontWeight: 800 }} data-cy="testimonials-header">
                        What Our Clients Say
                    </h2>
                    <p style={{ textAlign: 'center', fontSize: '1.25rem', color: 'var(--text-muted)', marginBottom: '5rem', fontWeight: 500 }}>
                        Trusted by thousands of families across Ontario
                    </p>
                </AnimatedSection>

                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
                    gap: '2rem'
                }}>
                    {testimonials.map((testimonial, index) => (
                        <AnimatedSection
                            key={index}
                            animation="scaleUp"
                            delay={index * 0.15}
                        >
                            <TestimonialCard {...testimonial} />
                        </AnimatedSection>
                    ))}
                </div>
            </div>
        </section>
    );
}

export default TestimonialsSection;

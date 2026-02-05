import React from 'react';
import { TestimonialCard } from './TestimonialCard';

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
        <section style={{ padding: '6rem 2rem', backgroundColor: '#f0f9f8' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                <h2 style={{ fontSize: '2.5rem', textAlign: 'center', marginBottom: '1rem', color: '#333' }}>
                    What Our Clients Say
                </h2>
                <p style={{ textAlign: 'center', fontSize: '1.2rem', color: '#666', marginBottom: '4rem' }}>
                    Trusted by thousands of families across Ontario
                </p>

                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))',
                    gap: '2rem'
                }}>
                    {testimonials.map((testimonial, index) => (
                        <TestimonialCard key={index} {...testimonial} />
                    ))}
                </div>
            </div>
        </section>
    );
}

export default TestimonialsSection;

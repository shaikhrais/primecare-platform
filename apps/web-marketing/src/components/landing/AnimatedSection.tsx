import React, { useRef, useEffect, useState } from 'react';

type AnimationType = 'fadeIn' | 'slideUp' | 'slideLeft' | 'slideRight' | 'scaleUp' | 'fadeInUp';

interface AnimatedSectionProps {
    children: React.ReactNode;
    animation?: AnimationType;
    delay?: number;
    duration?: number;
    threshold?: number;
    className?: string;
    style?: React.CSSProperties;
}

const animations: Record<AnimationType, { initial: React.CSSProperties; animate: React.CSSProperties }> = {
    fadeIn: {
        initial: { opacity: 0 },
        animate: { opacity: 1 },
    },
    slideUp: {
        initial: { opacity: 0, transform: 'translateY(50px)' },
        animate: { opacity: 1, transform: 'translateY(0)' },
    },
    slideLeft: {
        initial: { opacity: 0, transform: 'translateX(50px)' },
        animate: { opacity: 1, transform: 'translateX(0)' },
    },
    slideRight: {
        initial: { opacity: 0, transform: 'translateX(-50px)' },
        animate: { opacity: 1, transform: 'translateX(0)' },
    },
    scaleUp: {
        initial: { opacity: 0, transform: 'scale(0.9)' },
        animate: { opacity: 1, transform: 'scale(1)' },
    },
    fadeInUp: {
        initial: { opacity: 0, transform: 'translateY(30px)' },
        animate: { opacity: 1, transform: 'translateY(0)' },
    },
};

export function AnimatedSection({
    children,
    animation = 'fadeInUp',
    delay = 0,
    duration = 0.6,
    threshold = 0.2,
    className,
    style,
}: AnimatedSectionProps) {
    const ref = useRef<HTMLDivElement>(null);
    const [isVisible, setIsVisible] = useState(false);

    useEffect(() => {
        const observer = new IntersectionObserver(
            ([entry]) => {
                if (entry.isIntersecting) {
                    setIsVisible(true);
                    observer.unobserve(entry.target);
                }
            },
            { threshold }
        );

        if (ref.current) {
            observer.observe(ref.current);
        }

        return () => observer.disconnect();
    }, [threshold]);

    const animationConfig = animations[animation];
    const currentStyles = isVisible ? animationConfig.animate : animationConfig.initial;

    return (
        <div
            ref={ref}
            className={className}
            style={{
                ...currentStyles,
                transition: `all ${duration}s cubic-bezier(0.4, 0, 0.2, 1) ${delay}s`,
                willChange: 'opacity, transform',
                ...style,
            }}
        >
            {children}
        </div>
    );
}

// Hook for custom animations
export function useScrollAnimation(threshold = 0.2) {
    const ref = useRef<HTMLDivElement>(null);
    const [isVisible, setIsVisible] = useState(false);

    useEffect(() => {
        const observer = new IntersectionObserver(
            ([entry]) => {
                if (entry.isIntersecting) {
                    setIsVisible(true);
                    observer.unobserve(entry.target);
                }
            },
            { threshold }
        );

        if (ref.current) {
            observer.observe(ref.current);
        }

        return () => observer.disconnect();
    }, [threshold]);

    return { ref, isVisible };
}

// Stagger animation for lists
interface StaggerContainerProps {
    children: React.ReactNode;
    staggerDelay?: number;
    animation?: AnimationType;
    className?: string;
    style?: React.CSSProperties;
}

export function StaggerContainer({
    children,
    staggerDelay = 0.1,
    animation = 'fadeInUp',
    className,
    style,
}: StaggerContainerProps) {
    const childArray = React.Children.toArray(children);

    return (
        <div className={className} style={style}>
            {childArray.map((child, index) => (
                <AnimatedSection
                    key={index}
                    animation={animation}
                    delay={index * staggerDelay}
                >
                    {child}
                </AnimatedSection>
            ))}
        </div>
    );
}

export default AnimatedSection;

import React, { useState, useEffect } from 'react';

interface AnimatedCounterProps {
    end: number;
    suffix?: string;
    duration?: number;
}

export function AnimatedCounter({ end, suffix = '', duration = 2000 }: AnimatedCounterProps) {
    const [count, setCount] = useState(0);
    const [hasAnimated, setHasAnimated] = useState(false);

    useEffect(() => {
        if (hasAnimated) return;

        const observer = new IntersectionObserver((entries) => {
            if (entries[0].isIntersecting && !hasAnimated) {
                setHasAnimated(true);
                let start = 0;
                const increment = end / (duration / 16);
                const timer = setInterval(() => {
                    start += increment;
                    if (start >= end) {
                        setCount(end);
                        clearInterval(timer);
                    } else {
                        setCount(Math.floor(start));
                    }
                }, 16);
            }
        }, { threshold: 0.5 });

        const element = document.getElementById(`counter-${end}`);
        if (element) observer.observe(element);

        return () => observer.disconnect();
    }, [end, duration, hasAnimated]);

    return <span id={`counter-${end}`}>{count.toLocaleString()}{suffix}</span>;
}

export default AnimatedCounter;

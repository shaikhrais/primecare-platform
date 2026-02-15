import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { RevenueTrendChart } from '../shared/components/charts/RevenueTrendChart';
import React from 'react';

// Mock ResizeObserver which is not available in JSDOM
class ResizeObserver {
    observe() { }
    unobserve() { }
    disconnect() { }
}
global.ResizeObserver = ResizeObserver;

describe('RevenueTrendChart', () => {
    it('renders correctly', () => {
        render(<RevenueTrendChart />);
        expect(screen.getByText('Revenue Trends')).toBeInTheDocument();
    });
});

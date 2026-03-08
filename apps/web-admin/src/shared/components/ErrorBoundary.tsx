import React from 'react';

interface ErrorBoundaryState {
    hasError: boolean;
    error: Error | null;
}

/**
 * #11: Global Error Boundary — catches React rendering errors
 * and shows a recovery UI instead of a white screen.
 */
export class ErrorBoundary extends React.Component<
    { children: React.ReactNode; fallback?: React.ReactNode },
    ErrorBoundaryState
> {
    constructor(props: any) {
        super(props);
        this.state = { hasError: false, error: null };
    }

    static getDerivedStateFromError(error: Error): ErrorBoundaryState {
        return { hasError: true, error };
    }

    componentDidCatch(error: Error, info: React.ErrorInfo) {
        console.error('[ErrorBoundary] Caught:', error, info.componentStack);
    }

    render() {
        if (this.state.hasError) {
            if (this.props.fallback) return this.props.fallback;

            return React.createElement('div', {
                style: {
                    display: 'flex', flexDirection: 'column' as const, alignItems: 'center',
                    justifyContent: 'center', minHeight: '60vh', padding: '40px',
                    fontFamily: "'Inter', system-ui, sans-serif", textAlign: 'center' as const,
                }
            },
                React.createElement('div', { style: { fontSize: 48, marginBottom: 16 } }, '⚠️'),
                React.createElement('h2', { style: { fontSize: 22, fontWeight: 700, color: '#0f172a', margin: '0 0 8px' } }, 'Something went wrong'),
                React.createElement('p', { style: { fontSize: 14, color: '#64748b', maxWidth: 400, margin: '0 0 24px' } },
                    this.state.error?.message || 'An unexpected error occurred. Please try again.'
                ),
                React.createElement('button', {
                    onClick: () => { this.setState({ hasError: false, error: null }); window.location.reload(); },
                    style: {
                        padding: '10px 24px', borderRadius: 8, border: 'none',
                        background: '#0284c7', color: '#fff', fontSize: 14,
                        fontWeight: 600, cursor: 'pointer',
                    }
                }, 'Reload Page')
            );
        }

        return this.props.children;
    }
}

export default ErrorBoundary;

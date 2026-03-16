import React, { Component, type ErrorInfo, type ReactNode } from 'react';

interface Props {
    children: ReactNode;
    /** Route name for contextual error messages */
    routeName?: string;
    /** Custom fallback UI */
    fallback?: ReactNode;
}

interface State {
    hasError: boolean;
    error: Error | null;
    errorInfo: ErrorInfo | null;
}

/**
 * RouteErrorBoundary — Per-route error isolation
 *
 * Wraps each route group so a crash in one page doesn't take down
 * the entire app. Shows a contextual recovery UI with retry button.
 */
export class RouteErrorBoundary extends Component<Props, State> {
    state: State = { hasError: false, error: null, errorInfo: null };

    static getDerivedStateFromError(error: Error): Partial<State> {
        return { hasError: true, error };
    }

    componentDidCatch(error: Error, errorInfo: ErrorInfo) {
        this.setState({ errorInfo });
        // Log to console in dev, would ship to Sentry in production
        console.error(`[RouteErrorBoundary:${this.props.routeName || 'unknown'}]`, error, errorInfo);
    }

    handleRetry = () => {
        this.setState({ hasError: false, error: null, errorInfo: null });
    };

    handleGoHome = () => {
        window.location.href = '/';
    };

    render() {
        if (this.state.hasError) {
            if (this.props.fallback) return this.props.fallback;

            return (
                <div style={{
                    display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
                    minHeight: '60vh', padding: '40px', textAlign: 'center',
                }}>
                    <div style={{
                        width: '80px', height: '80px', borderRadius: '50%',
                        background: 'linear-gradient(135deg, rgba(239,68,68,0.1), rgba(239,68,68,0.2))',
                        display: 'flex', alignItems: 'center', justifyContent: 'center',
                        marginBottom: '24px', fontSize: '2rem',
                    }}>
                        💥
                    </div>
                    <h2 style={{ margin: '0 0 8px', fontSize: '1.5rem', fontWeight: 800, color: 'var(--pc-text-primary)' }}>
                        Something went wrong
                    </h2>
                    <p style={{ margin: '0 0 8px', color: 'var(--pc-text-secondary)', fontSize: '0.9rem', maxWidth: '400px' }}>
                        {this.props.routeName
                            ? `The ${this.props.routeName} page encountered an error.`
                            : 'This page encountered an unexpected error.'}
                    </p>
                    <p style={{ margin: '0 0 24px', color: 'var(--pc-text-tertiary)', fontSize: '0.75rem', fontFamily: 'monospace' }}>
                        {this.state.error?.message}
                    </p>
                    <div style={{ display: 'flex', gap: '12px' }}>
                        <button onClick={this.handleRetry} style={{
                            padding: '10px 24px', borderRadius: '10px', border: 'none',
                            background: 'var(--pc-primary)', color: 'white',
                            fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                        }}>
                            🔄 Try Again
                        </button>
                        <button onClick={this.handleGoHome} style={{
                            padding: '10px 24px', borderRadius: '10px',
                            border: '1px solid var(--pc-border-primary)',
                            background: 'var(--pc-surface-card)', color: 'var(--pc-text-primary)',
                            fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                        }}>
                            🏠 Go Home
                        </button>
                    </div>
                </div>
            );
        }

        return this.props.children;
    }
}

import React, { type ReactNode } from 'react';

interface ErrorBoundaryProps {
    children: ReactNode;
    fallback?: (error: Error, retry: () => void) => ReactNode;
    /** Module name for structured error reporting */
    module?: string;
}

interface ErrorBoundaryState {
    hasError: boolean;
    error: Error | null;
    errorCount: number;
}

/**
 * ErrorBoundary — Catches uncaught React errors per-route
 *
 * Prevents a single component crash from taking down the entire app.
 * Provides retry (without full reload), structured error reporting, and detailed UI.
 */
export class ErrorBoundary extends React.Component<ErrorBoundaryProps, ErrorBoundaryState> {
    constructor(props: ErrorBoundaryProps) {
        super(props);
        this.state = { hasError: false, error: null, errorCount: 0 };
    }

    static getDerivedStateFromError(error: Error): Partial<ErrorBoundaryState> {
        return { hasError: true, error };
    }

    componentDidCatch(error: Error, info: React.ErrorInfo) {
        console.error(JSON.stringify({
            level: 'error',
            type: 'REACT_ERROR_BOUNDARY',
            timestamp: new Date().toISOString(),
            module: this.props.module || 'unknown',
            retryCount: this.state.errorCount,
            error: { name: error.name, message: error.message, stack: error.stack?.split('\n').slice(0, 5).join('\n') },
            componentStack: info.componentStack?.split('\n').slice(0, 5).join('\n'),
        }));
    }

    handleRetry = () => {
        this.setState(s => ({ hasError: false, error: null, errorCount: s.errorCount + 1 }));
    };

    render() {
        if (this.state.hasError && this.state.error) {
            if (this.props.fallback) return this.props.fallback(this.state.error, this.handleRetry);
            return <DefaultErrorFallback error={this.state.error} retry={this.handleRetry} module={this.props.module} />;
        }
        return this.props.children;
    }
}

const DefaultErrorFallback: React.FC<{ error: Error; retry: () => void; module?: string }> = ({ error, retry, module }) => (
    <div style={{
        display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
        minHeight: '300px', padding: '2rem', textAlign: 'center',
        fontFamily: "'Inter', system-ui, sans-serif",
    }}>
        <div style={{
            width: '64px', height: '64px', borderRadius: '50%', backgroundColor: '#FEE2E2',
            display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.5rem', marginBottom: '1rem',
        }}>⚠️</div>
        <h2 style={{ fontSize: '1.25rem', fontWeight: 700, color: '#0f172a', margin: '0 0 0.5rem' }}>
            Something went wrong
        </h2>
        <p style={{ fontSize: '0.875rem', color: '#64748b', maxWidth: '400px', margin: '0 0 1rem' }}>
            {module ? `An error occurred in the ${module} module. ` : ''}
            The error has been logged. You can try again or navigate to another page.
        </p>
        <details style={{ maxWidth: '500px', marginBottom: '1.5rem', textAlign: 'left', fontSize: '0.75rem', color: '#9CA3AF' }}>
            <summary style={{ cursor: 'pointer', marginBottom: '0.5rem' }}>Technical details</summary>
            <pre style={{
                padding: '0.75rem', borderRadius: '0.5rem', backgroundColor: '#F9FAFB',
                border: '1px solid #E5E7EB', overflow: 'auto', fontSize: '0.6875rem', lineHeight: 1.5,
            }}>
                {error.name}: {error.message}
                {error.stack && `\n\n${error.stack.split('\n').slice(1, 4).join('\n')}`}
            </pre>
        </details>
        <div style={{ display: 'flex', gap: '0.75rem' }}>
            <button
                onClick={retry}
                data-cy="error-retry-btn"
                style={{
                    padding: '0.5rem 1.25rem', borderRadius: '0.5rem',
                    backgroundColor: '#3B82F6', color: '#fff', border: 'none',
                    fontSize: '0.875rem', fontWeight: 600, cursor: 'pointer',
                }}
            >Try Again</button>
            <button
                onClick={() => window.location.href = '/'}
                data-cy="error-home-btn"
                style={{
                    padding: '0.5rem 1.25rem', borderRadius: '0.5rem',
                    backgroundColor: '#F3F4F6', color: '#374151', border: '1px solid #D1D5DB',
                    fontSize: '0.875rem', fontWeight: 600, cursor: 'pointer',
                }}
            >Go Home</button>
        </div>
    </div>
);

/** Convenience wrapper for lazy-loaded route modules */
export const RouteErrorBoundary: React.FC<{ module: string; children: ReactNode }> = ({ module, children }) => (
    <ErrorBoundary module={module}>{children}</ErrorBoundary>
);

export default ErrorBoundary;


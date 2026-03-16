import React from 'react';

/**
 * SkipNav — Accessibility skip navigation link
 *
 * Invisible until focused via Tab key. Allows keyboard users to
 * skip directly to main content, bypassing the sidebar/nav.
 *
 * Must be the FIRST focusable element in the DOM.
 * Pair with: <main id="main-content"> on the main content area.
 */
export const SkipNav: React.FC = () => (
    <a
        href="#main-content"
        style={{
            position: 'fixed',
            top: '-100px',
            left: '16px',
            zIndex: 100000,
            padding: '12px 24px',
            borderRadius: '0 0 10px 10px',
            background: 'var(--pc-primary)',
            color: 'white',
            fontWeight: 700,
            fontSize: '0.9rem',
            textDecoration: 'none',
            transition: 'top 0.2s ease',
            boxShadow: '0 4px 20px rgba(0,0,0,0.3)',
        }}
        onFocus={(e) => { e.currentTarget.style.top = '0'; }}
        onBlur={(e) => { e.currentTarget.style.top = '-100px'; }}
    >
        Skip to main content
    </a>
);

/**
 * AriaLive — Screen reader announcement region
 *
 * Use to announce dynamic content changes (route transitions,
 * toast notifications, form errors) to assistive technology.
 *
 * Usage:
 *   <AriaLive message="3 visits loaded" />
 *   <AriaLive message="Form submitted!" assertive />
 */
export const AriaLive: React.FC<{ message: string; assertive?: boolean }> = ({ message, assertive }) => (
    <div
        role="status"
        aria-live={assertive ? 'assertive' : 'polite'}
        aria-atomic="true"
        style={{
            position: 'absolute',
            width: '1px',
            height: '1px',
            padding: 0,
            margin: '-1px',
            overflow: 'hidden',
            clip: 'rect(0, 0, 0, 0)',
            whiteSpace: 'nowrap',
            borderWidth: 0,
        }}
    >
        {message}
    </div>
);

/**
 * FocusTrap — Traps focus within a container (for modals/dialogs)
 *
 * Ensures keyboard users can't tab out of a modal.
 * Wraps children and manages focus cycling.
 */
export const FocusTrap: React.FC<{ children: React.ReactNode; active?: boolean }> = ({ children, active = true }) => {
    const containerRef = React.useRef<HTMLDivElement>(null);

    React.useEffect(() => {
        if (!active || !containerRef.current) return;

        const container = containerRef.current;
        const focusableElements = container.querySelectorAll<HTMLElement>(
            'a[href], button:not([disabled]), textarea, input:not([disabled]), select, [tabindex]:not([tabindex="-1"])'
        );

        if (focusableElements.length === 0) return;

        const firstFocusable = focusableElements[0];
        const lastFocusable = focusableElements[focusableElements.length - 1];

        // Focus the first element
        firstFocusable.focus();

        const handleKeyDown = (e: KeyboardEvent) => {
            if (e.key !== 'Tab') return;

            if (e.shiftKey) {
                if (document.activeElement === firstFocusable) {
                    e.preventDefault();
                    lastFocusable.focus();
                }
            } else {
                if (document.activeElement === lastFocusable) {
                    e.preventDefault();
                    firstFocusable.focus();
                }
            }
        };

        container.addEventListener('keydown', handleKeyDown);
        return () => container.removeEventListener('keydown', handleKeyDown);
    }, [active]);

    return <div ref={containerRef}>{children}</div>;
};

import React from 'react';
import { ButtonRegistry, type ButtonDef } from 'prime-care-shared';
import { PageActionRegistry } from 'prime-care-shared';
import { PcButton } from './PcButton';

/* ═══════════════════════════════════════════════════════════════════════════════
 * PageActionBar — Auto-renders the correct action buttons for a given page.
 *
 * Usage:
 *   <PageActionBar pageId="admin.home" />
 *
 * This looks up the page's buttons from PageActionRegistry and renders them
 * using PcButton (which reads from ButtonRegistry for label, variant, etc.)
 *
 * Result: Zero button code in your page components!
 * ═══════════════════════════════════════════════════════════════════════════ */

interface PageActionBarProps {
    /** PageEntry.id — e.g. 'admin.home', 'psw.schedule' */
    pageId: string;
    /** Optional overrides for individual button onClick handlers */
    handlers?: Record<string, (e: React.MouseEvent) => void | Promise<void>>;
    /** Optional route params for parameterized buttons */
    params?: Record<string, string>;
    /** Compact mode — show only primary + icon buttons */
    compact?: boolean;
    /** Additional className for the wrapper */
    className?: string;
    /** Override button size */
    size?: 'xs' | 'sm' | 'md' | 'lg';
}

export const PageActionBar: React.FC<PageActionBarProps> = ({
    pageId, handlers, params, compact, className, size,
}) => {
    const config = PageActionRegistry[pageId];
    if (!config) return null;

    const allIds = compact
        ? [config.primary].filter(Boolean) as string[]
        : [config.primary, ...config.actions].filter(Boolean) as string[];

    // De-duplicate (in case primary is also in actions)
    const uniqueIds = [...new Set(allIds)];

    return (
        <div
            data-cy={`action-bar-${pageId}`}
            className={className}
            style={{
                display: 'flex',
                gap: '0.5rem',
                flexWrap: 'wrap',
                alignItems: 'center',
            }}
        >
            {uniqueIds.map((btnId) => {
                const isPrimary = btnId === config.primary;
                return (
                    <PcButton
                        key={btnId}
                        registryId={btnId}
                        size={size || (isPrimary ? 'md' : 'sm')}
                        onClick={handlers?.[btnId]}
                        params={params}
                    />
                );
            })}
        </div>
    );
};

export default PageActionBar;

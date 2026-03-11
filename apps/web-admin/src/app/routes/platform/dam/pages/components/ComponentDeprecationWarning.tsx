import React, { useState } from 'react';
import { AlertCircle, X } from 'lucide-react';

interface DeprecationProps {
    componentName: string;
    replacementName: string;
    sunsetDate: string;
    isDevMode: boolean; // Will render nothing in production
    children: React.ReactNode;
}

export const ComponentDeprecationWarning: React.FC<DeprecationProps> = ({ 
    componentName, 
    replacementName, 
    sunsetDate, 
    isDevMode,
    children 
}) => {
    const [dismissed, setDismissed] = useState(false);

    // Hard fail-safe: Never render these debug stripes in a production build
    if (!isDevMode) {
        return <>{children}</>;
    }

    return (
        <div style={{ position: 'relative', display: 'inline-block' }}>
            {!dismissed && (
                <div style={{
                    position: 'absolute',
                    top: '-12px',
                    left: '-12px',
                    right: '-12px',
                    backgroundColor: 'rgba(239, 68, 68, 0.95)', // Red-500
                    color: 'white',
                    padding: '8px 12px',
                    borderRadius: '6px',
                    fontSize: '0.75rem',
                    fontWeight: 700,
                    zIndex: 9999,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)'
                }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <AlertCircle size={14} />
                        <span>
                            <strong>&lt;{componentName} /&gt;</strong> is deprecated. Use <strong>&lt;{replacementName} /&gt;</strong> instead. 
                            (Sunsets: {sunsetDate})
                        </span>
                    </div>
                    <button 
                        onClick={() => setDismissed(true)}
                        style={{ background: 'transparent', border: 'none', color: 'white', cursor: 'pointer', padding: '0', display: 'flex' }}
                        title="Dismiss Warning"
                    >
                        <X size={14} />
                    </button>
                </div>
            )}
            
            {/* The Actual Component, wrapped in a dashed red border for visibility */}
            <div style={{ border: dismissed ? 'none' : '2px dashed #EF4444', opacity: dismissed ? 1 : 0.8, transition: 'all 0.2s' }}>
                {children}
            </div>
        </div>
    );
};

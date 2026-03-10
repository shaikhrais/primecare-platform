import React, { ReactNode } from 'react';

interface ClinicalSplitViewProps {
    sidebarContent: ReactNode;
    mainContent: ReactNode;
}

export const ClinicalSplitView: React.FC<ClinicalSplitViewProps> = ({ sidebarContent, mainContent }) => {
    return (
        <div style={{
            display: 'grid',
            gridTemplateColumns: 'minmax(300px, 350px) 1fr',
            gap: '24px',
            height: 'calc(100vh - 100px)', // Offset for header/padding
            overflow: 'hidden' // Prevent global scrolling
        }}>
            {/* Left Pane: Frozen Context Sidebar */}
            <div style={{
                backgroundColor: '#F8FAFC',
                borderRadius: '16px',
                border: '1px solid #E2E8F0',
                padding: '24px',
                overflowY: 'auto', // Scrollable internally if content is long
                display: 'flex',
                flexDirection: 'column',
                gap: '20px'
            }}>
                {sidebarContent}
            </div>

            {/* Right Pane: Active Assessment/Dashboard Viewport */}
            <div style={{
                backgroundColor: '#FFFFFF',
                borderRadius: '16px',
                border: '1px solid #E2E8F0',
                padding: '32px',
                overflowY: 'auto', // Independently scrollable main content
                boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)'
            }}>
                {mainContent}
            </div>
        </div>
    );
};

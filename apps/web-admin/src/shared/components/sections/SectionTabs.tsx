import React from 'react';

export interface TabItem {
    id: string;
    label: string;
    count?: number | null;
}

interface SectionTabsProps {
    tabs: TabItem[];
    activeTab: string;
    onTabChange: (id: string) => void;
}

/** Tab navigation bar — used for multi-view pages like hubs */
export function SectionTabs({ tabs, activeTab, onTabChange }: SectionTabsProps) {
    return (
        <div style={{ display: 'flex', gap: '4px', marginBottom: '24px', flexWrap: 'wrap' }}>
            {tabs.map(tab => (
                <button key={tab.id} onClick={() => onTabChange(tab.id)} data-cy={`tab-${tab.id}`}
                    style={{
                        padding: '10px 20px', borderRadius: '10px', border: 'none',
                        background: activeTab === tab.id
                            ? 'var(--pc-primary, #3b82f6)'
                            : 'var(--pc-bg-secondary, #f3f4f6)',
                        color: activeTab === tab.id ? 'white' : 'var(--pc-text-secondary)',
                        fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                        transition: 'all 0.15s',
                    }}>
                    {tab.label}
                    {tab.count != null && (
                        <span style={{ marginLeft: '4px', opacity: 0.7 }}>({tab.count})</span>
                    )}
                </button>
            ))}
        </div>
    );
}

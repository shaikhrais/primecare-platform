// ================================================================
// SectionFilters — Search input + filter dropdowns bar.
// Replaces old EarningsFilters sub-component.
// ================================================================
import React from 'react';

export interface FilterOption {
    label: string;
    options: string[];
}

export interface SectionFiltersProps {
    searchPlaceholder?: string;
    filters?: FilterOption[];
}

export const SectionFilters: React.FC<SectionFiltersProps> = ({
    searchPlaceholder = 'Search...', filters = [],
}) => {
    return (
        <div style={{
            display: 'flex', gap: '1rem', padding: '16px 20px',
            backgroundColor: 'white', borderRadius: '1rem',
            boxShadow: '0 1px 3px rgba(0,0,0,0.05)', alignItems: 'center', border: '1px solid var(--border, #e5e7eb)',
        }}>
            <div style={{ flex: 1 }}>
                <input
                    type="text" placeholder={searchPlaceholder}
                    style={{
                        width: '100%', padding: '10px 14px', borderRadius: '0.75rem',
                        border: '1px solid #E5E7EB', fontSize: '0.9rem', outline: 'none',
                    }}
                />
            </div>
            {filters.map((f, i) => (
                <select key={i} style={{
                    padding: '10px 14px', borderRadius: '0.75rem',
                    border: '1px solid #E5E7EB', outline: 'none', fontWeight: 600, fontSize: '0.9rem',
                }}>
                    {f.options.map((opt, j) => <option key={j}>{opt}</option>)}
                </select>
            ))}
        </div>
    );
};

import React from 'react';

interface EarningsFiltersProps {
    searchTerm: string;
    setSearchTerm: (term: string) => void;
}

export const EarningsFilters: React.FC<EarningsFiltersProps> = ({ searchTerm, setSearchTerm }) => {
    return (
        <div style={{
            display: 'flex',
            gap: '1.5rem',
            padding: '20px',
            backgroundColor: '#FFFFFF',
            borderRadius: '20px',
            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)',
            alignItems: 'center'
        }}>
            <div style={{ flex: 1 }}>
                <input data-cy="input-admin.earnings-filters-0"
                    type="text"
                    placeholder="Search by Invoice, Shift, or Name..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    style={{
                        width: '100%',
                        padding: '12px 16px',
                        borderRadius: '12px',
                        border: '1px solid #E5E7EB',
                        fontSize: '1rem',
                        outline: 'none'
                    }}
                />
            </div>
            <select data-cy="select-admin.earnings-filters-0" style={{ padding: '12px', borderRadius: '12px', border: '1px solid #E5E7EB', outline: 'none', fontWeight: 600 }}>
                <option>All Statuses</option>
                <option>Paid</option>
                <option>Unpaid</option>
            </select>
        </div>
    );
};

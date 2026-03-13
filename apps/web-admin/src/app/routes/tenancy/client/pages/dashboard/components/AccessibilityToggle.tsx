import React from 'react';
import { ZoomIn } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export const AccessibilityToggle: React.FC = () => {
    const { t } = useTranslation();
    const [isScaled, setIsScaled] = React.useState(false);

    const toggleScaling = () => {
        setIsScaled(!isScaled);
        
        // This targets the root HTML element.
        // By changing this, any text using `rem` for sizing will scale globally.
        // Assuming the base font-size is normally 16px (100%), we push it to 150%.
        if (!isScaled) {
            document.documentElement.style.fontSize = '120%'; // ~19px base, scaling up all rem values
        } else {
            document.documentElement.style.fontSize = ''; // Reset to user browser default
        }
    };

    return (
        <button data-cy="btn-client.accessibility-toggle-0" 
            onClick={toggleScaling}
            title="Toggle Large Text"
            style={{ 
                display: 'flex', 
                alignItems: 'center', 
                gap: '8px', 
                backgroundColor: isScaled ? '#10B981' : '#F1F5F9', 
                color: isScaled ? 'white' : '#0F172A',
                border: '1px solid #CBD5E1', 
                padding: '8px 16px', 
                borderRadius: '8px', 
                cursor: 'pointer', 
                fontWeight: 800,
                fontSize: '1rem',
                minHeight: '48px', // Ensuring minimum hit area
                minWidth: '120px',
                transition: 'all 0.2s ease',
                boxShadow: isScaled ? '0 0 15px rgba(16, 185, 129, 0.4)' : 'none'
            }}
            aria-pressed={isScaled}
        >
            <ZoomIn size={24} />
            <span style={{ fontSize: '1.2rem' }}>{isScaled ? 'Standard Text' : 'Make Text Larger'}</span>
        </button>
    );
};

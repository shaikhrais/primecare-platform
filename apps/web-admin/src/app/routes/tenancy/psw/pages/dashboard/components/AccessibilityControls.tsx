import React, { useEffect, useState } from 'react';
import { Moon, Sun, Type, QrCode } from 'lucide-react';
import { useNotification } from '@/shared/context/NotificationContext';

interface AccessibilityControlsProps {
    onOpenIdBadge: () => void;
}

export const AccessibilityControls: React.FC<AccessibilityControlsProps> = ({ onOpenIdBadge }) => {
    const [isDarkMode, setIsDarkMode] = useState(() => localStorage.getItem('psw-dark-mode') === 'true');
    const [fontSizeLevel, setFontSizeLevel] = useState(0); // 0 = Normal, 1 = Large, 2 = Extra Large
    const { showToast } = useNotification();

    useEffect(() => {
        if (isDarkMode) {
            document.body.classList.add('amoled-dark-mode');
            localStorage.setItem('psw-dark-mode', 'true');
        } else {
            document.body.classList.remove('amoled-dark-mode');
            localStorage.setItem('psw-dark-mode', 'false');
        }
    }, [isDarkMode]);

    useEffect(() => {
        const root = document.documentElement;
        if (fontSizeLevel === 0) {
            root.style.setProperty('font-size', '16px');
        } else if (fontSizeLevel === 1) {
            root.style.setProperty('font-size', '18px');
        } else if (fontSizeLevel === 2) {
            root.style.setProperty('font-size', '20px');
        }
    }, [fontSizeLevel]);

    const toggleDark = () => setIsDarkMode(!isDarkMode);

    const cycleFontSize = () => {
        setFontSizeLevel(prev => {
            const next = (prev + 1) % 3;
            if (next === 1) showToast('Font size increased to Large', 'info');
            else if (next === 2) showToast('Font size increased to Extra Large', 'info');
            else showToast('Font size reset to Normal', 'info');
            return next;
        });
    };

    return (
        <div style={{ display: 'flex', gap: '12px', alignItems: 'center', marginBottom: '16px' }}>
            <button
                onClick={toggleDark}
                style={{
                    display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px',
                    backgroundColor: isDarkMode ? '#1F2937' : '#FFFFFF',
                    color: isDarkMode ? '#F3F4F6' : '#111827',
                    border: '1px solid #E5E7EB', borderRadius: '20px', cursor: 'pointer', fontWeight: 600
                }}
            >
                {isDarkMode ? <Sun size={18} /> : <Moon size={18} />}
                {isDarkMode ? 'Light Mode' : 'AMOLED Dark'}
            </button>

            <button
                onClick={cycleFontSize}
                style={{
                    display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px',
                    backgroundColor: '#FFFFFF', color: '#111827',
                    border: '1px solid #E5E7EB', borderRadius: '20px', cursor: 'pointer', fontWeight: 600
                }}
                title="Toggle Font Size"
            >
                <Type size={18} />
                {fontSizeLevel === 0 ? 'Normal text' : fontSizeLevel === 1 ? 'Large text' : 'XL text'}
            </button>

            <button
                onClick={onOpenIdBadge}
                style={{
                    display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px',
                    backgroundColor: '#4F46E5', color: 'white',
                    border: 'none', borderRadius: '20px', cursor: 'pointer', fontWeight: 600
                }}
            >
                <QrCode size={18} /> Digital ID
            </button>
            <style>{`
                /* AMOLED Dark Mode Overrides */
                body.amoled-dark-mode {
                    background-color: #000000 !important;
                    color: #FFFFFF !important;
                }
                body.amoled-dark-mode .pc-card,
                body.amoled-dark-mode [data-cy^="shift-card-"] {
                    background-color: #111111 !important;
                    border-color: #333333 !important;
                    color: #FFFFFF !important;
                }
                body.amoled-dark-mode h1,
                body.amoled-dark-mode h2,
                body.amoled-dark-mode h3,
                body.amoled-dark-mode p {
                    color: #F9FAFB !important;
                }
            `}</style>
        </div>
    );
};

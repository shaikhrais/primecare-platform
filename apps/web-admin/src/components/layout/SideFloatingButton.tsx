import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

export default function SideFloatingButton() {
    const [isOpen, setIsOpen] = useState(false);
    const navigate = useNavigate();

    const baseStyle = {
        position: 'fixed' as 'fixed',
        right: '24px',
        bottom: '24px',
        width: '60px',
        height: '60px',
        borderRadius: '50%',
        backgroundColor: 'var(--primary)',
        color: 'white',
        border: 'none',
        boxShadow: '0 4px 12px rgba(0,0,0,0.3)',
        fontSize: '2rem',
        cursor: 'pointer',
        zIndex: 9999,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        transition: 'transform 0.2s'
    };

    const menuStyle = {
        position: 'fixed' as 'fixed',
        right: '24px',
        bottom: '96px',
        display: 'flex',
        flexDirection: 'column' as 'column',
        gap: '12px',
        zIndex: 9998,
        alignItems: 'flex-end',
    };

    const menuItemStyle = {
        backgroundColor: 'var(--bg-elev)',
        color: 'var(--text)',
        padding: '10px 16px',
        borderRadius: '8px',
        border: '1px solid var(--line)',
        boxShadow: '0 2px 8px rgba(0,0,0,0.15)',
        cursor: 'pointer',
        fontWeight: 600,
        display: 'flex',
        alignItems: 'center',
        gap: '8px',
        textDecoration: 'none'
    };

    return (
        <>
            {isOpen && (
                <div style={menuStyle}>
                    <button style={menuItemStyle} onClick={() => navigate('/manager/daily-entry')}>
                        📝 New Daily Entry
                    </button>
                    <button style={menuItemStyle} onClick={() => navigate('/incidents')}>
                        ⚠️ New Incident
                    </button>
                    <button style={menuItemStyle} onClick={() => { }}>
                        🏥 New Client
                    </button>
                    <button style={{ ...menuItemStyle, backgroundColor: '#e53935', color: 'white', border: 'none' }} onClick={() => alert('Emergency Protocol Activated!')}>
                        🚨 EMERGENCY
                    </button>
                </div>
            )}

            <button
                style={{ ...baseStyle, transform: isOpen ? 'rotate(45deg)' : 'none' }}
                onClick={() => setIsOpen(!isOpen)}
            >
                +
            </button>
        </>
    );
}

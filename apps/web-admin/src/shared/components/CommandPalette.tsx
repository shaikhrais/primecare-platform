import React, { useState, useEffect, useMemo, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCommandPalette } from '@/shared/context/CommandPaletteContext';
import { AdminRegistry } from 'prime-care-shared';

// RouteRegistry is usually exported as AdminRegistry.RouteRegistry in newer shared packages
// or directly if using the specific app export.
// For now, let's assume it's directly on AdminRegistry based on previous code usage
const { RouteRegistry } = AdminRegistry;

interface Command {
    id: string;
    label: string;
    category: 'Navigation' | 'Action' | 'Data';
    shortcut?: string;
    icon?: string;
    action: () => void;
}

export const CommandPalette: React.FC = () => {
    const { isOpen, close } = useCommandPalette();
    const navigate = useNavigate();
    const [search, setSearch] = useState('');
    const [selectedIndex, setSelectedIndex] = useState(0);
    const inputRef = useRef<HTMLInputElement>(null);

    // Initial Commands (We can expand this to be dynamic later)
    const commands: Command[] = useMemo(() => [
        // Navigation
        { id: 'nav-home', label: 'Go to Dashboard', category: 'Navigation', icon: '🏠', action: () => navigate(RouteRegistry.ADMIN.DASHBOARD) },
        { id: 'nav-users', label: 'Go to Users', category: 'Navigation', icon: '👥', action: () => navigate(RouteRegistry.ADMIN.USERS) },
        { id: 'nav-leads', label: 'Go to Leads', category: 'Navigation', icon: '📥', action: () => navigate(RouteRegistry.ADMIN.LEADS) },
        { id: 'nav-schedule', label: 'Go to Schedule', category: 'Navigation', icon: '📅', action: () => navigate(RouteRegistry.ADMIN.SCHEDULE) },
        { id: 'nav-earnings', label: 'Go to Earnings', category: 'Navigation', icon: '💰', action: () => navigate(RouteRegistry.ADMIN.EARNINGS) },
        { id: 'nav-settings', label: 'Go to Settings', category: 'Navigation', icon: '⚙️', action: () => navigate(RouteRegistry.ADMIN.SETTINGS) },

        // Actions (Mock for now)
        { id: 'act-new-visit', label: 'Create New Visit', category: 'Action', icon: '➕', action: () => { navigate(RouteRegistry.ADMIN.SCHEDULE); close(); } },
        { id: 'act-new-user', label: 'Invite New User', category: 'Action', icon: '✉️', action: () => { navigate(RouteRegistry.ADMIN.USERS); close(); } },

    ], [navigate, close]);

    // Filter Logic
    const filteredCommands = useMemo(() => {
        if (!search) return commands;
        return commands.filter(cmd =>
            cmd.label.toLowerCase().includes(search.toLowerCase()) ||
            cmd.category.toLowerCase().includes(search.toLowerCase())
        );
    }, [search, commands]);

    // Reset selection on search change
    useEffect(() => {
        setSelectedIndex(0);
    }, [search]);

    // Focus input on open
    useEffect(() => {
        if (isOpen) {
            setTimeout(() => inputRef.current?.focus(), 50);
            setSearch('');
        }
    }, [isOpen]);

    // Keyboard Navigation
    useEffect(() => {
        const handleKeyDown = (e: KeyboardEvent) => {
            if (!isOpen) return;

            if (e.key === 'ArrowDown') {
                e.preventDefault();
                setSelectedIndex(prev => (prev + 1) % filteredCommands.length);
            } else if (e.key === 'ArrowUp') {
                e.preventDefault();
                setSelectedIndex(prev => (prev - 1 + filteredCommands.length) % filteredCommands.length);
            } else if (e.key === 'Enter') {
                e.preventDefault();
                if (filteredCommands[selectedIndex]) {
                    filteredCommands[selectedIndex].action();
                    close();
                }
            }
        };

        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [isOpen, filteredCommands, selectedIndex, close]);

    if (!isOpen) return null;

    return (
        <div style={{
            position: 'fixed', inset: 0, zIndex: 9999,
            backgroundColor: 'rgba(0,0,0,0.5)',
            backdropFilter: 'blur(2px)',
            display: 'flex', alignItems: 'flex-start', justifyContent: 'center',
            paddingTop: '15vh'
        }} onClick={close}>
            <div style={{
                width: '100%', maxWidth: '600px',
                backgroundColor: 'white',
                borderRadius: '12px',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
                overflow: 'hidden',
                display: 'flex', flexDirection: 'column'
            }} onClick={e => e.stopPropagation()}>
                <div style={{ padding: '16px', borderBottom: '1px solid #f3f4f6', display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <span style={{ fontSize: '1.2rem' }}>🔍</span>
                    <input
                        ref={inputRef}
                        value={search}
                        onChange={e => setSearch(e.target.value)}
                        placeholder="Type a command or search..."
                        style={{
                            flex: 1, border: 'none', fontSize: '1.125rem', outline: 'none', color: '#111827'
                        }}
                    />
                    <kbd style={{ fontSize: '0.75rem', padding: '0.2rem 0.4rem', backgroundColor: '#f3f4f6', borderRadius: '4px', color: '#6b7280' }}>ESC</kbd>
                </div>

                <div style={{ maxHeight: '400px', overflowY: 'auto', padding: '8px' }}>
                    {filteredCommands.length === 0 ? (
                        <div style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>No results found.</div>
                    ) : (
                        filteredCommands.map((cmd, index) => (
                            <div
                                key={cmd.id}
                                onClick={() => { cmd.action(); close(); }}
                                onMouseEnter={() => setSelectedIndex(index)}
                                style={{
                                    display: 'flex', alignItems: 'center', gap: '12px',
                                    padding: '12px 16px',
                                    borderRadius: '8px',
                                    cursor: 'pointer',
                                    backgroundColor: index === selectedIndex ? '#f3f4f6' : 'transparent',
                                    color: index === selectedIndex ? '#111827' : '#4b5563'
                                }}
                            >
                                <span style={{ fontSize: '1.2rem' }}>{cmd.icon}</span>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: '0.95rem', fontWeight: 500 }}>{cmd.label}</div>
                                    <div style={{ fontSize: '0.75rem', color: '#9ca3af' }}>{cmd.category}</div>
                                </div>
                                {index === selectedIndex && <span style={{ fontSize: '0.875rem', color: '#9ca3af' }}>↵</span>}
                            </div>
                        ))
                    )}
                </div>
            </div>
        </div>
    );
};

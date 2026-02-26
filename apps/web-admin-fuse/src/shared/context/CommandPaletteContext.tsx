import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';

interface CommandPaletteContextType {
    isOpen: boolean;
    open: () => void;
    close: () => void;
    toggle: () => void;
}

const CommandPaletteContext = createContext<CommandPaletteContextType | undefined>(undefined);

export const CommandPaletteProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [isOpen, setIsOpen] = useState(false);

    const open = useCallback(() => setIsOpen(true), []);
    const close = useCallback(() => setIsOpen(false), []);
    const toggle = useCallback(() => setIsOpen(prev => !prev), []);

    useEffect(() => {
        const handleKeyDown = (e: KeyboardEvent) => {
            if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
                e.preventDefault();
                toggle();
            }
            if (e.key === 'Escape') {
                close();
            }
        };

        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [toggle, close]);

    return (
        <CommandPaletteContext.Provider value={{ isOpen, open, close, toggle }}>
            {children}
        </CommandPaletteContext.Provider>
    );
};

export const useCommandPalette = () => {
    const context = useContext(CommandPaletteContext);
    if (!context) {
        throw new Error('useCommandPalette must be used within a CommandPaletteProvider');
    }
    return context;
};

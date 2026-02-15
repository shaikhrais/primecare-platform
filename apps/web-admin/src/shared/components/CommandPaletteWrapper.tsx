import React from 'react';
import { CommandPaletteProvider } from '@/shared/context/CommandPaletteContext';
import { CommandPalette } from '@/shared/components/CommandPalette';

export const CommandPaletteWrapper: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    return (
        <CommandPaletteProvider>
            {children}
            <CommandPalette />
        </CommandPaletteProvider>
    );
};

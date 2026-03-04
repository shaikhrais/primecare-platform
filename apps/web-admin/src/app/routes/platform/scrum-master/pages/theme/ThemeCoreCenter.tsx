import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
const { ThemeRegistry } = AdminRegistry;

const ThemeCoreCenter: React.FC = () => {
    const [colors, setColors] = useState<Record<string, string>>({
        primary: '#00897b',
        primaryDark: '#004d40',
        accent: '#c2ffd9',
        background: '#f9fafb',
        surface: '#ffffff',
    });

    // Update CSS variables live
    useEffect(() => {
        const root = document.documentElement;
        root.style.setProperty('--pc-primary', colors.primary);
        root.style.setProperty('--pc-primary-dark', colors.primaryDark);
        root.style.setProperty('--pc-accent', colors.accent);
        root.style.setProperty('--pc-bg', colors.background);
        root.style.setProperty('--pc-surface', colors.surface);
    }, [colors]);

    const handleColorChange = (key: string, value: string) => {
        setColors(prev => ({ ...prev, [key]: value }));
    };

    const applyPreset = (presetKey: keyof typeof ThemeRegistry.PRESETS) => {
        const preset = ThemeRegistry.PRESETS[presetKey];
        setColors(prev => ({
            ...prev,
            primary: preset.primary,
            primaryDark: preset.primaryDark,
            accent: preset.accent,
        }));
    };

    return (
        <div className="main-content">
            <header className="mb-8">
                <h1 className="text-3xl font-bold text-gray-900">Theme Core Center</h1>
                <p className="text-gray-600">Live platform style management and CSS variable audit.</p>
            </header>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                {/* 1. Theme Presets */}
                <div className="pc-card">
                    <div className="pc-card-h bg-gray-50">Theme Presets</div>
                    <div className="pc-card-b space-y-4">
                        {Object.keys(ThemeRegistry.PRESETS).map((key) => (
                            <button
                                key={key}
                                onClick={() => applyPreset(key as any)}
                                className="w-full text-left p-4 rounded-lg border border-gray-200 hover:border-teal-500 transition-all flex items-center justify-between group"
                            >
                                <span className="font-semibold text-gray-700">{key.replace(/_/g, ' ')}</span>
                                <div className="flex gap-2">
                                    <div className="w-4 h-4 rounded-full" style={{ background: (ThemeRegistry.PRESETS as any)[key].primary }} />
                                    <div className="w-4 h-4 rounded-full" style={{ background: (ThemeRegistry.PRESETS as any)[key].accent }} />
                                </div>
                            </button>
                        ))}
                    </div>
                </div>

                {/* 2. Live Color Controls */}
                <div className="pc-card lg:col-span-2">
                    <div className="pc-card-h bg-gray-50">Live Color Variables</div>
                    <div className="pc-card-b">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                            {Object.entries(colors).map(([key, value]) => (
                                <div key={key} className="space-y-2">
                                    <label className="text-sm font-bold text-gray-500 uppercase flex justify-between">
                                        {key}
                                        <span className="text-teal-600 font-mono lowercase">--pc-{key}</span>
                                    </label>
                                    <div className="flex gap-3">
                                        <input
                                            type="color"
                                            value={value}
                                            onChange={(e) => handleColorChange(key, e.target.value)}
                                            className="h-10 w-16 rounded cursor-pointer border-none p-0"
                                        />
                                        <input
                                            type="text"
                                            value={value}
                                            onChange={(e) => handleColorChange(key, e.target.value)}
                                            className="flex-1 px-4 py-2 border rounded-lg font-mono text-sm"
                                        />
                                    </div>
                                </div>
                            ))}
                        </div>

                        <div className="mt-8 p-6 bg-gray-900 rounded-xl text-white font-mono text-sm relative overflow-hidden">
                            <div className="absolute top-0 right-0 p-2 text-xs text-gray-500">LIVE CSS TOKENS</div>
                            <div>:root &#123;</div>
                            <div className="pl-4 text-teal-400">--pc-primary: {colors.primary};</div>
                            <div className="pl-4 text-teal-400">--pc-primary-dark: {colors.primaryDark};</div>
                            <div className="pl-4 text-teal-400">--pc-accent: {colors.accent};</div>
                            <div className="pl-4 text-teal-400">--pc-bg: {colors.background};</div>
                            <div className="pl-4 text-teal-400">--pc-surface: {colors.surface};</div>
                            <div>&#125;</div>
                        </div>
                    </div>
                </div>
            </div>

            {/* 3. Transformation Preview */}
            <div className="mt-8 pc-card">
                <div className="pc-card-h">Visual Impact Preview</div>
                <div className="pc-card-b">
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div className="p-6 rounded-xl border border-dashed border-gray-200">
                            <h3 className="font-bold mb-4">Button System</h3>
                            <div className="flex flex-col gap-3">
                                <button className="btn btn-primary">Primary Action</button>
                                <button className="pc-nav-link active">Active Sidebar Item</button>
                            </div>
                        </div>
                        <div className="p-6 rounded-xl border border-dashed border-gray-200">
                            <h3 className="font-bold mb-4">Card States</h3>
                            <div className="pc-card strip">
                                <div className="pc-card-h">Strip Header</div>
                                <div className="pc-card-b">Body content utilizing variable text.</div>
                            </div>
                        </div>
                        <div className="p-6 rounded-xl border border-dashed border-gray-200">
                            <h3 className="font-bold mb-4">Badge Hierarchy</h3>
                            <div className="flex gap-2 flex-wrap">
                                <span className="pill">Infrastructure</span>
                                <span className="pill" style={{ borderColor: 'var(--pc-primary)', color: 'var(--pc-primary)' }}>High Priority</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ThemeCoreCenter;

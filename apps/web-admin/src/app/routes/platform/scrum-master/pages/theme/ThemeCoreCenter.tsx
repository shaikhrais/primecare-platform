import React, { useState, useEffect, useRef } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { REGISTRY_COLORS, DEFAULT_PRESET, INITIAL_COLORS, buildGradient, PRESET_LABELS, S } from './themeConfig';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';

const { ThemeRegistry } = AdminRegistry;

const ThemeCoreCenter: React.FC = () => {
    // TanStack Query: auto-cached branding config
    const { data: brandingData, isLoading: loading } = useRegistryQuery<any>('/v1/admin/settings/branding', {
        queryKey: ['admin', 'settings', 'branding'],
        staleTime: 60_000,
    });

    // Derive initial colors from query data
    const initialFromServer = brandingData?.brandingConfig
        ? {
            primary: brandingData.brandingConfig.primaryColor || INITIAL_COLORS.primary,
            primaryDark: brandingData.brandingConfig.primaryDarkColor || INITIAL_COLORS.primaryDark,
            accent: brandingData.brandingConfig.accentColor || INITIAL_COLORS.accent,
            background: brandingData.brandingConfig.backgroundColor || INITIAL_COLORS.background,
            surface: brandingData.brandingConfig.surfaceColor || INITIAL_COLORS.surface,
        }
        : { ...INITIAL_COLORS };

    const [colors, setColors] = useState<Record<string, string>>({ ...INITIAL_COLORS });
    const [savedColors, setSavedColors] = useState<Record<string, string>>({ ...INITIAL_COLORS });
    const [activePreset, setActivePreset] = useState(DEFAULT_PRESET);
    const [copied, setCopied] = useState(false);
    const [saving, setSaving] = useState(false);
    const [saveStatus, setSaveStatus] = useState<'idle' | 'saved' | 'error'>('idle');
    const [initialized, setInitialized] = useState(false);

    const hasChanges = JSON.stringify(colors) !== JSON.stringify(savedColors);

    // Sync query data into local state once loaded
    useEffect(() => {
        if (brandingData && !initialized) {
            setColors(initialFromServer);
            setSavedColors(initialFromServer);
            if (brandingData?.brandingConfig?.presetName) setActivePreset(brandingData.brandingConfig.presetName);
            setInitialized(true);
        }
    }, [brandingData, initialized]);

    useEffect(() => { const root = document.documentElement; REGISTRY_COLORS.forEach(({ key, variable }) => { root.style.setProperty(variable, colors[key]); }); }, [colors]);

    const handleColorChange = (key: string, value: string) => { setColors(prev => ({ ...prev, [key]: value })); setActivePreset(''); setSaveStatus('idle'); };
    const applyPreset = (presetKey: string) => { const preset = (ThemeRegistry.PRESETS as any)[presetKey]; if (!preset) return; setColors(prev => ({ ...prev, primary: preset.primary, primaryDark: preset.primaryDark, accent: preset.accent })); setActivePreset(presetKey); setSaveStatus('idle'); };
    const resetToSaved = () => { setColors({ ...savedColors }); setSaveStatus('idle'); };

    const saveTheme = async () => {
        setSaving(true);
        try {
            const res = await apiClient.patch('/v1/admin/settings/branding', { brandingConfig: { primaryColor: colors.primary, primaryDarkColor: colors.primaryDark, accentColor: colors.accent, backgroundColor: colors.background, surfaceColor: colors.surface, presetName: activePreset || undefined } });
            if (res.ok) { setSavedColors({ ...colors }); setSaveStatus('saved'); setTimeout(() => setSaveStatus('idle'), 3000); } else { setSaveStatus('error'); }
        } catch { setSaveStatus('error'); }
        setSaving(false);
    };

    const cssText = `:root {\n${REGISTRY_COLORS.map(({ key, variable }) => `  ${variable}: ${colors[key]};`).join('\n')}\n}`;
    const copyCSS = () => { navigator.clipboard.writeText(cssText); setCopied(true); setTimeout(() => setCopied(false), 2000); };
    const brand = REGISTRY_COLORS.filter(c => c.group === 'brand');
    const surface = REGISTRY_COLORS.filter(c => c.group === 'surface');

    if (loading) return (<div data-cy="page.container" className="main-content" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: 400 }}><div style={{ fontSize: 16, color: '#94a3b8' }}>Loading theme configuration...</div></div>);

    return (
        <div style={S.page} className="main-content">
            <div style={S.hero}><div style={S.heroGlow as any} /><h1 data-cy="page.title" style={S.heroTitle}><span style={S.heroIcon}>🎨</span>Theme Core Center</h1><p style={S.heroSub}>Live platform style management · CSS variable audit · Component preview</p></div>

            <div style={S.saveBar}>
                {saveStatus === 'saved' && <span style={{ ...S.statusBadge, background: '#dcfce7', color: '#166534' }}>✓ Theme saved successfully</span>}
                {saveStatus === 'error' && <span style={{ ...S.statusBadge, background: '#fee2e2', color: '#991b1b' }}>✗ Failed to save</span>}
                {hasChanges && <button data-cy="btn-theme-core-center-0" style={S.resetBtn} onClick={resetToSaved}>Reset</button>}
                <button data-cy="btn-theme-core-center-1" style={{ ...S.saveBtn, ...((!hasChanges || saving) ? S.saveBtnDisabled : {}) }} onClick={saveTheme} disabled={!hasChanges || saving}>{saving ? 'Saving...' : hasChanges ? '💾 Save Theme' : 'No Changes'}</button>
            </div>

            <div style={{ ...S.card, padding: 20, marginBottom: 28 }}>
                <div style={{ fontSize: 13, fontWeight: 700, textTransform: 'uppercase', color: '#475569', letterSpacing: 0.8, marginBottom: 14, display: 'flex', alignItems: 'center', gap: 8 }}><span>✦</span> Theme Presets <span style={{ fontSize: 11, color: '#94a3b8', fontWeight: 500 }}>({Object.keys(ThemeRegistry.PRESETS).length} from registry)</span></div>
                <div style={S.grid3}>
                    {Object.keys(ThemeRegistry.PRESETS).map(key => {
                        const preset = (ThemeRegistry.PRESETS as any)[key]; const isActive = activePreset === key;
                        return (<button data-cy="btn-theme-core-center-2" key={key} onClick={() => applyPreset(key)} style={{ ...S.preset, ...(isActive ? S.presetActive : {}), boxShadow: isActive ? '0 0 0 3px rgba(59,130,246,0.2), 0 4px 12px rgba(0,0,0,0.08)' : '0 1px 4px rgba(0,0,0,0.08)' }}>
                            <div style={{ ...S.presetGradient, background: buildGradient(preset) }}>{isActive && <div style={S.presetCheck}>✓</div>}</div>
                            <div style={S.presetInfo}><div style={S.presetName}>{PRESET_LABELS[key] || key.replace(/_/g, ' ')}</div><div style={S.presetDots}><div style={{ ...S.presetDot, background: preset.primary }} /><div style={{ ...S.presetDot, background: preset.primaryDark }} /><div style={{ ...S.presetDot, background: preset.accent }} /></div></div>
                        </button>);
                    })}
                </div>
            </div>

            <div style={S.grid2}>
                <div style={S.card}>
                    <div style={S.cardH}><span>◈</span> Live Color Variables <span style={{ fontSize: 11, color: '#94a3b8', fontWeight: 500 }}>(ThemeRegistry.COLORS)</span></div>
                    <div style={{ padding: 20 }}>
                        <div style={S.colorGroup}><div style={S.colorGroupLabel}>Brand Identity</div>{brand.map(c => <ColorRow key={c.key} k={c.key} label={c.label} variable={c.variable} value={colors[c.key]} onChange={handleColorChange} />)}</div>
                        <div style={S.colorGroup}><div style={S.colorGroupLabel}>Surfaces &amp; Backgrounds</div>{surface.map(c => <ColorRow key={c.key} k={c.key} label={c.label} variable={c.variable} value={colors[c.key]} onChange={handleColorChange} />)}</div>
                    </div>
                </div>
                <div style={S.codeCard}>
                    <div style={S.codeHeader}><span style={S.codeTitle}>Live CSS Tokens</span><button data-cy="btn-theme-core-center-3" style={S.codeCopy} onClick={copyCSS}>{copied ? '✓ Copied!' : '⎘ Copy'}</button></div>
                    <div style={S.codeBody}>
                        <div style={S.codeBrace}>:root {'{'}</div>
                        {REGISTRY_COLORS.map(({ key, variable }) => (<div key={key} style={{ paddingLeft: 20 }}><span style={S.codeProp}>{variable}</span><span style={{ color: '#475569' }}>: </span><span style={S.codeVal}>{colors[key]}</span><span style={{ color: '#475569' }}>;</span><span style={{ display: 'inline-block', width: 10, height: 10, borderRadius: '50%', background: colors[key], marginLeft: 10, verticalAlign: 'middle', border: '1px solid rgba(255,255,255,0.1)' }} /></div>))}
                        <div style={S.codeBrace}>{'}'}</div>
                    </div>
                </div>
            </div>

            <div style={S.card}>
                <div style={S.cardH}><span>◉</span> Visual Impact Preview</div>
                <div style={{ padding: 24 }}>
                    <div style={S.grid3preview}>
                        <div style={S.previewBox}><div style={S.previewTitle}>Button System</div><div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}><button data-cy="btn-theme-core-center-4" style={{ ...S.btnPrimary, background: colors.primary }}>Primary Action</button><button data-cy="btn-theme-core-center-5" style={{ ...S.btnSecondary, border: `2px solid ${colors.primary}`, color: colors.primary }}>Secondary</button><button data-cy="btn-theme-core-center-6" style={S.btnGhost}>Ghost Button</button></div></div>
                        <div style={S.previewBox}><div style={S.previewTitle}>Alerts &amp; Stats</div><div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}><div style={{ ...S.alertSuccess, background: `${colors.accent}22`, border: `1px solid ${colors.accent}`, color: colors.primaryDark }}><span>✓</span> Operation completed</div><div style={S.alertWarning}><span>⚠</span> Needs attention</div><div style={S.statCard}><div style={{ ...S.statLabel, color: colors.primary }}>Active Users</div><div style={S.statValue}>2,847</div><div style={{ ...S.statDelta, color: '#10b981' }}>↑ 12.5%</div></div></div></div>
                        <div style={S.previewBox}><div style={S.previewTitle}>Badges &amp; Progress</div><div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, marginBottom: 20 }}><span style={{ ...S.badge, background: colors.primary, color: '#fff' }}>Active</span><span style={{ ...S.badge, background: `${colors.accent}33`, color: colors.primaryDark, border: `1px solid ${colors.accent}` }}>Pending</span><span style={{ ...S.badge, background: '#fee2e2', color: '#991b1b' }}>Critical</span><span style={{ ...S.badge, background: '#f1f5f9', color: '#475569' }}>Archived</span></div><div style={{ marginBottom: 20 }}><div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}><span style={{ fontSize: 12, fontWeight: 600, color: '#475569' }}>Compliance</span><span style={{ fontSize: 12, fontWeight: 700, color: colors.primary }}>87%</span></div><div style={S.progressTrack}><div style={{ ...S.progressFill, width: '87%', background: `linear-gradient(90deg, ${colors.primaryDark}, ${colors.primary})` }} /></div></div><div><h3 data-cy="h3-theme-core-center-0" style={S.typoH1}>Heading</h3><p style={S.typoP}>Body text using the current theme palette for consistent visual identity.</p></div></div>
                    </div>
                </div>
            </div>
        </div>
    );
};

const ColorRow: React.FC<{ k: string; label: string; variable: string; value: string; onChange: (k: string, v: string) => void }> = ({ k, label, variable, value, onChange }) => {
    const inputRef = useRef<HTMLInputElement>(null);
    return (
        <div style={S.colorRow}>
            <div style={{ ...S.colorSwatch, background: value }} onClick={() => inputRef.current?.click()}><input data-cy="input-theme-core-center-0" ref={inputRef} type="color" value={value} onChange={e => onChange(k, e.target.value)} style={S.colorHiddenInput as any} /></div>
            <div style={{ flex: 1 }}><div style={S.colorLabel}>{label}</div><div style={S.colorVar}>{variable}</div></div>
            <input data-cy="input-theme-core-center-1" type="text" value={value} onChange={e => onChange(k, e.target.value)} style={S.colorHex} />
        </div>
    );
};

export default ThemeCoreCenter;

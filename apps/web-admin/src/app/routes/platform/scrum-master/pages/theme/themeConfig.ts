import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ThemeRegistry } = AdminRegistry;

/* ─────────── Registry-Driven Color Map ─────────── */
export const REGISTRY_COLORS = [
    { key: 'primary', label: 'Primary', variable: ThemeRegistry.COLORS.PRIMARY, group: 'brand' as const },
    { key: 'primaryDark', label: 'Primary Dark', variable: ThemeRegistry.COLORS.PRIMARY_DARK, group: 'brand' as const },
    { key: 'accent', label: 'Accent', variable: ThemeRegistry.COLORS.ACCENT, group: 'brand' as const },
    { key: 'background', label: 'Background', variable: ThemeRegistry.COLORS.BACKGROUND, group: 'surface' as const },
    { key: 'surface', label: 'Surface', variable: ThemeRegistry.COLORS.SURFACE, group: 'surface' as const },
] as const;

export const DEFAULT_PRESET = 'PRIMECARE_STANDARD';
const defaultPreset = ThemeRegistry.PRESETS[DEFAULT_PRESET];

export const INITIAL_COLORS: Record<string, string> = {
    primary: defaultPreset.primary,
    primaryDark: defaultPreset.primaryDark,
    accent: defaultPreset.accent,
    background: '#f9fafb',
    surface: '#ffffff',
};

export const buildGradient = (p: typeof ThemeRegistry.PRESETS[keyof typeof ThemeRegistry.PRESETS]) =>
    `linear-gradient(135deg, ${p.primaryDark}, ${p.primary}, ${p.accent})`;

export const PRESET_LABELS: Record<string, string> = {
    PRIMECARE_STANDARD: 'PrimeCare Standard',
    DUSK_MODE: 'Dusk Mode',
    EMERALD_CITY: 'Emerald City',
};

/* ─────────────────── Styles ─────────────────── */
export const S: Record<string, React.CSSProperties> = {
    page: { padding: '0 0 60px', fontFamily: "'Inter', system-ui, -apple-system, sans-serif" },
    hero: { background: 'linear-gradient(135deg, #0f172a 0%, #1e3a5f 50%, #0ea5e9 100%)', borderRadius: 16, padding: '36px 40px', marginBottom: 32, position: 'relative', overflow: 'hidden' },
    heroGlow: { position: 'absolute', top: -60, right: -60, width: 200, height: 200, background: 'radial-gradient(circle, rgba(56,189,248,0.25) 0%, transparent 70%)', borderRadius: '50%', pointerEvents: 'none' },
    heroTitle: { fontSize: 28, fontWeight: 800, color: '#fff', margin: 0, letterSpacing: -0.5, display: 'flex', alignItems: 'center', gap: 12 },
    heroSub: { fontSize: 14, color: 'rgba(255,255,255,0.7)', marginTop: 6 },
    heroIcon: { width: 36, height: 36, background: 'rgba(255,255,255,0.15)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 20 },
    card: { background: '#fff', borderRadius: 14, boxShadow: '0 1px 3px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.04)', overflow: 'hidden' },
    cardH: { padding: '16px 20px', fontWeight: 700, fontSize: 14, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#475569', borderBottom: '1px solid #f1f5f9', display: 'flex', alignItems: 'center', gap: 8 },
    grid3: { display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 16, marginBottom: 28 },
    grid2: { display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 24, marginBottom: 28 },
    grid3preview: { display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 20 },
    preset: { borderRadius: 14, padding: 0, cursor: 'pointer', border: '2px solid transparent', transition: 'all 0.25s ease', position: 'relative' as const, overflow: 'hidden', background: 'none' },
    presetActive: { border: '2px solid #3b82f6', boxShadow: '0 0 0 3px rgba(59,130,246,0.2)' },
    presetGradient: { height: 100, borderRadius: '12px 12px 0 0', position: 'relative' as const },
    presetInfo: { padding: '12px 16px', background: '#fff', borderRadius: '0 0 12px 12px' },
    presetName: { fontSize: 13, fontWeight: 700, color: '#1e293b', textAlign: 'left' as const },
    presetDots: { display: 'flex', gap: 6, marginTop: 6 },
    presetDot: { width: 16, height: 16, borderRadius: '50%', border: '2px solid rgba(255,255,255,0.3)' },
    presetCheck: { position: 'absolute' as const, top: 8, right: 8, width: 24, height: 24, borderRadius: '50%', background: '#3b82f6', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#fff', fontSize: 14, fontWeight: 700, boxShadow: '0 2px 6px rgba(59,130,246,0.4)' },
    colorGroup: { marginBottom: 20 },
    colorGroupLabel: { fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, color: '#94a3b8', letterSpacing: 1.2, marginBottom: 12 },
    colorRow: { display: 'flex', alignItems: 'center', gap: 14, padding: '10px 0', borderBottom: '1px solid #f8fafc' },
    colorSwatch: { width: 40, height: 40, borderRadius: '50%', border: '3px solid #fff', boxShadow: '0 2px 8px rgba(0,0,0,0.12)', cursor: 'pointer', flexShrink: 0, position: 'relative' as const },
    colorHiddenInput: { position: 'absolute' as const, opacity: 0, width: '100%', height: '100%', cursor: 'pointer', top: 0, left: 0 },
    colorLabel: { flex: 1, fontSize: 13, fontWeight: 600, color: '#334155' },
    colorVar: { fontSize: 11, fontWeight: 500, color: '#94a3b8', fontFamily: "'JetBrains Mono', 'Fira Code', monospace" },
    colorHex: { width: 90, padding: '6px 10px', borderRadius: 8, border: '1px solid #e2e8f0', fontFamily: "'JetBrains Mono', 'Fira Code', monospace", fontSize: 12, color: '#475569', textAlign: 'center' as const, background: '#f8fafc' },
    codeCard: { background: '#0f172a', borderRadius: 14, overflow: 'hidden' },
    codeHeader: { padding: '12px 20px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #1e293b' },
    codeTitle: { fontSize: 12, fontWeight: 700, color: '#64748b', textTransform: 'uppercase' as const, letterSpacing: 1 },
    codeCopy: { padding: '4px 12px', borderRadius: 6, border: '1px solid #334155', background: 'transparent', color: '#94a3b8', fontSize: 11, cursor: 'pointer', transition: 'all 0.2s' },
    codeBody: { padding: '16px 20px', fontFamily: "'JetBrains Mono', 'Fira Code', monospace", fontSize: 13, lineHeight: 1.8 },
    codeBrace: { color: '#f8fafc' },
    codeProp: { color: '#7dd3fc' },
    codeVal: { color: '#a5f3fc' },
    previewBox: { padding: 24, borderRadius: 12, background: '#f8fafc', border: '1px solid #e2e8f0' },
    previewTitle: { fontSize: 12, fontWeight: 700, textTransform: 'uppercase' as const, color: '#94a3b8', marginBottom: 16, letterSpacing: 0.8 },
    btnPrimary: { padding: '10px 24px', borderRadius: 10, border: 'none', fontWeight: 700, fontSize: 13, cursor: 'pointer', transition: 'all 0.2s', color: '#fff', boxShadow: '0 2px 8px rgba(0,0,0,0.15)' },
    btnSecondary: { padding: '10px 24px', borderRadius: 10, fontWeight: 700, fontSize: 13, cursor: 'pointer', transition: 'all 0.2s', background: 'transparent' },
    btnGhost: { padding: '10px 24px', borderRadius: 10, border: '1px solid #e2e8f0', background: 'transparent', fontWeight: 600, fontSize: 13, cursor: 'pointer', color: '#64748b' },
    alertSuccess: { padding: '14px 18px', borderRadius: 10, display: 'flex', alignItems: 'center', gap: 10, fontSize: 13, fontWeight: 500 },
    alertWarning: { padding: '14px 18px', borderRadius: 10, display: 'flex', alignItems: 'center', gap: 10, background: '#fffbeb', border: '1px solid #fde68a', color: '#92400e', fontSize: 13, fontWeight: 500 },
    statCard: { padding: 20, borderRadius: 12, background: '#fff', boxShadow: '0 1px 3px rgba(0,0,0,0.08)' },
    statLabel: { fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, letterSpacing: 0.8 },
    statValue: { fontSize: 28, fontWeight: 800, marginTop: 4, color: '#0f172a' },
    statDelta: { fontSize: 12, fontWeight: 600, marginTop: 4 },
    badge: { display: 'inline-flex', padding: '4px 14px', borderRadius: 20, fontSize: 12, fontWeight: 700, letterSpacing: 0.3 },
    progressTrack: { height: 8, borderRadius: 4, background: '#e2e8f0', overflow: 'hidden' },
    progressFill: { height: '100%', borderRadius: 4, transition: 'width 0.5s ease' },
    typoH1: { fontSize: 24, fontWeight: 800, color: '#0f172a', margin: '0 0 6px' },
    typoP: { fontSize: 14, color: '#64748b', lineHeight: 1.6, margin: 0 },
    saveBar: { display: 'flex', justifyContent: 'flex-end', gap: 12, marginBottom: 28 },
    saveBtn: { padding: '10px 28px', borderRadius: 10, border: 'none', fontWeight: 700, fontSize: 14, cursor: 'pointer', background: '#3b82f6', color: '#fff', boxShadow: '0 2px 10px rgba(59,130,246,0.3)', transition: 'all 0.2s' },
    saveBtnDisabled: { opacity: 0.5, cursor: 'not-allowed' },
    resetBtn: { padding: '10px 28px', borderRadius: 10, border: '1px solid #e2e8f0', background: '#fff', fontWeight: 600, fontSize: 14, cursor: 'pointer', color: '#64748b' },
    statusBadge: { display: 'inline-flex', alignItems: 'center', gap: 6, padding: '6px 16px', borderRadius: 20, fontSize: 12, fontWeight: 600 },
};

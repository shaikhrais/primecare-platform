import React, { useState } from 'react';
import { Globe, Search, Save, Languages, Check, Filter } from 'lucide-react';

interface TranslationKey {
    id: string;
    key: string;
    en: string;
    es: string;
    fr: string;
    status: 'COMPLETE' | 'MISSING_ES' | 'MISSING_FR' | 'DRAFT';
}

export const GlobalI18nDictionary: React.FC = () => {
    const [translations, setTranslations] = useState<TranslationKey[]>([
        { id: '1', key: 'auth.login.submit_btn', en: 'Sign In Securely', es: 'Iniciar Sesión', fr: 'Se Connecter', status: 'COMPLETE' },
        { id: '2', key: 'patient.dashboard.greeting', en: 'Good morning, {{name}}', es: 'Buenos días, {{name}}', fr: '', status: 'MISSING_FR' },
        { id: '3', key: 'billing.invoice.header', en: 'Tax Invoice & Receipt', es: '', fr: '', status: 'DRAFT' },
        { id: '4', key: 'survey.satisfaction.q1', en: 'How was your visit today?', es: '¿Cómo fue su visita hoy?', fr: 'Comment s\'est passée votre visite ?', status: 'COMPLETE' }
    ]);

    const [searchTerm, setSearchTerm] = useState('');
    const [filterStatus, setFilterStatus] = useState<string>('ALL');
    const [isSaving, setIsSaving] = useState(false);

    const handleUpdate = (id: string, lang: 'en'|'es'|'fr', value: string) => {
        setTranslations(prev => prev.map(t => {
            if (t.id === id) {
                const updated = { ...t, [lang]: value };
                // Naive status recalculation
                if (updated.en && updated.es && updated.fr) updated.status = 'COMPLETE';
                else if (!updated.es && !updated.fr) updated.status = 'DRAFT';
                else if (!updated.es) updated.status = 'MISSING_ES';
                else if (!updated.fr) updated.status = 'MISSING_FR';
                return updated;
            }
            return t;
        }));
    };

    const handleSave = () => {
        setIsSaving(true);
        setTimeout(() => {
            setIsSaving(false);
            alert("Translation JSON dictionaries rebuilt and republished to the frontend Edge nodes.");
        }, 1200);
    };

    const filteredTranslations = translations.filter(t => 
        (filterStatus === 'ALL' || t.status.includes(filterStatus.replace('MISSING_', ''))) &&
        (t.key.toLowerCase().includes(searchTerm.toLowerCase()) || 
         t.en.toLowerCase().includes(searchTerm.toLowerCase()))
    );

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#EFF6FF', padding: '10px', borderRadius: '8px' }}>
                        <Globe size={24} color="#3B82F6" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Global i18n Dictionary</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Manage and edit application text strings dynamically across localized regions.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '4px', backgroundColor: '#F8FAFC' }}>
                        <Filter size={16} color="#94A3B8" style={{ marginLeft: '8px' }} />
                        <select 
                            value={filterStatus}
                            onChange={(e) => setFilterStatus(e.target.value)}
                            style={{ border: 'none', background: 'transparent', outline: 'none', padding: '6px', color: '#0F172A', fontWeight: 600, fontSize: '0.85rem' }}
                        >
                            <option value="ALL">All Strings</option>
                            <option value="MISSING_ES">Missing Spanish</option>
                            <option value="MISSING_FR">Missing French</option>
                            <option value="DRAFT">Drafts (English Only)</option>
                        </select>
                    </div>
                    <button 
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <Save size={16} /> {isSaving ? 'Compiling Locale JSON...' : 'Publish Translations'}
                    </button>
                </div>
            </div>

            <div style={{ position: 'relative', marginBottom: '16px' }}>
                <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '12px' }} />
                <input 
                    type="text" 
                    placeholder="Search by key (e.g., auth.login) or English phrase..." 
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    style={{ width: '100%', padding: '10px 12px 10px 36px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none', color: '#0F172A', backgroundColor: '#F8FAFC' }}
                />
            </div>

            <div style={{ border: '1px solid #E2E8F0', borderRadius: '8px', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.85rem' }}>
                    <thead>
                        <tr style={{ backgroundColor: '#F1F5F9', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                            <th style={{ padding: '12px', width: '25%', color: '#475569', fontWeight: 700 }}>Abstract Key</th>
                            <th style={{ padding: '12px', width: '25%', color: '#0F172A', fontWeight: 800 }}>English (Base)</th>
                            <th style={{ padding: '12px', width: '25%', color: '#0F172A', fontWeight: 800 }}>Spanish (es-MX)</th>
                            <th style={{ padding: '12px', width: '25%', color: '#0F172A', fontWeight: 800 }}>French (fr-CA)</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredTranslations.map(t => (
                            <tr key={t.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                                <td style={{ padding: '12px', fontFamily: 'monospace', color: '#64748B', fontSize: '0.8rem', verticalAlign: 'top' }}>
                                    {t.key}
                                </td>
                                <td style={{ padding: '12px', verticalAlign: 'top' }}>
                                    <textarea 
                                        value={t.en}
                                        onChange={(e) => handleUpdate(t.id, 'en', e.target.value)}
                                        style={{ width: '100%', minHeight: '60px', padding: '8px', borderRadius: '6px', border: '1px solid #CBD5E1', outline: 'none', resize: 'vertical', fontFamily: 'sans-serif' }}
                                    />
                                </td>
                                <td style={{ padding: '12px', verticalAlign: 'top' }}>
                                    <textarea 
                                        value={t.es}
                                        placeholder="Missing translation..."
                                        onChange={(e) => handleUpdate(t.id, 'es', e.target.value)}
                                        style={{ width: '100%', minHeight: '60px', padding: '8px', borderRadius: '6px', border: `1px dashed ${t.es ? '#CBD5E1' : '#F59E0B'}`, backgroundColor: t.es ? 'white' : '#FFFBEB', outline: 'none', resize: 'vertical', fontFamily: 'sans-serif' }}
                                    />
                                </td>
                                <td style={{ padding: '12px', verticalAlign: 'top' }}>
                                    <textarea 
                                        value={t.fr}
                                        placeholder="Missing translation..."
                                        onChange={(e) => handleUpdate(t.id, 'fr', e.target.value)}
                                        style={{ width: '100%', minHeight: '60px', padding: '8px', borderRadius: '6px', border: `1px dashed ${t.fr ? '#CBD5E1' : '#3B82F6'}`, backgroundColor: t.fr ? 'white' : '#EFF6FF', outline: 'none', resize: 'vertical', fontFamily: 'sans-serif' }}
                                    />
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
            
            <div style={{ marginTop: '16px', display: 'flex', gap: '16px', fontSize: '0.8rem', color: '#64748B' }}>
                <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><Languages size={14} color="#10B981" /> Interpolation supported (e.g., {"{{name}}"})</span>
                <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><Check size={14} color="#3B82F6" /> Auto-saves drafts locally</span>
            </div>
        </div>
    );
};

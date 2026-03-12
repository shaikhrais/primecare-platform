import React, { useState } from 'react';
import { Type, CheckSquare, Calendar, AlignLeft, Hash, Save, LayoutTemplate, PlusCircle, Trash2 } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface SchemaField {
    id: string;
    label: string;
    type: 'string' | 'number' | 'text' | 'boolean' | 'date';
    required: boolean;
}

export const FormSchemaFederator: React.FC = () => {
    const [fields, setFields] = useState<SchemaField[]>([
        { id: 'f1', label: 'Patient First Name', type: 'string', required: true },
        { id: 'f2', label: 'Known Allergies', type: 'text', required: false },
        { id: 'f3', label: 'Date of Birth', type: 'date', required: true }
    ]);
    const [formName, setFormName] = useState('New Intake Questionnaire');
    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const getFieldIcon = (type: string) => {
        switch(type) {
            case 'string': return <Type size={16} color="#3B82F6" />;
            case 'text': return <AlignLeft size={16} color="#8B5CF6" />;
            case 'number': return <Hash size={16} color="#F59E0B" />;
            case 'boolean': return <CheckSquare size={16} color="#10B981" />;
            case 'date': return <Calendar size={16} color="#F43F5E" />;
            default: return <Type size={16} />;
        }
    };

    const handleAddField = (type: SchemaField['type']) => {
        setFields(prev => [...prev, { id: `f_${Date.now()}`, label: 'New Field', type, required: false }]);
    };

    const handleRemoveField = (id: string) => {
        setFields(prev => prev.filter(f => f.id !== id));
    };

    const handleUpdateField = (id: string, key: keyof SchemaField, value: any) => {
        setFields(prev => prev.map(f => f.id === id ? { ...f, [key]: value } : f));
    };

    const handleSave = async () => {
        setIsSaving(true);
        try {
            await apiClient.post('/platform/admin/dam/workflows/schemas', { formName, fields });
            showToast("Dynamic JSON schema persisted! Frontend forms will universally reflect these changes immediately.", "success");
        } catch (error) {
            showToast("Failed to map dictionary format", "error");
        } finally {
            setIsSaving(false);
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#EFF6FF', padding: '10px', borderRadius: '8px' }}>
                        <LayoutTemplate size={24} color="#3B82F6" />
                    </div>
                    <div>
                        <input 
                            value={formName}
                            onChange={(e) => setFormName(e.target.value)}
                            style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800, border: 'none', borderBottom: '1px dashed #CBD5E1', padding: '2px 0', outline: 'none', backgroundColor: 'transparent', width: '300px' }}
                        />
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Build JSON schemas to dynamically generate React forms anywhere.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '8px' }}>
                    <div style={{ backgroundColor: '#1E293B', color: 'white', padding: '8px', borderRadius: '8px', display: 'flex', gap: '4px' }}>
                        <button onClick={() => handleAddField('string')} style={{ background: 'transparent', border: 'none', color: 'white', cursor: 'pointer' }} title="Add Short Text"><Type size={18} /></button>
                        <button onClick={() => handleAddField('text')} style={{ background: 'transparent', border: 'none', color: 'white', cursor: 'pointer' }} title="Add Long Text"><AlignLeft size={18} /></button>
                        <button onClick={() => handleAddField('number')} style={{ background: 'transparent', border: 'none', color: 'white', cursor: 'pointer' }} title="Add Number"><Hash size={18} /></button>
                        <button onClick={() => handleAddField('boolean')} style={{ background: 'transparent', border: 'none', color: 'white', cursor: 'pointer' }} title="Add Checkbox"><CheckSquare size={18} /></button>
                        <button onClick={() => handleAddField('date')} style={{ background: 'transparent', border: 'none', color: 'white', cursor: 'pointer' }} title="Add Date"><Calendar size={18} /></button>
                    </div>

                    <button 
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#2563EB', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <Save size={16} /> Publish Schema
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Visual Editor */}
                <div style={{ flex: 1, border: '1px solid #E2E8F0', borderRadius: '8px', padding: '16px', backgroundColor: '#F8FAFC', minHeight: '400px', display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    {fields.map(field => (
                        <div key={field.id} style={{ display: 'flex', alignItems: 'center', gap: '12px', backgroundColor: 'white', padding: '12px', borderRadius: '6px', border: '1px solid #CBD5E1', boxShadow: '0 1px 2px rgba(0,0,0,0.05)' }}>
                            <div style={{ padding: '6px', backgroundColor: '#F1F5F9', borderRadius: '4px' }}>
                                {getFieldIcon(field.type)}
                            </div>
                            
                            <input 
                                value={field.label}
                                onChange={(e) => handleUpdateField(field.id, 'label', e.target.value)}
                                style={{ flex: 1, border: 'none', borderBottom: '1px solid #E2E8F0', padding: '4px 0', fontSize: '0.9rem', color: '#0F172A', fontWeight: 600, outline: 'none' }}
                            />

                            <label style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem', color: '#475569', cursor: 'pointer' }}>
                                <input 
                                    type="checkbox" 
                                    checked={field.required}
                                    onChange={(e) => handleUpdateField(field.id, 'required', e.target.checked)}
                                /> Required API payload
                            </label>

                            <button onClick={() => handleRemoveField(field.id)} style={{ background: 'transparent', border: 'none', color: '#EF4444', cursor: 'pointer', padding: '4px' }}>
                                <Trash2 size={16} />
                            </button>
                        </div>
                    ))}
                    
                    {fields.length === 0 && (
                        <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.9rem', border: '2px dashed #CBD5E1', borderRadius: '6px' }}>
                            No fields established in mapping schema.
                        </div>
                    )}
                </div>

                {/* Live JSON Preview */}
                <div style={{ width: '350px', backgroundColor: '#0F172A', borderRadius: '8px', padding: '16px', color: '#E2E8F0', overflowY: 'auto', fontFamily: 'monospace', fontSize: '0.8rem' }}>
                    <div style={{ color: '#94A3B8', textTransform: 'uppercase', fontSize: '0.7rem', fontWeight: 800, marginBottom: '12px', letterSpacing: '1px' }}>Generated Schema Payload</div>
                    <pre style={{ margin: 0, whiteSpace: 'pre-wrap' }}>
{JSON.stringify({
    formName,
    version: '1.0.0',
    fields: fields.map(f => ({
        key: f.label.toLowerCase().replace(/[^a-z0-9]/g, '_'),
        label: f.label,
        type: f.type,
        required: f.required
    }))
}, null, 2)}
                    </pre>
                </div>
            </div>
        </div>
    );
};

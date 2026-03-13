import React, { useState } from 'react';
import { Search, BookOpen, Video, FileText } from 'lucide-react';
import { useNotification } from '@/shared/context/NotificationContext';

export const ResourceLibrary: React.FC = () => {
    const { showToast } = useNotification();
    const [query, setQuery] = useState('');

    const resources = [
        { id: '1', title: 'Hoyer Lift Operation (Video)', type: 'video', icon: <Video /> },
        { id: '2', title: 'Catheter Bag Exchange Protocol', type: 'document', icon: <FileText /> },
        { id: '3', title: 'Managing Aggressive Behaviors', type: 'guide', icon: <BookOpen /> },
        { id: '4', title: 'Emergency Anaphylaxis Response', type: 'document', icon: <FileText /> }
    ];

    const filtered = resources.filter(r => r.title.toLowerCase().includes(query.toLowerCase()));

    const handleOpen = (title: string) => {
        showToast(`Opening resource: ${title}`, 'info');
    };

    return (
        <div style={{ backgroundColor: '#FFFFFF', borderRadius: '16px', border: '1px solid #E5E7EB', padding: '24px' }}>
            <h3 data-cy="h3-psw.resource-library-0" style={{ margin: '0 0 16px 0', fontSize: '1.2rem', fontWeight: 800, color: '#111827', display: 'flex', alignItems: 'center', gap: '8px' }}>
                <BookOpen size={20} color="#3B82F6" /> Clinical Resource Library
            </h3>
            <p style={{ color: '#4B5563', fontSize: '0.9rem', marginBottom: '20px' }}>
                Quick reference guides and protocol videos for field procedures.
            </p>

            <div style={{ position: 'relative', marginBottom: '16px' }}>
                <Search size={18} color="#9CA3AF" style={{ position: 'absolute', left: '12px', top: '14px' }} />
                <input data-cy="input-psw.resource-library-0"
                    type="text"
                    placeholder="Search Hoyer lift, Catheter, CPR..."
                    value={query}
                    onChange={e => setQuery(e.target.value)}
                    style={{ width: '100%', padding: '12px 12px 12px 40px', borderRadius: '8px', border: '1px solid #D1D5DB', boxSizing: 'border-box' }}
                />
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {filtered.map(r => (
                    <button data-cy="btn-psw.resource-library-0"
                        key={r.id}
                        onClick={() => handleOpen(r.title)}
                        style={{ display: 'flex', alignItems: 'center', gap: '12px', padding: '12px', backgroundColor: '#F9FAFB', border: '1px solid #E5E7EB', borderRadius: '8px', cursor: 'pointer', textAlign: 'left', transition: 'background 0.2s' }}
                    >
                        <div style={{ padding: '8px', backgroundColor: '#EFF6FF', color: '#3B82F6', borderRadius: '8px' }}>
                            {r.icon}
                        </div>
                        <div style={{ fontWeight: 600, color: '#374151' }}>{r.title}</div>
                    </button>
                ))}
            </div>
        </div>
    );
};

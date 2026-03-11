import React, { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { Search, User, ClipboardList, Briefcase, X } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface SearchResult {
    id: string;
    type: 'patient' | 'staff' | 'module';
    name: string;
    subtitle: string;
    route: string;
}

export const CommandPalette: React.FC = () => {
    const [isOpen, setIsOpen] = useState(false);
    const [query, setQuery] = useState('');
    const [results, setResults] = useState<SearchResult[]>([]);
    const inputRef = useRef<HTMLInputElement>(null);
    const navigate = useNavigate();

    // Suggestion 21: Global Command Palette Listener
    useEffect(() => {
        const handleKeyDown = (e: KeyboardEvent) => {
            if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
                e.preventDefault();
                setIsOpen(prev => !prev);
            }
            if (e.key === 'Escape' && isOpen) {
                setIsOpen(false);
            }
        };

        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [isOpen]);

    useEffect(() => {
        if (isOpen && inputRef.current) {
            inputRef.current.focus();
        }
    }, [isOpen]);

    // Fetch live search results
    useEffect(() => {
        if (!isOpen) return;

        if (!query.trim()) {
            setResults([
                { id: 'm1', type: 'module', name: 'Logistics Fleet Map', subtitle: 'Live Fleet Radar', route: '/tenancy/manager/logistics' },
                { id: 'm2', type: 'module', name: 'Staff Marketplace', subtitle: 'Open Shifts Board', route: '/tenancy/manager/scheduling' },
            ]);
            return;
        }

        const fetchResults = async () => {
             try {
                 const res = await fetch(`/api/v1/system/data/search?q=${encodeURIComponent(query)}`);
                 if (res.ok) {
                     const data = await res.json();
                     setResults(data);
                 }
             } catch (e) {
                 console.error('Command Palette Search Error', e);
             }
        };

        const debounce = window.setTimeout(fetchResults, 300);
        return () => window.clearTimeout(debounce);
    }, [query, isOpen]);

    if (!isOpen) return null;

    return (
        <div style={{
            position: 'fixed',
            inset: 0,
            backgroundColor: 'rgba(15, 23, 42, 0.4)',
            backdropFilter: 'blur(4px)',
            zIndex: 99999,
            display: 'flex',
            alignItems: 'flex-start',
            justifyContent: 'center',
            paddingTop: '10vh'
        }}>
            <div
                style={{
                    backgroundColor: 'white',
                    width: '100%',
                    maxWidth: '600px',
                    borderRadius: '16px',
                    boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
                    overflow: 'hidden',
                    display: 'flex',
                    flexDirection: 'column'
                }}
                onClick={(e) => e.stopPropagation()} // Prevent closing when clicking inside
            >
                <div style={{ display: 'flex', alignItems: 'center', padding: '16px 24px', borderBottom: '1px solid #E2E8F0' }}>
                    <Search color="#94A3B8" size={24} />
                    <input
                        ref={inputRef}
                        value={query}
                        onChange={(e) => setQuery(e.target.value)}
                        placeholder="Search patients, staff, or modules... (Ctrl+K)"
                        style={{
                            flex: 1,
                            border: 'none',
                            outline: 'none',
                            fontSize: '1.2rem',
                            padding: '0 16px',
                            backgroundColor: 'transparent',
                            color: '#0F172A'
                        }}
                    />
                    <button
                        onClick={() => setIsOpen(false)}
                        style={{ background: 'transparent', border: 'none', color: '#94A3B8', cursor: 'pointer', padding: '4px', display: 'flex' }}
                    >
                        <X size={20} />
                    </button>
                </div>

                <div style={{ padding: '8px 0', maxHeight: '400px', overflowY: 'auto' }}>
                    {results.length === 0 ? (
                        <div style={{ padding: '32px', textAlign: 'center', color: '#94A3B8', fontSize: '0.95rem' }}>
                            No results found for "{query}".
                        </div>
                    ) : (
                        <ul style={{ listStyle: 'none', margin: 0, padding: 0 }}>
                            {results.map((result, idx) => (
                                <li key={result.id}>
                                    <button
                                        onClick={() => {
                                            setIsOpen(false);
                                            navigate(result.route);
                                        }}
                                        style={{
                                            width: '100%',
                                            display: 'flex',
                                            alignItems: 'center',
                                            gap: '16px',
                                            padding: '12px 24px',
                                            backgroundColor: idx === 0 && query ? '#F8FAFC' : 'transparent', // Simulate auto-focus first item if typing
                                            border: 'none',
                                            textAlign: 'left',
                                            cursor: 'pointer',
                                            transition: 'background-color 0.1s'
                                        }}
                                        onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = '#F8FAFC')}
                                        onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = 'transparent')}
                                    >
                                        <div style={{
                                            width: '40px', height: '40px',
                                            backgroundColor: result.type === 'patient' ? '#FEF2F2' : result.type === 'staff' ? '#EFF6FF' : '#F0FDF4',
                                            color: result.type === 'patient' ? '#EF4444' : result.type === 'staff' ? '#3B82F6' : '#22C55E',
                                            borderRadius: '8px',
                                            display: 'flex', alignItems: 'center', justifyContent: 'center'
                                        }}>
                                            {result.type === 'patient' && <User size={20} />}
                                            {result.type === 'staff' && <Briefcase size={20} />}
                                            {result.type === 'module' && <ClipboardList size={20} />}
                                        </div>
                                        <div>
                                            <div style={{ fontWeight: 700, color: '#0F172A', fontSize: '1rem' }}>{result.name}</div>
                                            <div style={{ color: '#64748B', fontSize: '0.85rem' }}>{result.subtitle}</div>
                                        </div>
                                    </button>
                                </li>
                            ))}
                        </ul>
                    )}
                </div>

                <div style={{ padding: '12px 24px', backgroundColor: '#F8FAFC', borderTop: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <span style={{ fontSize: '0.8rem', color: '#94A3B8', fontWeight: 600 }}>PrimeCare Global Command Array</span>
                    <span style={{ fontSize: '0.8rem', color: '#94A3B8', display: 'flex', gap: '8px' }}>
                        <span style={{ backgroundColor: '#E2E8F0', padding: '2px 6px', borderRadius: '4px', color: '#475569' }}>↑↓</span> to navigate
                        <span style={{ backgroundColor: '#E2E8F0', padding: '2px 6px', borderRadius: '4px', color: '#475569' }}>↵</span> to select
                    </span>
                </div>
            </div>

            {/* Capture clicks outside the modal to close */}
            <div style={{ position: 'absolute', inset: 0, zIndex: -1 }} onClick={() => setIsOpen(false)} />
        </div>
    );
};

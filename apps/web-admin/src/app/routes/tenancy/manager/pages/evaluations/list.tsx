import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router';
import { useToast as useNotification } from '@/shared/hooks/useToast';

const API_URL = import.meta.env.VITE_API_URL;

export default function EvaluationsList() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [evaluations, setEvaluations] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchEvaluations = async () => {
            try {
                const token = localStorage.getItem('token');
 // the endpoint response for now as backend might not be ready
                // In real implementation: const res = await fetch(`${API_URL}/v1/manager/evaluations`, ...);

 // fetch
                setTimeout(() => {
                    setEvaluations([
                        { id: '1', staffName: 'John Walker', date: '2026-02-10', score: 8, status: 'Completed' },
                        { id: '2', staffName: 'Sarah Jenkins', date: '2026-02-12', score: 9, status: 'Completed' }
                    ]);
                    setLoading(false);
                }, 500);

            } catch (error) {
                console.error(error);
                showToast('Failed to load evaluations', 'error');
                setLoading(false);
            }
        };

        fetchEvaluations();
    }, []);

    return (
        <div style={{ padding: '2rem' }} data-cy="evaluations-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', margin: 0 }} data-cy="page.title">Staff Evaluations</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }} data-cy="page.subtitle">Review performance history and compliance.</p>
                </div>
                <button
                    data-cy="btn-new-evaluation"
                    onClick={() => navigate('/manager/evaluations/new')}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}
                >
                    + New Evaluation
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', boxShadow: '0 1px 3px 0 rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table data-cy="table-manager.list" style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Date</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Staff Name</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Score</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Status</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={5} style={{ padding: '2rem', textAlign: 'center' }}>Loading...</td></tr>
                        ) : evaluations.length > 0 ? (
                            evaluations.map((evaluation) => (
                                <tr key={evaluation.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem', color: '#111827' }}>{evaluation.date}</td>
                                    <td style={{ padding: '1rem', color: '#111827' }}>{evaluation.staffName}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{
                                            padding: '0.25rem 0.5rem',
                                            borderRadius: '9999px',
                                            backgroundColor: evaluation.score >= 8 ? '#dcfce7' : '#fef3c7',
                                            color: evaluation.score >= 8 ? '#166534' : '#92400e',
                                            fontWeight: '600',
                                            fontSize: '0.75rem'
                                        }}>
                                            {evaluation.score}/10
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem', color: '#6b7280' }}>{evaluation.status}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <button data-cy="btn-manager.list-0"
                                            onClick={() => navigate(`/manager/evaluations/${evaluation.id}`)}
                                            style={{ color: '#004d40', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer' }}
                                        >
                                            View
                                        </button>
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr><td colSpan={5} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>No evaluations found.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

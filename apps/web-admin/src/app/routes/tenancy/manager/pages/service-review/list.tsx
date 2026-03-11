import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

export default function ServiceReviewsList() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [reviews, setReviews] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchReviews = async () => {
            try {
                const token = localStorage.getItem('token');
 // the endpoint response for now
                // In real implementation: const res = await fetch(`${API_URL}/v1/manager/service-reviews`, ...);

 // fetch
                setTimeout(() => {
                    setReviews([
                        { id: '1', clientName: 'Alice Thompson', date: '2026-02-14', category: 'Nursing', score: 10, status: 'Completed' },
                        { id: '2', clientName: 'Robert Miller', date: '2026-02-11', category: 'Personal Care', score: 8, status: 'Follow-up Required' }
                    ]);
                    setLoading(false);
                }, 500);

            } catch (error) {
                console.error(error);
                showToast('Failed to load service reviews', 'error');
                setLoading(false);
            }
        };

        fetchReviews();
    }, []);

    return (
        <div style={{ padding: '2rem' }} data-cy="service-reviews-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', margin: 0 }} data-cy="page.title">Service Reviews</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }} data-cy="page.subtitle">Audit service delivery quality and client satisfaction.</p>
                </div>
                <button
                    data-cy="btn-new-review"
                    onClick={() => navigate('/manager/service-reviews/new')}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}
                >
                    + New Review
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', boxShadow: '0 1px 3px 0 rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Date</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Client Name</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Category</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Score</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={5} style={{ padding: '2rem', textAlign: 'center' }}>Loading...</td></tr>
                        ) : reviews.length > 0 ? (
                            reviews.map((review) => (
                                <tr key={review.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem', color: '#111827' }}>{review.date}</td>
                                    <td style={{ padding: '1rem', color: '#111827' }}>{review.clientName}</td>
                                    <td style={{ padding: '1rem', color: '#6b7280' }}>{review.category}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{
                                            padding: '0.25rem 0.5rem',
                                            borderRadius: '9999px',
                                            backgroundColor: review.score >= 9 ? '#dcfce7' : review.score >= 7 ? '#fef3c7' : '#fee2e2',
                                            color: review.score >= 9 ? '#166534' : review.score >= 7 ? '#92400e' : '#991b1b',
                                            fontWeight: '600',
                                            fontSize: '0.75rem'
                                        }}>
                                            {review.score}/10
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <button
                                            onClick={() => navigate(`/manager/service-reviews/${review.id}`)}
                                            style={{ color: '#004d40', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer' }}
                                        >
                                            View
                                        </button>
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr><td colSpan={5} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>No reviews found.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

import { AdminRegistry } from 'prime-care-shared';
import React, { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import ReactMarkdown from 'react-markdown';

const KnowledgeBaseArticle: React.FC = () => {
    const { slug } = useParams<{ slug: string }>();
    const [content, setContent] = useState<string | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(false);

    useEffect(() => {
        const fetchContent = async () => {
            setLoading(true);
            setError(false);
            try {
                // Fetch the markdown file from the public directory
                const response = await fetch(`/knowledge-base/${slug}.md`);
                if (!response.ok) throw new Error('Not found');
                const text = await response.text();
                setContent(text);
            } catch (err) {
                console.error('Error fetching article:', err);
                setError(true);
            } finally {
                setLoading(false);
            }
        };

        if (slug) {
            fetchContent();
        }
    }, [slug]);

    return (
        <div style={{ padding: '24px', maxWidth: '800px', margin: '0 auto' }}>
            <Link
                to={AdminRegistry.RouteRegistry.SUPPORT}
                style={{
                    display: 'inline-flex',
                    alignItems: 'center',
                    gap: '8px',
                    textDecoration: 'none',
                    color: '#6B7280',
                    fontSize: '14px',
                    fontWeight: '500',
                    marginBottom: '24px',
                    transition: 'color 0.2s'
                }}
            >
                ← Back to Index
            </Link>

            <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '48px 32px', border: '1px solid #E5E7EB', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
                {loading && (
                    <div style={{ textAlign: 'center', padding: '40px', color: '#6B7280' }}>
                        Loading article content...
                    </div>
                )}

                {error && (
                    <div style={{ textAlign: 'center', padding: '40px', color: '#EF4444' }}>
                        Failed to load the article. It may have been moved or doesn't exist.
                    </div>
                )}

                {!loading && !error && content && (
                    <div className="markdown-content" style={{ color: '#111827', lineHeight: '1.6', fontSize: '16px' }}>
                        <ReactMarkdown>
                            {content}
                        </ReactMarkdown>
                    </div>
                )}
            </div>
        </div>
    );
};

export default KnowledgeBaseArticle;

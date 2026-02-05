import React, { useEffect, useState } from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface BlogPost {
    id: string;
    title: string;
    excerpt: string;
    slug: string;
    publishedAt: string;
    author?: string;
}

export default function BlogPage() {
    const [posts, setPosts] = useState<BlogPost[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchPosts = async () => {
            try {
                const res = await fetch(`${API_URL}/v1/public/blog`);
                const data = await res.json();
                if (Array.isArray(data)) {
                    setPosts(data);
                } else {
                    // Fallback mock data
                    setPosts([
                        { id: '1', slug: 'understanding-home-care', title: 'Understanding Home Care', excerpt: 'A comprehensive guide to choosing the right care for your loved ones at home.', publishedAt: '2026-01-15', author: 'Sarah Johnson, RN' },
                        { id: '2', slug: 'benefits-of-psw-support', title: 'Benefits of PSW Support', excerpt: 'How professional support workers improve quality of life for seniors and individuals with disabilities.', publishedAt: '2026-01-20', author: 'Michael Chen' },
                        { id: '3', slug: 'foot-care-diabetes', title: 'Foot Care for Diabetics', excerpt: 'Essential tips for diabetic foot care and preventing complications.', publishedAt: '2026-02-01', author: 'Dr. Emily Brown' },
                    ]);
                }
            } catch (e) {
                // Fallback mock data on error
                setPosts([
                    { id: '1', slug: 'understanding-home-care', title: 'Understanding Home Care', excerpt: 'A comprehensive guide to choosing the right care for your loved ones at home.', publishedAt: '2026-01-15', author: 'Sarah Johnson, RN' },
                    { id: '2', slug: 'benefits-of-psw-support', title: 'Benefits of PSW Support', excerpt: 'How professional support workers improve quality of life for seniors and individuals with disabilities.', publishedAt: '2026-01-20', author: 'Michael Chen' },
                    { id: '3', slug: 'foot-care-diabetes', title: 'Foot Care for Diabetics', excerpt: 'Essential tips for diabetic foot care and preventing complications.', publishedAt: '2026-02-01', author: 'Dr. Emily Brown' },
                ]);
            } finally {
                setLoading(false);
            }
        };
        fetchPosts();
    }, []);

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif', maxWidth: '1000px', margin: '0 auto', padding: '4rem 2rem' }}>
            <Helmet>
                <title>{ContentRegistry.BLOG.TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <h1 style={{ color: '#00897b', fontSize: '2.5rem', textAlign: 'center', marginBottom: '1rem' }}>{ContentRegistry.BLOG.TITLE}</h1>
            <p style={{ textAlign: 'center', fontSize: '1.2rem', color: '#666', marginBottom: '3rem' }}>{ContentRegistry.BLOG.SUBTITLE}</p>

            {loading ? (
                <p style={{ textAlign: 'center' }}>Loading articles...</p>
            ) : (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '2rem' }}>
                    {posts.map(post => (
                        <article key={post.id} style={{ border: '1px solid #eee', borderRadius: '12px', overflow: 'hidden', boxShadow: '0 4px 6px rgba(0,0,0,0.05)' }}>
                            <div style={{ height: '160px', backgroundColor: '#e8f5e9', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                <span style={{ fontSize: '3rem' }}>📝</span>
                            </div>
                            <div style={{ padding: '1.5rem' }}>
                                <h2 style={{ fontSize: '1.25rem', marginBottom: '0.5rem', color: '#333' }}>{post.title}</h2>
                                <p style={{ fontSize: '0.875rem', color: '#888', marginBottom: '1rem' }}>
                                    {new Date(post.publishedAt).toLocaleDateString()} {post.author && `• ${post.author}`}
                                </p>
                                <p style={{ color: '#666', lineHeight: '1.6', marginBottom: '1rem' }}>{post.excerpt}</p>
                                <Link to={`${RouteRegistry.BLOG}/${post.slug}`} style={{ color: '#00897b', fontWeight: 'bold', textDecoration: 'none' }}>
                                    Read More →
                                </Link>
                            </div>
                        </article>
                    ))}
                </div>
            )}

            <div style={{ textAlign: 'center', marginTop: '4rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}

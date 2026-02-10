import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface BlogPost {
    id: string;
    title: string;
    content: string;
    slug: string;
    publishedAt: string;
    author?: string;
}

export default function BlogPostPage() {
    const { slug } = useParams();
    const [post, setPost] = useState<BlogPost | null>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchPost = async () => {
            try {
                const res = await fetch(`${API_URL}/v1/public/blog/${slug}`);
                if (res.ok) {
                    const data = await res.json();
                    setPost(data);
                } else {
                    // Fallback mock content
                    setPost({
                        id: '1',
                        slug: slug || 'unknown',
                        title: 'Understanding Home Care',
                        content: `
                            <h2>What is Home Care?</h2>
                            <p>Home care refers to a wide range of health and support services provided in the comfort of your own home. These services are designed to help individuals maintain their independence while receiving the care they need.</p>
                            
                            <h2>Types of Home Care Services</h2>
                            <p>There are several types of home care services available:</p>
                            <ul>
                                <li><strong>Personal Support:</strong> Assistance with daily activities like bathing, dressing, and meal preparation</li>
                                <li><strong>Nursing Care:</strong> Medical services provided by registered nurses</li>
                                <li><strong>Therapy Services:</strong> Physical, occupational, and speech therapy</li>
                                <li><strong>Companionship:</strong> Social support and supervision</li>
                            </ul>

                            <h2>Benefits of Home Care</h2>
                            <p>Choosing home care offers numerous advantages:</p>
                            <ul>
                                <li>Comfort of familiar surroundings</li>
                                <li>Personalized one-on-one attention</li>
                                <li>Flexibility in scheduling</li>
                                <li>Cost-effective compared to facility care</li>
                                <li>Maintains independence and dignity</li>
                            </ul>

                            <h2>How to Get Started</h2>
                            <p>If you're considering home care for yourself or a loved one, the first step is to schedule a consultation. Our care coordinators will assess your needs and create a personalized care plan.</p>
                        `,
                        publishedAt: '2026-01-15',
                        author: 'Sarah Johnson, RN',
                    });
                }
            } catch (e) {
                setPost(null);
            } finally {
                setLoading(false);
            }
        };
        fetchPost();
    }, [slug]);

    if (loading) {
        return <div style={{ padding: '4rem', textAlign: 'center' }}>Loading...</div>;
    }

    if (!post) {
        return (
            <div style={{ padding: '4rem', textAlign: 'center' }}>
                <h1>Article Not Found</h1>
                <p>The article you're looking for doesn't exist.</p>
                <Link to={RouteRegistry.BLOG} style={{ color: '#00897b' }}>Back to Blog</Link>
            </div>
        );
    }

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif', maxWidth: '800px', margin: '0 auto', padding: '4rem 2rem' }}>
            <Helmet>
                <title>{post.title} | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <Link to={RouteRegistry.BLOG} data-cy="btn-back-to-blog" style={{ color: '#00897b', textDecoration: 'none', marginBottom: '2rem', display: 'inline-block' }}>
                ← Back to Blog
            </Link>

            <article>
                <h1 style={{ color: '#00897b', fontSize: '2.5rem', marginBottom: '1rem' }}>{post.title}</h1>
                <p style={{ color: '#888', marginBottom: '2rem' }}>
                    Published on {new Date(post.publishedAt).toLocaleDateString()}
                    {post.author && ` by ${post.author}`}
                </p>

                <div
                    style={{ lineHeight: '1.8', color: '#444' }}
                    dangerouslySetInnerHTML={{ __html: post.content }}
                />
            </article>

            <div style={{ marginTop: '4rem', paddingTop: '2rem', borderTop: '1px solid #eee' }}>
                <h3 style={{ marginBottom: '1rem' }}>Need Help?</h3>
                <p>
                    If you have questions about home care services, <Link to={RouteRegistry.CONTACT} data-cy="lnk-blog-contact" style={{ color: '#00897b' }}>contact us</Link> or <Link to={RouteRegistry.BOOKING} data-cy="lnk-blog-booking" style={{ color: '#00897b' }}>book a consultation</Link>.
                </p>
            </div>
        </div>
    );
}

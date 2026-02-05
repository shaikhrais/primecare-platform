import React, { useState, useEffect } from 'react';

const API_URL = import.meta.env.VITE_API_URL;

export default function ContentManager() {
    const [activeTab, setActiveTab] = useState('blogs');
    const [blogs, setBlogs] = useState<any[]>([]);
    const [faqs, setFaqs] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchData = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const endpoint = activeTab === 'blogs' ? '/v1/admin/blog' : '/v1/admin/faqs';
            const res = await fetch(`${API_URL}${endpoint}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (res.ok) {
                const data = await res.json();
                if (activeTab === 'blogs') setBlogs(data);
                else setFaqs(data);
            }
        } catch (err) {
            console.error(err);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchData();
    }, [activeTab]);

    return (
        <div style={{ maxWidth: '1000px', margin: '0 auto', padding: '1rem' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }}>Content Management</h2>
                <p style={{ color: '#6b7280' }}>Manage blog posts and FAQ items for the marketing website.</p>
            </div>

            <div style={{ display: 'flex', gap: '2rem', marginBottom: '2rem', borderBottom: '1px solid #e5e7eb' }}>
                <button
                    onClick={() => setActiveTab('blogs')}
                    style={{
                        paddingBottom: '1rem',
                        borderBottom: activeTab === 'blogs' ? '2px solid #004d40' : 'none',
                        color: activeTab === 'blogs' ? '#004d40' : '#6b7280',
                        fontWeight: '600',
                        background: 'none',
                        border: 'none',
                        cursor: 'pointer'
                    }}
                >
                    Blog Posts
                </button>
                <button
                    onClick={() => setActiveTab('faqs')}
                    style={{
                        paddingBottom: '1rem',
                        borderBottom: activeTab === 'faqs' ? '2px solid #004d40' : 'none',
                        color: activeTab === 'faqs' ? '#004d40' : '#6b7280',
                        fontWeight: '600',
                        background: 'none',
                        border: 'none',
                        cursor: 'pointer'
                    }}
                >
                    FAQs
                </button>
            </div>

            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1.5rem' }}>
                    <h3 style={{ margin: 0, textTransform: 'capitalize' }}>{activeTab} List</h3>
                    <button style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', fontWeight: '600' }}>
                        + Add New {activeTab === 'blogs' ? 'Post' : 'Item'}
                    </button>
                </div>

                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead>
                        <tr style={{ textAlign: 'left', color: '#6b7280', fontSize: '0.875rem', borderBottom: '1px solid #f3f4f6' }}>
                            <th style={{ padding: '1rem' }}>{activeTab === 'blogs' ? 'Title' : 'Question'}</th>
                            <th style={{ padding: '1rem' }}>{activeTab === 'blogs' ? 'Date' : 'Category'}</th>
                            <th style={{ padding: '1rem' }}>Status</th>
                            <th style={{ padding: '1rem' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={4} style={{ padding: '2rem', textAlign: 'center' }}>Loading...</td></tr>
                        ) : activeTab === 'blogs' ? (
                            blogs.length > 0 ? blogs.map(blog => (
                                <tr key={blog.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem', fontWeight: '500' }}>{blog.title}</td>
                                    <td style={{ padding: '1rem', color: '#6b7280' }}>{new Date(blog.createdAt).toLocaleDateString()}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{ padding: '0.25rem 0.5rem', borderRadius: '9999px', backgroundColor: blog.status === 'published' ? '#ecfdf5' : '#fef3c7', color: blog.status === 'published' ? '#065f46' : '#92400e', fontSize: '0.75rem' }}>
                                            {blog.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <button style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', marginRight: '1rem' }}>Edit</button>
                                        <button style={{ color: '#dc2626', background: 'none', border: 'none', cursor: 'pointer' }}>Delete</button>
                                    </td>
                                </tr>
                            )) : <tr><td colSpan={4} style={{ padding: '2rem', textAlign: 'center' }}>No blogs found.</td></tr>
                        ) : (
                            faqs.length > 0 ? faqs.map(faq => (
                                <tr key={faq.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem', fontWeight: '500' }}>{faq.question}</td>
                                    <td style={{ padding: '1rem', color: '#6b7280' }}>{faq.category}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{ padding: '0.25rem 0.5rem', borderRadius: '9999px', backgroundColor: '#ecfdf5', color: '#065f46', fontSize: '0.75rem' }}>Active</span>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <button style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', marginRight: '1rem' }}>Edit</button>
                                        <button style={{ color: '#dc2626', background: 'none', border: 'none', cursor: 'pointer' }}>Delete</button>
                                    </td>
                                </tr>
                            )) : <tr><td colSpan={4} style={{ padding: '2rem', textAlign: 'center' }}>No FAQs found.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

// ================================================================
// PAGE IDENTITY: T27 � Provider Social
// Type: Tool | Owner: psw
// ================================================================
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

interface Post {
    id: string;
    author: string;
    role: string;
    content: string;
    time: string;
    likes: number;
    comments: number;
    type: 'announcement' | 'peer-support' | 'celebration';
}

export default function ProviderSocial() {
    const { t } = useTranslation();
    const [posts, setPosts] = useState<Post[]>([
        { id: '1', author: 'Franchise Admin', role: 'System', content: 'New vaccination protocols for Region 4 have been uploaded to the Knowledge Base. Please review before your next shift.', time: '2h ago', likes: 12, comments: 3, type: 'announcement' },
        { id: '2', author: 'Sarah Jenkins', role: 'Senior PSW', content: 'Shoutout to the late-night team for handling the surge in emergency care requests last night. You all are rockstars! 🌟', time: '5h ago', likes: 45, comments: 8, type: 'celebration' },
        { id: '3', author: 'Michael Chen', role: 'RN', lastMessage: 'Does anyone have experience with the new digital check-in system for the King St clinic?', time: 'Yesterday', unread: false, type: 'peer-support' } as any,
    ]);

    const getTypeStyles = (type: string) => {
        switch (type) {
            case 'announcement': return 'bg-primary/10 text-primary border-primary/20';
            case 'celebration': return 'bg-yellow-500/10 text-yellow-600 border-yellow-500/20';
            case 'peer-support': return 'bg-blue-500/10 text-blue-600 border-blue-500/20';
            default: return 'bg-zinc-500/10 text-zinc-600 border-zinc-500/20';
        }
    };

    return (
        <div className="p-8 max-w-4xl mx-auto space-y-8 animate-in fade-in duration-700">
            <header className="space-y-2 text-center lg:text-left">
                <h1 className="text-4xl font-black tracking-tight flex items-center gap-3 justify-center lg:justify-start">
                    <span>📱</span> Provider Feed
                </h1>
                <p className="text-muted-foreground">Stay connected with your regional team and franchise updates.</p>
            </header>

            <div className="bg-card border rounded-3xl p-6 shadow-sm flex items-center gap-4">
                <div className="w-12 h-12 rounded-full bg-secondary flex items-center justify-center text-xl border shadow-inner">
                    ✨
                </div>
                <input
                    type="text"
                    placeholder="Share an update or ask a peer for advice..."
                    className="flex-1 bg-secondary/30 rounded-2xl px-6 py-3 border-none outline-none focus:ring-2 focus:ring-primary/20 transition-all font-medium"
                />
                <button className="bg-primary text-primary-foreground p-3 rounded-2xl shadow-lg shadow-primary/20 hover:scale-105 transition-all">
                    <span>🚀</span>
                </button>
            </div>

            <div className="space-y-6">
                {posts.map(post => (
                    <div key={post.id} className="bg-card border rounded-3xl p-8 shadow-sm hover:shadow-md transition-shadow animate-in slide-in-from-bottom-4 duration-500">
                        <div className="flex justify-between items-start mb-6">
                            <div className="flex items-center gap-4">
                                <div className="w-10 h-10 rounded-full bg-secondary flex items-center justify-center text-sm font-black border">
                                    {post.author[0]}
                                </div>
                                <div>
                                    <div className="font-black tracking-tight">{post.author}</div>
                                    <div className="text-[10px] font-black text-muted-foreground uppercase tracking-widest leading-none mt-1">
                                        {post.role} • {post.time}
                                    </div>
                                </div>
                            </div>
                            <span className={`px-3 py-1 rounded-full text-[10px] font-black uppercase border ${getTypeStyles(post.type)}`}>
                                {post.type}
                            </span>
                        </div>

                        <p className="text-lg leading-relaxed font-medium mb-6">
                            {post.content}
                        </p>

                        <div className="pt-6 border-t flex gap-6">
                            <button className="flex items-center gap-2 text-xs font-bold text-muted-foreground hover:text-red-500 transition-colors">
                                <span>❤️</span> {post.likes} Likes
                            </button>
                            <button className="flex items-center gap-2 text-xs font-bold text-muted-foreground hover:text-primary transition-colors">
                                <span>💬</span> {post.comments} Comments
                            </button>
                            <button className="ml-auto text-xs font-bold text-muted-foreground hover:text-foreground transition-colors">
                                <span>🔗</span> Share
                            </button>
                        </div>
                    </div>
                ))}

                <button className="w-full py-4 bg-secondary/30 text-muted-foreground font-black text-xs uppercase tracking-[0.2em] rounded-2xl hover:bg-secondary/50 transition-all border border-dashed border-zinc-300">
                    Load More Activities
                </button>
            </div>
        </div>
    );
}

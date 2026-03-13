// ================================================================
// PAGE IDENTITY: T37 � Feedback Loop
// Type: Tool | Owner: client
// ================================================================
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

export default function FeedbackLoop() {
    const { t } = useTranslation();
    const [rating, setRating] = useState(0);
    const [comment, setComment] = useState('');

    return (
        <div className="p-8 max-w-4xl mx-auto space-y-10 animate-in fade-in zoom-in-95 duration-700">
            <header className="text-center space-y-4">
                <div className="inline-flex items-center justify-center w-16 h-16 rounded-[1.5rem] bg-primary/10 text-3xl shadow-inner mb-2">
                    🌟
                </div>
                <h1 className="text-4xl font-black tracking-tight uppercase">Share Your Care Experience</h1>
                <p className="text-muted-foreground font-medium max-w-lg mx-auto leading-relaxed">
                    Your feedback helps us maintain the highest clinical standards and recognize excellence in our caregiver network.
                </p>
            </header>

            <div className="bg-card border-2 border-zinc-100 rounded-[3rem] p-12 shadow-sm space-y-12">
                <section className="space-y-6">
                    <div className="text-center">
                        <h3 className="text-[10px] font-black uppercase tracking-[0.2em] text-muted-foreground mb-4">How was your last visit?</h3>
                        <div className="flex justify-center gap-4">
                            {[1, 2, 3, 4, 5].map((star) => (
                                <button
                                    key={star}
                                    onClick={() => setRating(star)}
                                    className={`text-4xl transition-all hover:scale-125 active:scale-95 ${star <= rating ? 'grayscale-0' : 'grayscale opacity-30 shadow-none'
                                        }`}
                                >
                                    ⭐
                                </button>
                            ))}
                        </div>
                    </div>
                </section>

                <section className="space-y-4">
                    <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground ml-4">Clinical or Personal Observations</label>
                    <textarea
                        rows={6}
                        value={comment}
                        onChange={(e) => setComment(e.target.value)}
                        placeholder="Tell us about the visit quality, professionalism, or any specific care needs..."
                        className="w-full bg-zinc-50 border-2 border-zinc-100 rounded-[2.5rem] px-8 py-6 text-sm font-medium outline-none focus:border-primary transition-all resize-none shadow-inner"
                    />
                </section>

                <footer className="pt-8 border-t border-zinc-100 flex flex-col items-center gap-6">
                    <div className="flex items-center gap-3 bg-zinc-50 px-6 py-3 rounded-2xl border border-zinc-100">
                        <span className="text-lg">🛡️</span>
                        <span className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Clinical managers review all feedback</span>
                    </div>

                    <button className="bg-zinc-900 text-white px-16 py-5 rounded-[2rem] font-black text-sm uppercase tracking-widest shadow-2xl shadow-zinc-200 hover:bg-primary hover:scale-105 active:scale-95 transition-all">
                        Submit Satisfaction Review
                    </button>
                </footer>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div className="bg-zinc-900 text-white p-8 rounded-[2.5rem] relative overflow-hidden group hover:scale-[1.02] transition-all">
                    <div className="relative z-10 flex items-start gap-4">
                        <div className="text-2xl opacity-50 group-hover:opacity-100 transition-opacity">💡</div>
                        <div>
                            <h4 className="font-black text-xs uppercase tracking-widest mb-1">Immediate Issues?</h4>
                            <p className="text-[10px] font-medium text-white/60 leading-relaxed">
                                Feedback is for service improvement. If you have an urgent care concern, please use the Nursing Chat.
                            </p>
                        </div>
                    </div>
                </div>
                <div className="bg-white border-2 border-zinc-100 p-8 rounded-[2.5rem] relative overflow-hidden group hover:border-primary/50 transition-all">
                    <div className="relative z-10 flex items-start gap-4">
                        <div className="text-2xl opacity-50 group-hover:opacity-100 transition-opacity flex grayscale group-hover:grayscale-0">🏆</div>
                        <div>
                            <h4 className="font-black text-xs uppercase tracking-widest mb-1 text-zinc-900">Recognition</h4>
                            <p className="text-[10px] font-medium text-muted-foreground/60 leading-relaxed">
                                High-performance ratings contribute to caregiver bonuses and clinical excellence recognition.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

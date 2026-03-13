// ================================================================
// PAGE IDENTITY: T34 � Catalog Browser
// Type: Tool | Owner: client
// ================================================================
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

interface ServiceModule {
    id: string;
    title: string;
    description: string;
    price: string;
    category: 'Clinical' | 'Support' | 'Specialized';
    icon: string;
}

export default function CatalogBrowser() {
    const { t } = useTranslation();
    const [selectedCategory, setSelectedCategory] = useState<string>('All');

    const modules: ServiceModule[] = [
        { id: '1', title: 'Post-Op Nursing', description: 'Advanced wound care and medication management following major surgery.', price: '$85/hr', category: 'Clinical', icon: '🩺' },
        { id: '2', title: 'Dementia Companion', description: 'Specialized memory care and cognitive stimulation for seniors.', price: '$45/hr', category: 'Specialized', icon: '🧠' },
        { id: '3', title: 'Meal Preparation', description: 'Nutritious, chef-curated meal planning and preparation for daily health.', price: '$35/hr', category: 'Support', icon: '🍲' },
        { id: '4', title: 'Physical Rehab Assist', description: 'Work alongside your physiotherapist for daily exercise oversight.', price: '$65/hr', category: 'Clinical', icon: '🦾' },
        { id: '5', title: 'Housekeeping Plus', description: 'Deep cleaning and light organizational assistance for home safety.', price: '$40/hr', category: 'Support', icon: '🧹' },
        { id: '6', title: 'End-of-Life Support', description: 'Compassionate palliative care coordination and family support.', price: 'Custom', category: 'Specialized', icon: '🕊️' },
    ];

    const filtered = selectedCategory === 'All' ? modules : modules.filter(m => m.category === selectedCategory);

    return (
        <div data-cy="page.container" className="p-8 max-w-7xl mx-auto space-y-12 animate-in fade-in duration-1000">
            <header className="relative py-16 px-8 rounded-[3rem] bg-zinc-900 overflow-hidden shadow-2xl">
                <div className="relative z-10 max-w-2xl space-y-4">
                    <div className="text-primary font-black text-xs uppercase tracking-[0.4em]">Service Catalog</div>
                    <h1 data-cy="page.title" className="text-5xl font-black tracking-tight text-white leading-tight">Enhance Your Care Journey</h1>
                    <p className="text-zinc-400 text-lg font-medium leading-relaxed">
                        Discover specialized nursing and support modules tailored to your family's unique needs. Modular care, on your terms.
                    </p>
                </div>
                <div className="absolute right-0 top-0 bottom-0 w-1/3 bg-gradient-to-l from-primary/10 to-transparent flex items-center justify-center">
                    <div className="text-9xl opacity-20 filter blur-sm">✨</div>
                </div>
            </header>

            <div className="space-y-8">
                <nav className="flex flex-wrap gap-4 items-center">
                    {['All', 'Clinical', 'Support', 'Specialized'].map(cat => (
                        <button
                            key={cat}
                            onClick={() => setSelectedCategory(cat)}
                            className={`px-8 py-3 rounded-2xl font-bold text-sm transition-all border-2 ${selectedCategory === cat ? 'bg-primary border-primary text-primary-foreground shadow-xl shadow-primary/20 scale-105' : 'bg-card border-zinc-100 text-muted-foreground hover:border-primary/20'}`}
                        >
                            {cat}
                        </button>
                    ))}
                </nav>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    {filtered.map(mod => (
                        <div key={mod.id} className="bg-card border rounded-[2.5rem] p-8 flex flex-col justify-between group hover:shadow-2xl hover:border-primary/30 transition-all duration-500 relative overflow-hidden">
                            <div className="absolute -right-8 -top-8 w-24 h-24 bg-primary/5 rounded-full blur-2xl group-hover:bg-primary/10 transition-all" />

                            <div className="space-y-6 relative z-10">
                                <div className="text-5xl mb-4 group-hover:scale-125 transition-transform duration-500 origin-left">
                                    {mod.icon}
                                </div>
                                <div>
                                    <div className="text-[10px] font-black uppercase text-primary tracking-widest mb-1">{mod.category}</div>
                                    <h3 className="text-2xl font-black tracking-tight mb-3">{mod.title}</h3>
                                    <p className="text-sm text-muted-foreground leading-relaxed font-medium">
                                        {mod.description}
                                    </p>
                                </div>
                            </div>

                            <div className="mt-12 flex items-center justify-between pt-6 border-t border-dashed border-zinc-100">
                                <div className="space-y-1">
                                    <div className="text-[10px] font-black text-muted-foreground uppercase opacity-50">Starting From</div>
                                    <div className="text-xl font-black text-primary">{mod.price}</div>
                                </div>
                                <button className="px-6 py-3 bg-zinc-900 text-white rounded-2xl font-bold text-xs hover:bg-primary hover:shadow-xl hover:shadow-primary/20 transition-all">
                                    Book Module
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            </div>

            <footer className="bg-zinc-100 rounded-[3rem] p-12 flex flex-col items-center text-center space-y-6">
                <div className="text-4xl">📞</div>
                <div className="space-y-2">
                    <h3 className="text-2xl font-black">Need a Custom Plan?</h3>
                    <p className="text-muted-foreground max-w-md mx-auto font-medium">
                        Our clinical coordinators can design a bespoke care ecosystem for complex medical requirements.
                    </p>
                </div>
                <button className="px-10 py-4 bg-white border-2 border-zinc-900 rounded-[2rem] font-black text-sm hover:bg-zinc-900 hover:text-white transition-all shadow-xl shadow-zinc-200">
                    Consult a Coordinator
                </button>
            </footer>
        </div>
    );
}

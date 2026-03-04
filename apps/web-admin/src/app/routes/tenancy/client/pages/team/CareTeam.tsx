import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

interface TeamMember {
    id: string;
    name: string;
    role: string;
    specialty: string;
    rating: number;
    visits: number;
    bio: string;
}

export default function CareTeam() {
    const { t } = useTranslation();
    const [team] = useState<TeamMember[]>([
        { id: '1', name: 'Sarah Jenkins', role: 'Primary PSW', specialty: 'Dementia Care', rating: 4.9, visits: 124, bio: 'Sarah has over 8 years of experience in geriatric support and specialized memory care.' },
        { id: '2', name: 'Michael Chen', role: 'Relief PSW', specialty: 'Post-Op Recovery', rating: 4.8, visits: 42, bio: 'Michael specializes in assisting clients during their recovery from major orthopedic surgeries.' },
        { id: '3', name: 'Nurse Sarah', role: 'Nursing Lead', specialty: 'Clinical Oversight', rating: 5.0, visits: 12, bio: 'Sarah oversees clinical protocols and medication management for high-complexity clients.' },
    ]);

    return (
        <div className="p-8 max-w-6xl mx-auto space-y-8 animate-in fade-in zoom-in-95 duration-700">
            <header className="flex justify-between items-center bg-card border-2 border-zinc-100 p-8 rounded-[2.5rem] shadow-sm relative overflow-hidden">
                <div className="absolute top-0 right-0 p-8 opacity-[0.05] text-8xl rotate-12 -translate-y-4">
                    🤝
                </div>
                <div>
                    <div className="flex items-center gap-2 mb-2">
                        <span className="w-2 h-2 rounded-full bg-green-500" />
                        <span className="text-[10px] font-black uppercase tracking-widest text-green-600">Active Care Circle</span>
                    </div>
                    <h1 className="text-3xl font-black tracking-tight uppercase">My Care Team</h1>
                    <p className="text-muted-foreground font-medium">Meet the dedicated professionals supporting your family's health journey.</p>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {team.map(member => (
                    <div key={member.id} className="bg-card border-2 border-zinc-100 rounded-[3rem] p-8 hover:border-primary/50 transition-all group relative overflow-hidden">
                        <div className="absolute inset-0 bg-primary opacity-0 group-hover:opacity-[0.02] transition-opacity" />

                        <div className="flex flex-col items-center text-center space-y-6 relative z-10">
                            <div className="relative">
                                <div className="w-32 h-32 rounded-[2.5rem] bg-zinc-200 border-4 border-white shadow-2xl flex items-center justify-center text-4xl font-black group-hover:scale-105 transition-transform">
                                    {member.name.split(' ').map(n => n[0]).join('')}
                                </div>
                                <div className="absolute -bottom-2 -right-2 bg-white px-4 py-1.5 rounded-full border-2 border-zinc-100 shadow-sm flex items-center gap-1">
                                    <span className="text-[10px] font-black tracking-tighter text-amber-500">★</span>
                                    <span className="text-[10px] font-black">{member.rating}</span>
                                </div>
                            </div>

                            <div>
                                <h3 className="text-xl font-black tracking-tight">{member.name}</h3>
                                <div className="text-[10px] font-black uppercase tracking-widest text-primary mt-1">{member.role}</div>
                            </div>

                            <div className="bg-zinc-50 border border-zinc-100 w-full p-4 rounded-2xl flex justify-around">
                                <div className="text-center">
                                    <div className="text-[9px] font-black uppercase tracking-widest text-muted-foreground opacity-60">Visits</div>
                                    <div className="font-black text-sm">{member.visits}</div>
                                </div>
                                <div className="divider w-px bg-zinc-200" />
                                <div className="text-center">
                                    <div className="text-[9px] font-black uppercase tracking-widest text-muted-foreground opacity-60">Focus</div>
                                    <div className="font-black text-[10px] uppercase truncate max-w-[80px]">{member.specialty}</div>
                                </div>
                            </div>

                            <p className="text-xs font-medium text-muted-foreground leading-relaxed h-12 overflow-hidden text-ellipsis italic">
                                "{member.bio}"
                            </p>

                            <button className="w-full bg-zinc-900 text-white py-4 rounded-2xl font-black text-[10px] uppercase tracking-widest group-hover:bg-primary transition-all shadow-xl shadow-zinc-200">
                                Send Message
                            </button>
                        </div>
                    </div>
                ))}

                <div className="bg-zinc-50 border-2 border-dashed border-zinc-200 rounded-[3rem] p-8 flex flex-col items-center justify-center text-center space-y-4 hover:border-primary/50 transition-all cursor-pointer group">
                    <div className="text-4xl grayscale group-hover:grayscale-0 transition-all opacity-40 group-hover:opacity-100">➕</div>
                    <div>
                        <div className="font-black text-sm uppercase tracking-widest text-muted-foreground group-hover:text-primary transition-all">Request Specialist</div>
                        <p className="text-[10px] font-medium text-muted-foreground/60 mt-2 px-6 leading-relaxed">Need a physical therapist or specialized RMT? Call coordinate to add to team.</p>
                    </div>
                </div>
            </div>

            <div className="bg-amber-50 border-2 border-amber-100 p-8 rounded-[3rem] flex items-center gap-8">
                <div className="bg-amber-100/50 p-6 rounded-3xl text-4xl">🔐</div>
                <div>
                    <h3 className="text-sm font-black uppercase tracking-widest text-amber-900">Clinically Verified Network</h3>
                    <p className="text-xs font-medium text-amber-800/80 leading-relaxed max-w-2xl mt-2">
                        Every professional in your care circle has undergone a mandatory criminal background check, vulnerable sector screening, and rigorous clinical credential verification.
                    </p>
                </div>
            </div>
        </div>
    );
}

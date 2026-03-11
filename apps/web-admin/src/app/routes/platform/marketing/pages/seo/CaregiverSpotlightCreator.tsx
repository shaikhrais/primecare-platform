import React, { useState } from 'react';
import { Star, Download, Image as ImageIcon, Heart, ArrowRight, Share2, Award } from 'lucide-react';

interface Caregiver {
    id: string;
    name: string;
    title: string;
    yearsOfService: number;
    totalHours: number;
    rating: number;
    quote: string;
    image: string;
}

export const CaregiverSpotlightCreator: React.FC = () => {
    const [selectedCaregiver, setSelectedCaregiver] = useState<Caregiver>({
        id: '1',
        name: 'Maria G.',
        title: 'Certified Home Health Aide (CHHA)',
        yearsOfService: 4,
        totalHours: 4250,
        rating: 4.9,
        quote: "True care goes beyond medicine; it's about making someone feel seen and valued every single day.",
        image: 'bg-indigo-900' // Placeholder for actual image
    });

    const [isExporting, setIsExporting] = useState(false);

    const handleExport = () => {
        setIsExporting(true);
        setTimeout(() => setIsExporting(false), 1500);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '12px', borderRadius: '8px', border: '1px solid #BBF7D0' }}>
                        <Star size={28} color="#16A34A" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Social Media Asset Generator: Caregiver Spotlights</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Automatically extracts metrics from the HR database to generate Instagram/LinkedIn ready PR graphics.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '32px' }}>
                {/* Control Panel */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '20px' }}>
                    
                    <div style={{ padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '8px' }}>Select Top Performer (Ranked by 5-Star Reviews)</label>
                        <select style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', backgroundColor: 'white' }}>
                            <option value="1">Maria G. (4.9 Stars - 142 Reviews)</option>
                            <option value="2">David T. (4.9 Stars - 98 Reviews)</option>
                            <option value="3">Sarah L. (4.8 Stars - 210 Reviews)</option>
                        </select>
                    </div>

                    <div style={{ padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'flex', alignItems: 'center', gap: '6px', marginBottom: '8px' }}><ImageIcon size={16}/> Override Headshot Image</label>
                        <div style={{ border: '2px dashed #CBD5E1', padding: '16px', borderRadius: '8px', textAlign: 'center', backgroundColor: 'white', color: '#64748B', cursor: 'pointer', fontSize: '0.9rem' }}>
                            Click to upload high-res image...
                        </div>
                    </div>

                    <div style={{ padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '8px' }}>Curated PR Quote</label>
                        <textarea 
                            value={selectedCaregiver.quote}
                            onChange={(e) => setSelectedCaregiver({...selectedCaregiver, quote: e.target.value})}
                            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', resize: 'vertical', minHeight: '80px', fontSize: '0.95rem', boxSizing: 'border-box' }}
                        />
                    </div>

                     <button 
                        onClick={handleExport}
                        disabled={isExporting}
                        style={{ width: '100%', padding: '16px', backgroundColor: '#0284C7', color: 'white', border: 'none', borderRadius: '8px', fontSize: '1.05rem', fontWeight: 800, cursor: isExporting ? 'wait' : 'pointer', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '8px', transition: 'background-color 0.2s' }}
                    >
                        {isExporting ? <span className="animate-pulse">RENDERING HIGH-RES IMAGE...</span> : <><Download size={20} /> EXPORT 1080x1080 (INSTAGRAM)</>}
                    </button>
                </div>

                {/* Preview Canvas (1:1 Aspect Ratio representation) */}
                <div style={{ flex: '0 0 400px', backgroundColor: '#F1F5F9', borderRadius: '12px', padding: '24px', display: 'flex', flexDirection: 'column', alignItems: 'center', border: '1px solid #E2E8F0' }}>
                    <div style={{ width: '100%', display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px', color: '#64748B', fontWeight: 700, fontSize: '0.85rem', textTransform: 'uppercase' }}>
                        <span><Share2 size={16} style={{ verticalAlign: 'middle', marginRight: '4px' }}/> Live Preview</span>
                        <span>1080 x 1080 px</span>
                    </div>

                    {/* The actual generated asset */}
                    <div style={{ width: '350px', height: '350px', backgroundColor: '#0F172A', borderRadius: '16px', position: 'relative', overflow: 'hidden', boxShadow: '0 10px 25px rgba(0,0,0,0.1)' }}>
                        <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: '50%', backgroundColor: '#1E1B4B', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                            <ImageIcon size={64} color="#312E81" />
                        </div>
                        
                        <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, height: '60%', backgroundColor: 'white', borderTopLeftRadius: '24px', borderTopRightRadius: '24px', padding: '24px', display: 'flex', flexDirection: 'column' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '16px' }}>
                                <div>
                                    <h4 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 900 }}>{selectedCaregiver.name}</h4>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700 }}>{selectedCaregiver.title}</div>
                                </div>
                                <div style={{ display: 'flex', gap: '2px' }}>
                                    {[1,2,3,4,5].map(s => <Star key={s} size={16} color="#F59E0B" fill="#F59E0B" />)}
                                </div>
                            </div>

                            <p style={{ margin: '0 0 16px 0', fontSize: '0.95rem', color: '#334155', fontStyle: 'italic', lineHeight: 1.4, flex: 1 }}>
                                "{selectedCaregiver.quote}"
                            </p>

                            <div style={{ display: 'flex', gap: '8px', borderTop: '1px solid #E2E8F0', paddingTop: '16px' }}>
                                <div style={{ flex: 1, backgroundColor: '#F8FAFC', padding: '8px', borderRadius: '6px', textAlign: 'center' }}>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 900, color: '#0F172A' }}>{selectedCaregiver.yearsOfService}</div>
                                    <div style={{ fontSize: '0.65rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Years</div>
                                </div>
                                <div style={{ flex: 1, backgroundColor: '#F8FAFC', padding: '8px', borderRadius: '6px', textAlign: 'center' }}>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 900, color: '#0F172A' }}>{selectedCaregiver.totalHours.toLocaleString()}</div>
                                    <div style={{ fontSize: '0.65rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Hours</div>
                                </div>
                                <div style={{ flex: 1, backgroundColor: '#EFF6FF', padding: '8px', borderRadius: '6px', textAlign: 'center', border: '1px solid #BFDBFE' }}>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 900, color: '#1D4ED8' }}>Top 1%</div>
                                    <div style={{ fontSize: '0.65rem', color: '#3B82F6', fontWeight: 800, textTransform: 'uppercase' }}>Award</div>
                                </div>
                            </div>
                        </div>

                         {/* PrimeCare Logo Badge */}
                         <div style={{ position: 'absolute', top: '16px', right: '16px', backgroundColor: 'white', padding: '4px 12px', borderRadius: '16px', fontSize: '0.7rem', fontWeight: 900, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '4px' }}>
                            <Heart size={12} color="#DC2626" fill="#DC2626"/> PrimeCare
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

import React, { useState } from 'react';
import { Link, Copy, CheckCircle2, AlertOctagon, Share2 } from 'lucide-react';

export const UtmParameterBuilder: React.FC = () => {
    const [baseUrl, setBaseUrl] = useState('https://primecare.org/services');
    const [source, setSource] = useState('facebook');
    const [medium, setMedium] = useState('cpc');
    const [campaign, setCampaign] = useState('summer_respite');
    const [term, setTerm] = useState('');
    const [content, setContent] = useState('');
    const [copied, setCopied] = useState(false);

    const generateLink = () => {
        try {
            const url = new URL(baseUrl.startsWith('http') ? baseUrl : `https://${baseUrl}`);
            if (source) url.searchParams.set('utm_source', source);
            if (medium) url.searchParams.set('utm_medium', medium);
            if (campaign) url.searchParams.set('utm_campaign', campaign);
            if (term) url.searchParams.set('utm_term', term);
            if (content) url.searchParams.set('utm_content', content);
            return url.toString();
        } catch (e) {
            return 'Invalid Base URL';
        }
    };

    const handleCopy = () => {
        navigator.clipboard.writeText(generateLink());
        setCopied(true);
        setTimeout(() => setCopied(false), 2000);
    };

    const finalUrl = generateLink();
    const isValid = finalUrl !== 'Invalid Base URL' && source && medium && campaign;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F3E8FF', padding: '12px', borderRadius: '8px', border: '1px solid #E9D5FF' }}>
                        <Link size={28} color="#9333EA" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Standardized UTM Campaign Builder</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Enforces clean data hygiene for Google Analytics by restricting reps to approved tracking tags.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '32px' }}>
                {/* Form Column */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    
                    <div>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Target Destination URL *</label>
                        <input 
                            type="text" 
                            value={baseUrl}
                            onChange={(e) => setBaseUrl(e.target.value)}
                            placeholder="https://primecare.org/"
                            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box' }}
                        />
                    </div>

                    <div style={{ display: 'flex', gap: '16px' }}>
                        <div style={{ flex: 1 }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Traffic Source *</label>
                            <select value={source} onChange={(e) => setSource(e.target.value)} style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', backgroundColor: '#F8FAFC' }}>
                                <option value="google">google (Search)</option>
                                <option value="facebook">facebook (Meta)</option>
                                <option value="linkedin">linkedin (B2B)</option>
                                <option value="newsletter">newsletter (Email)</option>
                            </select>
                        </div>
                        <div style={{ flex: 1 }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Campaign Medium *</label>
                            <select value={medium} onChange={(e) => setMedium(e.target.value)} style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', backgroundColor: '#F8FAFC' }}>
                                <option value="cpc">cpc (Cost Per Click)</option>
                                <option value="organic">organic (Free Post)</option>
                                <option value="email">email (Blast)</option>
                                <option value="print_qr">print_qr (Brochure)</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Campaign Name * (No spaces)</label>
                        <input 
                            type="text" 
                            value={campaign}
                            onChange={(e) => setCampaign(e.target.value.toLowerCase().replace(/\s+/g, '_'))}
                            placeholder="e.g., winter_flu_prevention"
                            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box' }}
                        />
                    </div>

                    <div style={{ display: 'flex', gap: '16px' }}>
                        <div style={{ flex: 1 }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Term (Optional)</label>
                             <input type="text" value={term} onChange={(e) => setTerm(e.target.value)} placeholder="e.g., dementia_care" style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box' }}/>
                        </div>
                        <div style={{ flex: 1 }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Content Variant (Optional)</label>
                            <input type="text" value={content} onChange={(e) => setContent(e.target.value)} placeholder="e.g., blue_banner_v2" style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box' }}/>
                        </div>
                    </div>
                </div>

                {/* Output Column */}
                <div style={{ flex: 1, backgroundColor: '#F8FAFC', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0', display: 'flex', flexDirection: 'column' }}>
                     <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', fontSize: '0.85rem' }}>
                        <Share2 size={16} /> Final Tracking Link
                    </div>

                    <div style={{ flex: 1, backgroundColor: 'white', border: '1px dashed #CBD5E1', borderRadius: '8px', padding: '16px', color: '#0F172A', wordBreak: 'break-all', fontFamily: 'monospace', fontSize: '1.05rem', lineHeight: 1.5, position: 'relative' }}>
                        {finalUrl}
                    </div>

                    {isValid ? (
                         <button 
                            onClick={handleCopy}
                            style={{ width: '100%', padding: '16px', backgroundColor: copied ? '#10B981' : '#9333EA', color: 'white', border: 'none', borderRadius: '8px', fontSize: '1rem', fontWeight: 800, cursor: 'pointer', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '8px', marginTop: '24px', transition: 'background-color 0.2s' }}
                        >
                            {copied ? <><CheckCircle2 size={20} /> LINK COPIED!</> : <><Copy size={20} /> COPY TO CLIPBOARD</>}
                        </button>
                    ) : (
                        <div style={{ width: '100%', padding: '16px', backgroundColor: '#FEF2F2', color: '#DC2626', border: '1px solid #FECACA', borderRadius: '8px', fontSize: '0.9rem', fontWeight: 800, textAlign: 'center', marginTop: '24px', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '8px' }}>
                            <AlertOctagon size={18} /> FILL ALL REQUIRED FIELDS
                        </div>
                    )}
                </div>
            </div>
            
            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#FFFBEB', borderRadius: '8px', border: '1px dashed #FDE68A', fontSize: '0.85rem', color: '#92400E' }}>
                <strong>Data Hygiene Governance:</strong> If a local marketer manually types "FaceBook" instead of "facebook", Google Analytics splits the data into two separate tracking channels, destroying our CPA calculations. This tool uses forced dropdowns to guarantee 100% data consistency globally.
            </div>
        </div>
    );
};

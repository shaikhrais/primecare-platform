import React, { useState } from 'react';
import { HardDrive, Folder, File, Image as ImageIcon, Video, FileText, Download, Trash2, Search, UploadCloud } from 'lucide-react';

interface MediaAsset {
    id: string;
    alias: string;
    type: 'IMAGE' | 'PDF' | 'VIDEO' | 'FOLDER';
    size: string;
    uploadedAt: string;
}

export const CentralMediaVault: React.FC = () => {
    const [assets, setAssets] = useState<MediaAsset[]>([
        { id: 'f1', alias: 'Clinical Protocols (2026)', type: 'FOLDER', size: '--', uploadedAt: '--' },
        { id: 'f2', alias: 'Marketing Logos', type: 'FOLDER', size: '--', uploadedAt: '--' },
        { id: 'a1', alias: 'hero-banner-spring.webp', type: 'IMAGE', size: '241 KB', uploadedAt: '2 hours ago' },
        { id: 'a2', alias: 'orientation-module-1.mp4', type: 'VIDEO', size: '142 MB', uploadedAt: '1 day ago' },
        { id: 'a3', alias: 'w9-contractor-form.pdf', type: 'PDF', size: '84 KB', uploadedAt: '1 week ago' }
    ]);
    
    const [searchTerm, setSearchTerm] = useState('');
    const [isUploading, setIsUploading] = useState(false);

    const getIcon = (type: string) => {
        if (type === 'FOLDER') return <Folder size={32} color="#94A3B8" />;
        if (type === 'IMAGE') return <ImageIcon size={32} color="#3B82F6" />;
        if (type === 'VIDEO') return <Video size={32} color="#8B5CF6" />;
        if (type === 'PDF') return <FileText size={32} color="#EF4444" />;
        return <File size={32} color="#64748B" />;
    };

    const handleLocalUpload = () => {
        setIsUploading(true);
        setTimeout(() => {
            setAssets(prev => [
                { id: `a_${Date.now()}`, alias: 'new-uploaded-asset.webp', type: 'IMAGE', size: '1.2 MB', uploadedAt: 'Just now' },
                ...prev
            ]);
            setIsUploading(false);
        }, 1500);
    };

    const filtered = assets.filter(a => a.alias.toLowerCase().includes(searchTerm.toLowerCase()));

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F1F5F9', padding: '10px', borderRadius: '8px' }}>
                        <HardDrive size={24} color="#0F172A" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Central Media Vault</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Global repository for static files, graphics, and video blobs.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <div style={{ position: 'relative' }}>
                        <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '10px', top: '10px' }} />
                        <input 
                            type="text" 
                            placeholder="Search vault..." 
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            style={{ padding: '8px 12px 8px 32px', borderRadius: '6px', border: '1px solid #CBD5E1', outline: 'none', width: '200px' }}
                        />
                    </div>
                    <button 
                        onClick={handleLocalUpload}
                        disabled={isUploading}
                        style={{ backgroundColor: '#2563EB', color: 'white', border: 'none', borderRadius: '6px', padding: '0 16px', fontWeight: 700, cursor: isUploading ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}
                    >
                        <UploadCloud size={16} /> {isUploading ? 'Uploading...' : 'Upload File'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '16px' }}>
                {filtered.map(asset => (
                    <div key={asset.id} style={{ border: '1px solid #E2E8F0', borderRadius: '8px', padding: '16px', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '12px', cursor: 'pointer', transition: 'box-shadow 0.2s', backgroundColor: asset.type === 'FOLDER' ? '#F8FAFC' : 'white' }}>
                        {getIcon(asset.type)}
                        
                        <div style={{ textAlign: 'center', width: '100%' }}>
                            <div style={{ fontWeight: 600, color: '#0F172A', fontSize: '0.85rem', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                                {asset.alias}
                            </div>
                            {asset.type !== 'FOLDER' && (
                                <div style={{ fontSize: '0.75rem', color: '#64748B', marginTop: '4px' }}>
                                    {asset.size} • {asset.uploadedAt}
                                </div>
                            )}
                        </div>

                        {asset.type !== 'FOLDER' && (
                            <div style={{ display: 'flex', gap: '8px', marginTop: 'auto', paddingTop: '12px', borderTop: '1px solid #E2E8F0', width: '100%', justifyContent: 'center' }}>
                                <button style={{ background: 'transparent', border: 'none', cursor: 'pointer', color: '#64748B', padding: '4px' }} title="Download">
                                    <Download size={16} />
                                </button>
                                <button style={{ background: 'transparent', border: 'none', cursor: 'pointer', color: '#EF4444', padding: '4px' }} title="Delete">
                                    <Trash2 size={16} />
                                </button>
                            </div>
                        )}
                    </div>
                ))}
            </div>
            
            {filtered.length === 0 && (
                <div style={{ textAlign: 'center', padding: '48px', color: '#64748B' }}>
                    <HardDrive size={40} color="#CBD5E1" style={{ margin: '0 auto 12px auto' }} />
                    <p style={{ margin: 0 }}>No files match your search criteria.</p>
                </div>
            )}
        </div>
    );
};

import React, { useState } from 'react';
import { ShieldCheck, Lock, Unlock, ShieldAlert, Eye, Edit3, Trash2, Users } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface RolePermission {
    roleId: string;
    roleName: string;
    canView: boolean;
    canEdit: boolean;
    canDelete: boolean;
}

interface AssetCategory {
    id: string;
    categoryName: string;
    permissions: RolePermission[];
}

export const AssetPermissionMatrix: React.FC = () => {
    const defaultRoles = [
        { roleId: 'r1', roleName: 'System Admin', canView: true, canEdit: true, canDelete: true },
        { roleId: 'r2', roleName: 'Marketing Manager', canView: true, canEdit: true, canDelete: false },
        { roleId: 'r3', roleName: 'Clinical Director (RN)', canView: true, canEdit: false, canDelete: false },
        { roleId: 'r4', roleName: 'Field Staff (PSW)', canView: false, canEdit: false, canDelete: false }
    ];

    const [categories, setCategories] = useState<AssetCategory[]>([
        { id: 'c1', categoryName: 'Global Brand UI Tokens (CSS)', permissions: JSON.parse(JSON.stringify(defaultRoles)) },
        { 
            id: 'c2', 
            categoryName: 'Medical Protocol PDF Library', 
            permissions: [
                { roleId: 'r1', roleName: 'System Admin', canView: true, canEdit: true, canDelete: false },
                { roleId: 'r2', roleName: 'Marketing Manager', canView: false, canEdit: false, canDelete: false },
                { roleId: 'r3', roleName: 'Clinical Director (RN)', canView: true, canEdit: true, canDelete: true },
                { roleId: 'r4', roleName: 'Field Staff (PSW)', canView: true, canEdit: false, canDelete: false }
            ] 
        },
        { 
            id: 'c3', 
            categoryName: 'Public Marketing Videos', 
            permissions: [
                { roleId: 'r1', roleName: 'System Admin', canView: true, canEdit: true, canDelete: true },
                { roleId: 'r2', roleName: 'Marketing Manager', canView: true, canEdit: true, canDelete: true },
                { roleId: 'r3', roleName: 'Clinical Director (RN)', canView: true, canEdit: false, canDelete: false },
                { roleId: 'r4', roleName: 'Field Staff (PSW)', canView: true, canEdit: false, canDelete: false }
            ] 
        }
    ]);

    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const togglePermission = (categoryId: string, roleId: string, permissionType: 'canView' | 'canEdit' | 'canDelete') => {
        setCategories(prev => prev.map(c => {
            if (c.id === categoryId) {
                const updatedPerms = c.permissions.map(p => {
                    if (p.roleId === roleId) {
                        const updated = { ...p, [permissionType]: !p[permissionType] };
                        // Logical cascades
                        if (permissionType === 'canDelete' && updated.canDelete) { updated.canEdit = true; updated.canView = true; }
                        if (permissionType === 'canEdit' && updated.canEdit) { updated.canView = true; }
                        if (permissionType === 'canView' && !updated.canView) { updated.canEdit = false; updated.canDelete = false; }
                        if (permissionType === 'canEdit' && !updated.canEdit) { updated.canDelete = false; }
                        return updated;
                    }
                    return p;
                });
                return { ...c, permissions: updatedPerms };
            }
            return c;
        }));
    };

    const handleSave = async () => {
        setIsSaving(true);
        try {
            await apiClient.post('/platform/admin/dam/security/rbac-matrix', { categories });
            showToast("Role-Based Access Control (RBAC) matrix synchronized with PostgreSQL Identity layer.", "success");
        } catch (error) {
            showToast("ACL failure", "error");
        } finally {
            setIsSaving(false);
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F5F3FF', padding: '10px', borderRadius: '8px', border: '1px solid #EDE9FE' }}>
                        <ShieldCheck size={24} color="#8B5CF6" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Asset Permission Matrix (RBAC)</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Granularly restrict which roles can View, Edit, or Delete specific digital asset classes.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button 
                        data-cy="btn-enforce-rbac"
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#8B5CF6', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <Lock size={16} /> {isSaving ? 'Synchronizing ACL...' : 'Enforce Security Rules'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '32px' }}>
                {categories.map(category => (
                    <div key={category.id}>
                        <h4 style={{ margin: '0 0 16px 0', fontSize: '1rem', color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', borderBottom: '2px solid #E2E8F0', paddingBottom: '8px' }}>
                            <div style={{ width: '8px', height: '8px', backgroundColor: '#8B5CF6', borderRadius: '50%' }}></div>
                            {category.categoryName} Target Class
                        </h4>

                        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                            <thead>
                                <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '1px solid #E2E8F0', textAlign: 'left' }}>
                                    <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, width: '40%' }}>Security Principal (Role)</th>
                                    <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}><Eye size={16} style={{ marginBottom: '-3px' }}/> Read</th>
                                    <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}><Edit3 size={16} style={{ marginBottom: '-3px' }}/> Update / Edit</th>
                                    <th style={{ padding: '12px', color: '#DC2626', fontWeight: 700, textAlign: 'center' }}><Trash2 size={16} style={{ marginBottom: '-3px' }}/> Hard Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                {category.permissions.map(perm => (
                                    <tr key={perm.roleId} style={{ borderBottom: '1px solid #E2E8F0' }}>
                                        <td style={{ padding: '12px', fontWeight: perm.roleId === 'r1' ? 800 : 600, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                            <Users size={16} color="#94A3B8" /> {perm.roleName}
                                        </td>
                                        <td style={{ padding: '12px', textAlign: 'center' }}>
                                            <input 
                                                data-cy={`rbac-${category.id}-${perm.roleId}-view`}
                                                type="checkbox" 
                                                checked={perm.canView} 
                                                onChange={() => togglePermission(category.id, perm.roleId, 'canView')}
                                                style={{ cursor: 'pointer', transform: 'scale(1.2)' }}
                                            />
                                        </td>
                                        <td style={{ padding: '12px', textAlign: 'center' }}>
                                            <input 
                                                data-cy={`rbac-${category.id}-${perm.roleId}-edit`}
                                                type="checkbox" 
                                                checked={perm.canEdit} 
                                                onChange={() => togglePermission(category.id, perm.roleId, 'canEdit')}
                                                style={{ cursor: 'pointer', transform: 'scale(1.2)' }}
                                            />
                                        </td>
                                        <td style={{ padding: '12px', textAlign: 'center' }}>
                                            <input 
                                                data-cy={`rbac-${category.id}-${perm.roleId}-delete`}
                                                type="checkbox" 
                                                checked={perm.canDelete} 
                                                onChange={() => togglePermission(category.id, perm.roleId, 'canDelete')}
                                                style={{ cursor: 'pointer', transform: 'scale(1.2)', accentColor: '#DC2626' }}
                                            />
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                ))}
            </div>

            <div style={{ marginTop: '24px', backgroundColor: '#FFFBEB', padding: '16px', borderRadius: '8px', border: '1px solid #FDE68A', fontSize: '0.85rem', color: '#92400E', display: 'flex', alignItems: 'flex-start', gap: '12px' }}>
                <ShieldAlert size={20} color="#D97706" style={{ flexShrink: 0 }} />
                <div style={{ lineHeight: 1.5 }}>
                    <strong>Escalation Warning:</strong> Granting 'Hard Delete' permissions to non-admin roles (like Marketing) on critical classes like Medical Protocols can result in irrecoverable data loss. These rules are enforced directly at the GraphQL API mutation layer.
                </div>
            </div>
        </div>
    );
};

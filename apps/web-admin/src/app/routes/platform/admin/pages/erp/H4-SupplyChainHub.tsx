// ================================================================
// PAGE IDENTITY: H4 � Supply Chain Hub
// Registry ID:   page.admin.erp
// Type:          Hub
// Owner:         admin
// ================================================================
import React, { useState, useEffect } from 'react';
import { AdminRegistry , getButtonById } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useApiMutation } from '@/shared/hooks/useApiMutation';

const { ApiRegistry, ButtonRegistry } = AdminRegistry;

export default function SupplyChainHub() {
    const [inventory, setInventory] = useState<any[]>([]);
    const [stats, setStats] = useState<any>(null);
    const [isLoading, setIsLoading] = useState(true);
    const { showToast } = useNotification();

    const poMutation = useApiMutation('/v1/admin/erp/po/create', {
        onSuccess: (data: any) => { showToast(data?.message || 'New PO draft initiated.', 'success'); },
        onError: () => { showToast('Failed to spawn PO wizard.', 'error'); },
    });

    const addMutation = useApiMutation('/v1/admin/erp/inventory/add', {
        onSuccess: (data: any) => { showToast(data?.message || 'Equipment item allocated to enterprise ledger.', 'success'); },
        onError: () => { showToast('Registry allocation failed.', 'error'); },
    });

    const fetchInventory = async () => {
        setIsLoading(true);
        try {
            const token = localStorage.getItem('token');
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:4000';
            const response = await fetch(`${apiUrl}${ApiRegistry.ADMIN.ERP.INVENTORY}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setInventory(data.items || []);
                setStats(data.stats || null);
            }
        } catch (e) {
            console.error(e);
        } finally {
            setIsLoading(false);
        }
    };

    useEffect(() => {
        fetchInventory();
    }, []);

    const addBtn = getButtonById('btn-erp-inventory-add');
    const poBtn = getButtonById('btn-erp-po-create');

    return (
        <div data-cy="page.container" role="main" aria-label="Supply Chain Hub" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>
                        📦
                    </div>
                    <div>
                        <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }}>ERP & Supply Chain Hub</h1>
                        <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>Manage medical inventory, suppliers, and procurement lifecycles.</p>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="btn-admin.supply-chain-hub-0" className="btn secondary" onClick={() => poMutation.mutate({})}>
                        {poBtn?.label || 'New Purchase Order'}
                    </button>
                    <button data-cy="btn-admin.supply-chain-hub-1" className="btn primary" onClick={() => addMutation.mutate({})}>
                        {addBtn?.label || 'Add Item'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Total SKU Count</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{stats?.totalSkus ?? 0}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Low Stock Alerts</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#EF4444', marginTop: '4px' }}>{stats?.lowStock ?? 0}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Open POs</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--brand-500)', marginTop: '4px' }}>{stats?.openPos ?? 0}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Procurement Latency</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{stats?.procurementLatency ?? '0.0d'}</div>
                </div>
            </div>

            <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <span>Systemic Inventory Ledger</span>
                    <input data-cy="input-admin.supply-chain-hub-0"
                        type="text"
                        placeholder="Filter by SKU or Name..."
                        style={{ padding: '6px 12px', borderRadius: '6px', border: '1px solid var(--border)', fontSize: '13px', width: '240px' }}
                    />
                </div>
                <div style={{ overflowX: 'auto' }}>
                    <table data-cy="table-admin.supply-chain-hub" style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                            <tr>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>SKU</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Item Name</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Category</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Stock</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Price</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {isLoading ? (
                                <tr>
                                    <td colSpan={6} style={{ padding: '48px', textAlign: 'center', color: 'var(--text-300)' }}>Synchronizing stock data...</td>
                                </tr>
                            ) : inventory.map(item => (
                                <tr key={item.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '16px 24px', fontSize: '13px', fontFamily: 'monospace', color: 'var(--text-200)' }}>{item.sku}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{item.name}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)' }}>{item.category}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '700', color: item.quantity <= item.reorderPoint ? '#EF4444' : 'var(--text-100)' }}>
                                        {item.quantity} units
                                    </td>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--brand-600)', fontWeight: '600' }}>
                                        ${item.unitPrice.toFixed(2)}
                                    </td>
                                    <td style={{ padding: '16px 24px' }}>
                                        <span className={`pc-badge ${item.quantity <= item.reorderPoint ? 'danger' : 'primary'}`}>
                                            {item.quantity <= item.reorderPoint ? 'CRITICAL LOW' : 'OPTIMAL'}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}

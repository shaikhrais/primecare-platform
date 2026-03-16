// ================================================================
// PAGE IDENTITY: L14 · Supply Chain Management
// Type: List | Owner: admin
// Models: Supplier, InventoryItem, PurchaseOrder
// ================================================================
import React, { useState } from 'react';

const suppliers = [
    { id: 's-001', name: 'MedEquip Canada', category: 'Medical Supplies', rating: 4.8, orders: 45, lastOrder: '3 days ago', status: 'active' },
    { id: 's-002', name: 'CleanPro Solutions', category: 'Cleaning & PPE', rating: 4.5, orders: 32, lastOrder: '1 week ago', status: 'active' },
    { id: 's-003', name: 'TechCare Devices', category: 'IoT Devices', rating: 4.2, orders: 12, lastOrder: '2 weeks ago', status: 'active' },
    { id: 's-004', name: 'Pharma Direct', category: 'Pharmaceuticals', rating: 4.9, orders: 67, lastOrder: '1 day ago', status: 'active' },
    { id: 's-005', name: 'Office Depot Canada', category: 'Office Supplies', rating: 3.8, orders: 8, lastOrder: '1 month ago', status: 'inactive' },
];

const inventory = [
    { name: 'Nitrile Gloves (Box/100)', sku: 'PPE-001', quantity: 450, reorderLevel: 200, unit: 'boxes', supplier: 'CleanPro Solutions', status: 'in-stock' },
    { name: 'Surgical Masks (Box/50)', sku: 'PPE-002', quantity: 120, reorderLevel: 150, unit: 'boxes', supplier: 'CleanPro Solutions', status: 'low' },
    { name: 'Blood Pressure Cuffs', sku: 'MED-010', quantity: 35, reorderLevel: 15, unit: 'units', supplier: 'MedEquip Canada', status: 'in-stock' },
    { name: 'Digital Thermometers', sku: 'MED-015', quantity: 8, reorderLevel: 20, unit: 'units', supplier: 'MedEquip Canada', status: 'critical' },
    { name: 'Fall Detection Sensors', sku: 'IOT-001', quantity: 22, reorderLevel: 10, unit: 'units', supplier: 'TechCare Devices', status: 'in-stock' },
    { name: 'Hand Sanitizer (500ml)', sku: 'PPE-005', quantity: 280, reorderLevel: 100, unit: 'bottles', supplier: 'CleanPro Solutions', status: 'in-stock' },
    { name: 'Insulin Syringes (Box/100)', sku: 'MED-020', quantity: 45, reorderLevel: 50, unit: 'boxes', supplier: 'Pharma Direct', status: 'low' },
];

const purchaseOrders = [
    { id: 'PO-2026-042', supplier: 'Pharma Direct', items: 5, total: '$2,340', status: 'delivered', date: 'Mar 14' },
    { id: 'PO-2026-041', supplier: 'CleanPro Solutions', items: 3, total: '$890', status: 'shipped', date: 'Mar 12' },
    { id: 'PO-2026-040', supplier: 'MedEquip Canada', items: 2, total: '$1,560', status: 'pending', date: 'Mar 10' },
    { id: 'PO-2026-039', supplier: 'TechCare Devices', items: 4, total: '$4,200', status: 'processing', date: 'Mar 8' },
];

export default function SupplyChainManagement() {
    const [tab, setTab] = useState<'inventory' | 'suppliers' | 'orders'>('inventory');
    const stockColor = (s: string) => s === 'in-stock' ? 'var(--pc-success)' : s === 'low' ? 'var(--pc-warning)' : 'var(--pc-error)';
    const poColor = (s: string) => ({ delivered: 'var(--pc-success)', shipped: 'var(--pc-info, #2563EB)', processing: 'var(--pc-warning)', pending: 'var(--pc-text-tertiary)' }[s] || 'var(--pc-text-secondary)');

    return (
        <div data-cy="page.container" role="main" aria-label="Supply Chain" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ marginBottom: '24px' }}>
                <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>
                    📦 Supply Chain Management
                </h1>
                <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>
                    Inventory, suppliers, purchase orders & reorder automation
                </p>
            </div>

            {/* KPIs */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Items', value: '7', color: 'var(--pc-primary)' },
                    { label: 'Low Stock', value: '2', color: 'var(--pc-warning)' },
                    { label: 'Critical', value: '1', color: 'var(--pc-error)' },
                    { label: 'Suppliers', value: '5', color: 'var(--pc-success)' },
                    { label: 'Open POs', value: '3', color: 'var(--pc-info, #2563EB)' },
                ].map((s, i) => (
                    <div key={i} style={{ flex: '1 1 140px', padding: '18px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <div style={{ fontSize: '0.65rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '4px' }}>{s.label}</div>
                        <div style={{ fontSize: '1.6rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px' }}>
                {[{ id: 'inventory' as const, label: '📋 Inventory' }, { id: 'suppliers' as const, label: '🏢 Suppliers' }, { id: 'orders' as const, label: '🛒 Purchase Orders' }].map(t => (
                    <button key={t.id} onClick={() => setTab(t.id)} style={{
                        padding: '10px 20px', borderRadius: '10px', border: 'none',
                        background: tab === t.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                        color: tab === t.id ? 'white' : 'var(--pc-text-secondary)', fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                    }}>{t.label}</button>
                ))}
            </div>

            {/* Inventory */}
            {tab === 'inventory' && (
                <div style={{ borderRadius: '14px', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead><tr>{['Item', 'SKU', 'Qty', 'Reorder At', 'Supplier', 'Status'].map(h => (
                            <th key={h} style={{ padding: '12px 16px', textAlign: 'left', background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)', fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase', borderBottom: '2px solid var(--pc-border-primary)' }}>{h}</th>
                        ))}</tr></thead>
                        <tbody>{inventory.map((item, i) => (
                            <tr key={i} style={{ background: 'var(--pc-surface-card)' }}
                                onMouseEnter={e => e.currentTarget.style.background = 'var(--pc-bg-secondary)'}
                                onMouseLeave={e => e.currentTarget.style.background = 'var(--pc-surface-card)'}>
                                <td style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{item.name}</td>
                                <td style={{ padding: '12px 16px', fontFamily: 'monospace', fontSize: '0.8rem', color: 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{item.sku}</td>
                                <td style={{ padding: '12px 16px', fontWeight: 800, color: item.quantity <= item.reorderLevel ? 'var(--pc-error)' : 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{item.quantity} {item.unit}</td>
                                <td style={{ padding: '12px 16px', color: 'var(--pc-text-tertiary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{item.reorderLevel}</td>
                                <td style={{ padding: '12px 16px', color: 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{item.supplier}</td>
                                <td style={{ padding: '12px 16px', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                    <span style={{ padding: '3px 10px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700, color: stockColor(item.status), background: `${stockColor(item.status)}15` }}>{item.status.toUpperCase()}</span>
                                </td>
                            </tr>
                        ))}</tbody>
                    </table>
                </div>
            )}

            {/* Suppliers */}
            {tab === 'suppliers' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '16px' }}>
                    {suppliers.map(s => (
                        <div key={s.id} style={{ padding: '20px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', cursor: 'pointer', transition: 'transform 0.2s' }}
                            onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-2px)'}
                            onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
                                <span style={{ fontWeight: 700, color: 'var(--pc-text-primary)' }}>🏢 {s.name}</span>
                                <span style={{ fontSize: '0.85rem', fontWeight: 800, color: 'var(--pc-warning)' }}>⭐ {s.rating}</span>
                            </div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', marginBottom: '8px' }}>📂 {s.category}</div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.7rem', color: 'var(--pc-text-secondary)' }}>
                                <span>{s.orders} orders</span><span>Last: {s.lastOrder}</span>
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* Purchase Orders */}
            {tab === 'orders' && (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    {purchaseOrders.map(po => (
                        <div key={po.id} style={{ padding: '18px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', display: 'flex', alignItems: 'center', gap: '16px', flexWrap: 'wrap' }}>
                            <div style={{ fontFamily: 'monospace', fontWeight: 800, color: 'var(--pc-primary)', minWidth: '120px' }}>{po.id}</div>
                            <div style={{ flex: 1 }}>
                                <div style={{ fontWeight: 700, color: 'var(--pc-text-primary)' }}>{po.supplier}</div>
                                <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)' }}>{po.items} items • {po.date}</div>
                            </div>
                            <div style={{ fontWeight: 800, fontSize: '1.1rem', color: 'var(--pc-text-primary)' }}>{po.total}</div>
                            <span style={{ padding: '4px 12px', borderRadius: '10px', fontSize: '0.7rem', fontWeight: 700, color: poColor(po.status), background: `${poColor(po.status)}15` }}>{po.status.toUpperCase()}</span>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}

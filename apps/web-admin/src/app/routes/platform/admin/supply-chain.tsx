import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L14-SupplyChainManagement.tsx ---
// ================================================================
// PAGE IDENTITY: L14 · Supply Chain Management
// Type: List | Owner: admin | Registry: L25
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

const inventory = [
    { name: 'Nitrile Gloves (Box/100)', sku: 'PPE-001', qty: '450 boxes', reorder: 200, supplier: 'CleanPro Solutions', status: 'IN-STOCK' },
    { name: 'Surgical Masks (Box/50)', sku: 'PPE-002', qty: '120 boxes', reorder: 150, supplier: 'CleanPro Solutions', status: 'LOW' },
    { name: 'Blood Pressure Cuffs', sku: 'MED-010', qty: '35 units', reorder: 15, supplier: 'MedEquip Canada', status: 'IN-STOCK' },
    { name: 'Digital Thermometers', sku: 'MED-015', qty: '8 units', reorder: 20, supplier: 'MedEquip Canada', status: 'CRITICAL' },
    { name: 'Fall Detection Sensors', sku: 'IOT-001', qty: '22 units', reorder: 10, supplier: 'TechCare Devices', status: 'IN-STOCK' },
    { name: 'Hand Sanitizer (500ml)', sku: 'PPE-005', qty: '280 bottles', reorder: 100, supplier: 'CleanPro Solutions', status: 'IN-STOCK' },
    { name: 'Insulin Syringes (Box/100)', sku: 'MED-020', qty: '45 boxes', reorder: 50, supplier: 'Pharma Direct', status: 'LOW' },
];

const inventoryCols: TableColumn[] = [
    { key: 'name', label: 'Item' }, { key: 'sku', label: 'SKU' },
    { key: 'qty', label: 'Qty' }, { key: 'reorder', label: 'Reorder At' },
    { key: 'supplier', label: 'Supplier' }, { key: 'status', label: 'Status' },
];

const suppliers = [
    { icon: '🏢', title: 'MedEquip Canada', subtitle: 'Medical Supplies • ⭐ 4.8 • 45 orders' },
    { icon: '🏢', title: 'CleanPro Solutions', subtitle: 'Cleaning & PPE • ⭐ 4.5 • 32 orders' },
    { icon: '🏢', title: 'TechCare Devices', subtitle: 'IoT Devices • ⭐ 4.2 • 12 orders' },
    { icon: '🏢', title: 'Pharma Direct', subtitle: 'Pharmaceuticals • ⭐ 4.9 • 67 orders' },
    { icon: '🏢', title: 'Office Depot Canada', subtitle: 'Office Supplies • ⭐ 3.8 • 8 orders' },
];

const purchaseOrders = [
    { id: 'PO-2026-042', supplier: 'Pharma Direct', items: '5 items', total: '$2,340', status: 'DELIVERED', date: 'Mar 14' },
    { id: 'PO-2026-041', supplier: 'CleanPro Solutions', items: '3 items', total: '$890', status: 'SHIPPED', date: 'Mar 12' },
    { id: 'PO-2026-040', supplier: 'MedEquip Canada', items: '2 items', total: '$1,560', status: 'PENDING', date: 'Mar 10' },
    { id: 'PO-2026-039', supplier: 'TechCare Devices', items: '4 items', total: '$4,200', status: 'PROCESSING', date: 'Mar 8' },
];

const poCols: TableColumn[] = [
    { key: 'id', label: 'PO #' }, { key: 'supplier', label: 'Supplier' },
    { key: 'items', label: 'Items' }, { key: 'total', label: 'Total' },
    { key: 'status', label: 'Status' }, { key: 'date', label: 'Date' },
];

export function SupplyChainManagement() {
    const [tab, setTab] = useState('inventory');

    const tabContent: Record<string, Record<string, any>> = {
        inventory: { 'L25.inventory-table': { table: { columns: inventoryCols, rows: inventory } } },
        suppliers: { 'L25.supplier-list': { cardGrid: { items: suppliers, columns: 3 } } },
        orders: { 'L25.po-table': { table: { columns: poCols, rows: purchaseOrders } } },
    };

    return (
        <PageTemplate
            pageId="L25"
            title="📦 Supply Chain Management"
            subtitle="Inventory, suppliers, purchase orders & reorder automation"
            actionPageId="admin.supply-chain"
            sectionData={PageSectionRegistry['L25']}
        />
    );
}

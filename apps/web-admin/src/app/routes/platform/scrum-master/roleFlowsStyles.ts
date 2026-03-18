// CSS styles for RoleFlowsPage
export const roleFlowsStyles = `
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    .bento-grid {
        display: grid;
        grid-template-columns: repeat(12, 1fr);
        gap: 1.5rem;
    }
    .bento-item {
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.3);
        border-radius: 20px;
        padding: 1.5rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
    .bento-item:hover { transform: translateY(-4px); box-shadow: 0 12px 48px rgba(0, 0, 0, 0.08); }
    .role-select-item {
        padding: 10px 16px;
        border-radius: 12px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 10px;
        transition: all 0.2s;
        border: 1px solid transparent;
        background: var(--bg-100);
        font-weight: 600;
    }
    .role-select-item.active {
        background: white;
        border-color: var(--brand-500);
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    .step-card {
        padding: 1.5rem;
        background: white;
        border-radius: 16px;
        border: 1px solid #f1f5f9;
        transition: all 0.2s;
        display: flex;
        gap: 1.5rem;
        align-items: flex-start;
        cursor: pointer;
    }
    .step-card:hover { border-color: var(--brand-500); background: #f8fafc; }
    .blueprint-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 8px;
    }
    .blueprint-table th {
        text-align: left;
        padding: 12px 16px;
        color: var(--text-400);
        font-size: 0.7rem;
        text-transform: uppercase;
        font-weight: 800;
    }
    .blueprint-table td {
        padding: 16px;
        background: white;
        border-top: 1px solid #f1f5f9;
        border-bottom: 1px solid #f1f5f9;
        font-family: 'Inter', sans-serif;
    }
    .blueprint-table tr td:first-child { border-left: 1px solid #f1f5f9; border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
    .blueprint-table tr td:last-child { border-right: 1px solid #f1f5f9; border-top-right-radius: 12px; border-bottom-right-radius: 12px; }
    .status-badge {
        padding: 4px 10px;
        border-radius: 6px;
        font-size: 0.65rem;
        font-weight: 800;
        text-transform: uppercase;
    }
    .status-implemented { background: rgba(16, 185, 129, 0.1); color: #10b981; }
    .status-missing { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
`;

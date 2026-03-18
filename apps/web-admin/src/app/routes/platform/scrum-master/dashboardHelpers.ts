// ScrumMasterDashboard: CSS styles and action handler extracted
import { apiClient } from '@/shared/utils/apiClient';

export const SM_CARD_STYLES = `
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    .sm-card {
        background: rgba(255, 255, 255, 0.7);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.3);
        box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.07);
        border-radius: 20px;
        padding: 2rem;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        display: flex;
        flex-direction: column;
        height: 100%;
    }
    .sm-card:hover { 
        transform: translateY(-8px); 
        box-shadow: 0 12px 40px 0 rgba(31, 38, 135, 0.12);
        border-color: var(--brand-200);
    }
    .btn-utility {
        padding: 12px 24px;
        border-radius: 12px;
        font-weight: 700;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.2s;
    }
    .btn-utility:hover { transform: scale(1.05); }
`;

export async function handleDashboardAction(
    endpoint: string, successMsg: string,
    showToast: (msg: string, type: 'success' | 'error') => void
): Promise<void> {
    try {
        const response = await apiClient.post(endpoint, {});
        if (response.ok) { showToast(successMsg, 'success'); }
        else { showToast('API Request Failed', 'error'); }
    } catch { showToast('Unable to connect to Node endpoint', 'error'); }
}

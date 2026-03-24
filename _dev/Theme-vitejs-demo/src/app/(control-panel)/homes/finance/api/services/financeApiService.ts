import { api } from '@/utils/api';
import { FinanceHomeWidgetType } from '../types';

export const financeApiService = {
	getWidgets: async (): Promise<Record<string, FinanceHomeWidgetType>> => {
		return await api.get('mock/finance-home/widgets').json();
	}
};

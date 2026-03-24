import { api } from '@/utils/api';
import { AnalyticsHomeWidgetType } from '../types';

export const analyticsApiService = {
	getWidgets: async (): Promise<Record<string, AnalyticsHomeWidgetType>> => {
		return await api.get('mock/analytics-home/widgets').json();
	}
};

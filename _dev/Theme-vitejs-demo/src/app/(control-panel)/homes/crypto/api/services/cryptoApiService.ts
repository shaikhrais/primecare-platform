import { api } from '@/utils/api';
import { CryptoHomeWidgetType } from '../types';

export const cryptoApiService = {
	getWidgets: async (): Promise<Record<string, CryptoHomeWidgetType>> => {
		return await api.get('mock/crypto-home/widgets').json();
	}
};

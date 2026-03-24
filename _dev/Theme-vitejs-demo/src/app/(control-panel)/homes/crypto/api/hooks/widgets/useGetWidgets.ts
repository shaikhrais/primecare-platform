import { useQuery } from '@tanstack/react-query';
import { cryptoApiService } from '../../services/cryptoApiService';

export const widgetsQueryKey = ['cryptoHomeApp', 'widgets'];

export const useGetWidgets = () => {
	return useQuery({
		queryFn: cryptoApiService.getWidgets,
		queryKey: widgetsQueryKey
	});
};

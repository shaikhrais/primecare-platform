import { useQuery } from '@tanstack/react-query';
import { analyticsApiService } from '../../services/analyticsApiService';

export const widgetsQueryKey = ['analyticsHomeApp', 'widgets'];

export const useGetWidgets = () => {
	return useQuery({
		queryFn: analyticsApiService.getWidgets,
		queryKey: widgetsQueryKey
	});
};

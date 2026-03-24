import { FinanceHomeWidgetType } from '../../types';
import { useGetWidgets } from './useGetWidgets';

export const useGetWidget = <T extends FinanceHomeWidgetType>(widgetId: string) => {
	const { data, ...rest } = useGetWidgets();

	return {
		...rest,
		data: data ? (data[widgetId] as T) : undefined
	};
};

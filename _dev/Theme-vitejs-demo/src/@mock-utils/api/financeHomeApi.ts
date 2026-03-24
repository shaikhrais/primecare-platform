import { http, HttpResponse } from 'msw';
import mockApi from '../mockApi';

const financeHomeApi = [
	/**
	 * GET api/mock/finance-home/widgets
	 */
	http.get('/api/mock/finance-home/widgets', async ({ request }) => {
		const api = mockApi('finance_home_widgets');
		const queryParams = Object.fromEntries(new URL(request.url).searchParams);
		const items = await api.findAll(queryParams);
		return HttpResponse.json(items);
	})
];

export default financeHomeApi;

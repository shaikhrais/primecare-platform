import { http, HttpResponse } from 'msw';
import mockApi from '../mockApi';

const analyticsHomeApi = [
	/**
	 * GET api/mock/analytics-home/widgets
	 */
	http.get('/api/mock/analytics-home/widgets', async ({ request }) => {
		const api = mockApi('analytics_home_widgets');
		const queryParams = Object.fromEntries(new URL(request.url).searchParams);
		const items = await api.findAll(queryParams);
		return HttpResponse.json(items);
	})
];

export default analyticsHomeApi;

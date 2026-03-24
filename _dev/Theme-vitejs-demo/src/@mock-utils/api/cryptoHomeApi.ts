import { http, HttpResponse } from 'msw';
import mockApi from '../mockApi';

const cryptoHomeApi = [
	/**
	 * GET api/mock/crypto-home/widgets
	 */
	http.get('/api/mock/crypto-home/widgets', async ({ request }) => {
		const api = mockApi('crypto_home_widgets');
		const queryParams = Object.fromEntries(new URL(request.url).searchParams);
		const items = await api.findAll(queryParams);
		return HttpResponse.json(items);
	})
];

export default cryptoHomeApi;

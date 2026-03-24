import { http, HttpResponse } from 'msw';
import mockApi from '../mockApi';

const projectHomeApi = [
	/**
	 * GET api/mock/project-home/widgets
	 */
	http.get('/api/mock/project-home/widgets', async ({ request }) => {
		const api = mockApi('project_home_widgets');
		const queryParams = Object.fromEntries(new URL(request.url).searchParams);
		const items = await api.findAll(queryParams);
		return HttpResponse.json(items);
	}),

	/**
	 * GET api/mock/project-home/projects
	 */
	http.get('/api/mock/project-home/projects', async ({ request }) => {
		const api = mockApi('project_home_projects');
		const queryParams = Object.fromEntries(new URL(request.url).searchParams);
		const items = await api.findAll(queryParams);
		return HttpResponse.json(items);
	})
];

export default projectHomeApi;

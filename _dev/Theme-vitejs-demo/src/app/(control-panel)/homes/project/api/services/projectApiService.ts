import { api } from '@/utils/api';
import { ProjectHomeWidgetType, ProjectType } from '../types';

export const projectApiService = {
	getWidgets: async (): Promise<Record<string, ProjectHomeWidgetType>> => {
		return await api.get('mock/project-home/widgets').json();
	},
	getProjects: async (): Promise<ProjectType[]> => {
		return await api.get('mock/project-home/projects').json();
	}
};

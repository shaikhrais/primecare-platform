import { lazy } from 'react';
import { FuseRouteItemType } from '@fuse/utils/FuseUtils';

const ProjectHomeAppView = lazy(() => import('./components/views/ProjectHomeAppView'));

/**
 * Project Home App  Route
 */
const route: FuseRouteItemType = {
	path: 'homes/project',
	element: <ProjectHomeAppView />
};

export default route;

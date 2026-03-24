import { lazy } from 'react';
import { FuseRouteItemType } from '@fuse/utils/FuseUtils';

const AnalyticsHomeAppView = lazy(() => import('./components/views/AnalyticsHomeAppView'));

/**
 * The Analytics Home App Route
 */
const route: FuseRouteItemType = {
	path: 'homes/analytics',
	element: <AnalyticsHomeAppView />
};

export default route;

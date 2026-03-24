import { lazy } from 'react';
import { FuseRouteItemType } from '@fuse/utils/FuseUtils';

const FinanceHomeAppView = lazy(() => import('./components/views/FinanceHomeAppView'));

/**
 * Finance Home App Route
 */
const route: FuseRouteItemType = {
	path: 'homes/finance',
	element: <FinanceHomeAppView />
};

export default route;

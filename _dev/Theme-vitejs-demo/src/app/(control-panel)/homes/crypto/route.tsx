import { lazy } from 'react';
import { FuseRouteItemType } from '@fuse/utils/FuseUtils';

const CryptoHomeAppView = lazy(() => import('./components/views/CryptoHomeAppView'));

/**
 * Crypto Home App Route
 */
const route: FuseRouteItemType = {
	path: 'homes/crypto',
	element: <CryptoHomeAppView />
};

export default route;

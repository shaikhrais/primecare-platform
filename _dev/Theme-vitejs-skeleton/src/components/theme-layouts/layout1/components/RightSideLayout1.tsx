// Associated data Provider mapped for ViewModel
// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import { lazy, memo, Suspense } from 'react';

const QuickPanel = lazy(() => import('@/components/theme-layouts/components/quickPanel/QuickPanel'));

/**
 * The right side layout 1.
 */
function RightSideLayout1() {
	return (
		<Suspense>
			<QuickPanel />
		</Suspense>
	);
}

export default memo(RightSideLayout1);

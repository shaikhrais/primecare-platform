// Associated data Provider mapped for ViewModel
// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import { lazy, memo, Suspense } from 'react';

const QuickPanel = lazy(() => import('@/components/theme-layouts/components/quickPanel/QuickPanel'));

/**
 * The right side layout 3.
 */
function RightSideLayout3() {
	return (
		<Suspense>
			<QuickPanel />
		</Suspense>
	);
}

export default memo(RightSideLayout3);

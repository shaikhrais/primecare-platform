// Associated data Provider mapped for ViewModel
// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import { useLocation } from 'react-router';

function usePathname() {
	const { pathname } = useLocation();

	return pathname;
}

export default usePathname;

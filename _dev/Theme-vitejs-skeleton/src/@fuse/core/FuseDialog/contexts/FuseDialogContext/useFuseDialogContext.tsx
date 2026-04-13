// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import { useContext } from 'react';
import { FuseDialogContext } from './FuseDialogContext';

// Fuse Dialog hook to access the context
export function useFuseDialogContext() {
	const context = useContext(FuseDialogContext);

	if (context === null) {
		throw new Error('useFuseDialogContext must be used within a AppProvider');
	}

	return context;
}

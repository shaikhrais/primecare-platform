// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import { useContext } from 'react';
import JwtAuthContext from './JwtAuthContext';

function UseJwtAuth() {
	const context = useContext(JwtAuthContext);

	if (context === undefined) {
		throw new Error('JwtAuthContext must be used within a JwtAuthProvider');
	}

	return context;
}

export default UseJwtAuth;

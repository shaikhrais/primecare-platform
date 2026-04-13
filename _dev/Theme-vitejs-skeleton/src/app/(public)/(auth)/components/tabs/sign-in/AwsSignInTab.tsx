// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import AwsAuthenticator from '@auth/services/aws/components/AWSAuthenticator';

function AwsSignInTab() {
	return (
		<AwsAuthenticator
			initialState="signIn"
			socialProviders={['amazon', 'apple', 'facebook', 'google']}
			hideSignUp
		/>
	);
}

export default AwsSignInTab;

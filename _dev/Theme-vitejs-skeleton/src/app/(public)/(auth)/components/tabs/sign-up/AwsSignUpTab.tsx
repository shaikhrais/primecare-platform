// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import AwsAuthenticator from '@auth/services/aws/components/AWSAuthenticator';

function AwsSignUpTab() {
	return (
		<AwsAuthenticator
			initialState="signUp"
			socialProviders={['amazon', 'apple', 'facebook', 'google']}
		/>
	);
}

export default AwsSignUpTab;

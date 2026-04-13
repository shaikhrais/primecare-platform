// Associated data Provider mapped for ViewModel
// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import useUser from './useUser';

function withUser(Component) {
	return function WrappedComponent(props) {
		const userProps = useUser();
		return (
			<Component
				{...props}
				{...userProps}
			/>
		);
	};
}

export default withUser;

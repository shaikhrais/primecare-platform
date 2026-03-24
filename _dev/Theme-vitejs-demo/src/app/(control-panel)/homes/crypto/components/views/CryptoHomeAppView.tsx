'use client';
import { useEffect, useState } from 'react';
import FusePageSimple from '@fuse/core/FusePageSimple';
import { styled } from '@mui/material/styles';
import useThemeMediaQuery from '@fuse/hooks/useThemeMediaQuery';
import FuseLoading from '@fuse/core/FuseLoading';
import CryptoHomeAppSidebar from '../ui/CryptoHomeAppSidebar';
import CryptoHomeAppContent from '../ui/CryptoHomeAppContent';
import { useGetWidgets } from '../../api/hooks/widgets/useGetWidgets';
import CryptoHomeAppHeader from '../ui/CryptoHomeAppHeader';

const Root = styled(FusePageSimple)(({ theme }) => ({
	'& .FusePageSimple-contentWrapper': {
		paddingTop: 2,
		paddingLeft: 2
	},
	'& .FusePageSimple-content': {
		boxShadow: theme.vars.shadows[2],
		borderRadius: '12px 0 0 0',
		backgroundColor: theme.vars.palette.background.paper
	},
	'& .FusePageSimple-sidebarWrapper': {
		border: 'none'
	},
	'& .FusePageSimple-sidebarContent': {
		backgroundColor: theme.vars.palette.background.default
	}
}));

/**
 * The CryptoHomeApp page.
 */
function CryptoHomeAppView() {
	const isMobile = useThemeMediaQuery((theme) => theme.breakpoints.down('lg'));
	const [leftSidebarOpen, setLeftSidebarOpen] = useState(!isMobile);

	const { data: widgets, isLoading } = useGetWidgets();

	useEffect(() => {
		setLeftSidebarOpen(!isMobile);
	}, [isMobile]);

	if (!widgets) {
		return null;
	}

	if (isLoading) {
		return <FuseLoading />;
	}

	return (
		<Root
			leftSidebarProps={{
				content: <CryptoHomeAppSidebar />,
				open: leftSidebarOpen,
				onClose: () => setLeftSidebarOpen(false),
				width: 320
			}}
			content={
				<>
					<CryptoHomeAppHeader onToggleLeftSidebar={() => setLeftSidebarOpen(!leftSidebarOpen)} />
					<CryptoHomeAppContent />
				</>
			}
		/>
	);
}

export default CryptoHomeAppView;

import BtcMainChart from './widgets/BTCMainChart';

/**
 * Crypto Home App Content
 */
function CryptoHomeAppContent() {
	return (
		<div className="flex max-w-full min-w-0 flex-auto flex-col overflow-hidden">
			<BtcMainChart />
		</div>
	);
}

export default CryptoHomeAppContent;

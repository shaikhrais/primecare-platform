import {mountKitchenSink} from '../../packages/primecare_master/web/kitchen-sink';
import '../../packages/primecare_master/web/kitchen-sink.css';
import '../../packages/primecare_master/web/kitchen-sink-theme.css';

const root=document.querySelector<HTMLElement>('[data-cy=kitchen-sink-root]');
if(!root)throw Error('Kitchen sink root missing');
export const showcase=mountKitchenSink(root,{bridgeTheme:true});
export {mountKitchenSink};
window.addEventListener('pagehide',()=>showcase.dispose(),{once:true});

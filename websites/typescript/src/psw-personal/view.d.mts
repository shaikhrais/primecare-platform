import type {CareOwnership} from '../care/ownership';
import type {LiveCareClient} from '../care/live-client';
export function renderPersonalView(root:HTMLElement,gateway:string,initial:any,api:any,options:{owner:CareOwnership;clinical:LiveCareClient}):Promise<void>;

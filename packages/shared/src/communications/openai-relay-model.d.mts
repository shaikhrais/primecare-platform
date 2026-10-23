import {CommunicationResourceBase} from './adapter-base.mjs';
import type {RelayTools} from './twilio-relay-session.mjs';
export type OpenAiRelayModelOptions={apiKey:string;model:string;taskGuide:string;taskIds:readonly string[];fetch?:typeof globalThis.fetch};
export class OpenAiRelayModel extends CommunicationResourceBase {
 constructor(options:OpenAiRelayModelOptions);
 respond(input:{text:string;tools:RelayTools;signal:AbortSignal}):Promise<string>;
}

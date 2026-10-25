import {CommunicationResourceBase} from './adapter-base.mjs';
import type {MessagingReplyModel} from './messaging-ai.ts';
export class OpenAiMessageModel extends CommunicationResourceBase implements MessagingReplyModel {
 constructor(options:{apiKey:string;model:string;serviceGuide:string;fetch?:typeof globalThis.fetch});
 reply(input:{text:string;signal:AbortSignal}):Promise<string>;
}

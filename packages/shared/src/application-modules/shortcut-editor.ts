import {ApplicationSettingsPort} from './settings-port';
import {WorkFailure} from '../../../domain/src/work_modules';
/** One explicit settings editor owns the existing B15 client, cache and uncertain receipt. */
export class ApplicationShortcutEditor {
 private owned:ReturnType<ApplicationSettingsPort['claimShortcutEditor']>;private dead=false;
 constructor(private port:ApplicationSettingsPort){this.owned=port.claimShortcutEditor();if(Object.keys(this.owned.names).some(id=>!/^[1-9][0-9]{0,9}$/.test(id))){port.dispose();throw new WorkFailure('invalid');}}
 get recoveryPreview(){return this.owned.client.recoveryPreview;}
 async reviewRecovery(){this.open();return this.owned.client.reviewRecovery();}
 cancelRecovery(){this.open();this.owned.client.cancelRecovery();}
 async confirmRecovery(token:string,mode:'restore'|'reset'){this.open();await this.owned.client.confirmRecovery(token,mode);}
 get binding(){return this.owned.client.binding;}
 get current(){const state=this.owned.client.current;return {...state,selected:[...((state.draft as {screenIds:string[]}|null)?.screenIds??this.owned.defaults)]};}
 subscribe(listener:()=>void){return this.owned.client.subscribe(listener);}
 destinations(query='',locale:'en'|'fr'|'es'='en'){this.open();if(typeof query!=='string'||query.length>100||!['en','fr','es'].includes(locale))throw new WorkFailure('invalid');const search=query.toLocaleLowerCase(locale);return Object.entries(this.owned.names).filter(([,name])=>name.toLocaleLowerCase(locale).includes(search)).map(([id,title])=>({id,title}));}
 private open(){if(this.dead)throw new WorkFailure('unavailable');}
 private editable(){this.open();const state=this.current;if(!state.loaded||state.pending||state.remote||!['clean','dirty','offline'].includes(state.status))throw new WorkFailure('conflict',409);}
 async load(){this.open();await this.owned.client.load();}
 async toggle(id:string){this.editable();if(!Object.hasOwn(this.owned.names,id))throw new WorkFailure('denied',403);const ids=this.current.selected,index=ids.indexOf(id);if(index<0)ids.push(id);else ids.splice(index,1);await this.owned.client.edit({version:1,screenIds:ids});}
 async useDefaults(){this.editable();await this.owned.client.edit({version:1,screenIds:[...this.owned.defaults]});}
 private async verify(){const state=this.current;if(state.status==='clean'&&!state.dirty&&!state.pending&&!state.remote)await this.owned.client.load();}
 async save(){this.editable();if(!this.current.dirty)throw new WorkFailure('invalid');await this.owned.client.save();await this.verify();}
 async retryPending(){this.open();await this.owned.client.retryPending();await this.verify();}
 async acceptRemote(){this.open();await this.owned.client.acceptRemote();}
 async keepLocal(){this.open();await this.owned.client.keepLocal();}
 dispose(){if(this.dead)return;this.dead=true;this.port.dispose();}
}

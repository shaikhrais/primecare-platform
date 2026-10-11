import catalog from '../../../contracts/admin-tasks.json';
export type RoleTaskDefinition={id:string;titleKey:string;descriptionKey:string;operation:string};

/** Role metadata describes available workflows; it never authorizes requests. */
export abstract class BaseRoleTask {
  constructor(public readonly role:string, protected readonly definition:RoleTaskDefinition){
    if(!/^[a-z][a-z-]*$/.test(definition.id)||definition.titleKey!==`task.${definition.id}.title`||definition.descriptionKey!==`task.${definition.id}.description`)throw Error('Invalid role task definition');
  }
  toContract(){return {...this.definition};}
}
export class AdminTask extends BaseRoleTask {
  constructor(definition:RoleTaskDefinition){
    super('admin',definition);
    if(!['workspace.read','accounts.create','accounts.update','audit.read','language.select','tenants.create','masters.manage','monitor.read'].includes(definition.operation))throw Error('Invalid Admin task operation');
  }
}
export function adminTasks(){
  if(catalog.role!=='admin'||new Set(catalog.tasks.map(task=>task.id)).size!==catalog.tasks.length)throw Error('Invalid Admin task catalog');
  return catalog.tasks.map(task=>new AdminTask(task).toContract());
}

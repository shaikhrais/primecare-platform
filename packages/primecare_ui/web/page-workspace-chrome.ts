import type {PageChrome} from '../../domain/src/page_template';
/** Transient presentation only. Never writes the workspace profile or unhides an originally hidden slot. */
export class PageWorkspaceChrome {
 private original: {element:HTMLElement;hidden:boolean;inert:boolean}[];
 constructor(private frame:HTMLElement,slots:{navigation:HTMLElement;toolbar:HTMLElement;footer?:HTMLElement}){
  if(frame.hasAttribute('data-pc-page-chrome-navigation'))throw Error('Chrome already managed');
  this.original=Object.values(slots).filter(Boolean).map(element=>({element,hidden:element.hidden,inert:element.inert}));
  this.slots=slots;
 }
 private slots:{navigation:HTMLElement;toolbar:HTMLElement;footer?:HTMLElement};
 apply(value:PageChrome):void{for(const key of ['navigation','toolbar','footer'] as const){this.frame.setAttribute('data-pc-page-chrome-'+key,value[key]?'visible':'hidden');const element=this.slots[key],base=this.original.find(x=>x.element===element);if(element&&base){element.hidden=base.hidden||!value[key];element.inert=base.inert||!value[key];}}}
 dispose():void{for(const key of ['navigation','toolbar','footer'])this.frame.removeAttribute('data-pc-page-chrome-'+key);for(const base of this.original){base.element.hidden=base.hidden;base.element.inert=base.inert;}}
}

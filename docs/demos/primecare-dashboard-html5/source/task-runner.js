'use strict';
(() => {
  const mount = document.querySelector('#task-runner');
  if (!mount) return;
  const code = mount.dataset.code;
  const templates = window.PRIMECARE_TEMPLATES?.[code] || [];
  const key = 'primecare-demo-v1-' + code;
  const states = {todo:'To do',doing:'In progress',blocked:'Blocked',done:'Done'};
  const labels = {start:'Start',block:'Block',complete:'Complete',reopen:'Reopen'};
  const changes = {start:'doing',block:'blocked',complete:'done',reopen:'todo'};
  const transitions = {todo:['start','block','complete'],doing:['block','complete'],blocked:['start','complete','reopen'],done:['reopen']};
  let tasks = [], available = true;
  function load() {
    try {
      const raw = JSON.parse(localStorage.getItem(key) || '[]');
      tasks = Array.isArray(raw) ? raw.filter(t => t && typeof t.title === 'string' && typeof t.id === 'string' && Object.hasOwn(states,t.status)) : [];
    } catch {available=false;}
  }
  function persist() {
    try {localStorage.setItem(key,JSON.stringify(tasks));}
    catch {available=false;}
  }
  const e = (tag, text, attrs={}) => {
    const x = document.createElement(tag);
    if (text != null) x.textContent = text;
    for (const [k,v] of Object.entries(attrs)) x.setAttribute(k,String(v));
    return x;
  };
  const button = (text, fn, cls='') => {
    const b=e('button',text,{type:'button',class:cls});
    b.addEventListener('click',fn); return b;
  };
  const field = (label,control) => { const l=e('label',label); l.append(control); return l; };
  const select = options => {
    const s=e('select'); for (const [v,label] of options) s.append(e('option',label,{value:v})); return s;
  };
  const header=e('div',null,{class:'tr-head'});
  header.append(e('p','LOCAL PRACTICE', {class:'tr-kicker'}),e('h2','Task workbench'));
  header.append(e('p','Fictional tasks only. Do not enter real patient, customer, or staff details. Nothing runs in live PrimeCare.'));
  const message=e('p',null,{class:'tr-notice',role:'status', 'aria-live':'polite'});
  function announce(text) {
    message.textContent=text + (available ? '':(text?' ':'')+'Browser storage is unavailable; export your tasks before closing.');
  }
  const actions=e('div',null,{class:'tr-actions'});
  const scenario=select([['custom','Blank practice task'], ...templates.map((t,i)=>[String(i),t.title])]);
  const add=button('New task',()=>compose(scenario.value), 'tr-primary');
  const search=e('input',null,{type:'search',placeholder:'Title, fields or notes'});
  const filter=select([['all','All statuses'],...Object.entries(states)]);
  const filterrow=e('div',null,{class:'tr-filters'});
  const counts=e('p',null,{class:'tr-counts'});
  const list=e('ul',null,{class:'tr-list'});
  const dialog=e('dialog',null,{class:'tr-dialog','aria-labelledby':'tr-dialog-title'});
  let restore=null, dialogToken=null, historyClosed=false;
  const dialogHistoryKey='primecareLocalDialog';
  function clearStaleHistory() {
    try {
      const state=window.history.state;
      if (state?.[dialogHistoryKey]) {
        const next={...state}; delete next[dialogHistoryKey];
        window.history.replaceState(next,'');
      }
    } catch {} // Some browsers limit history for local files.
  }
  clearStaleHistory();
  dialog.addEventListener('close',()=> {
    if(historyClosed) historyClosed=false;
    else {
      const closedToken=dialogToken;
      dialogToken=null;
      try {
        if(closedToken && window.history.state?.[dialogHistoryKey]===closedToken) window.history.back();
      } catch {}
    }
    if(restore?.isConnected) restore.focus(); else add.focus();
  });
  window.addEventListener('popstate',event=>{
    const found=event.state?.[dialogHistoryKey];
    if(found && found===dialogToken) {
      if(!dialog.open) {dialog.showModal(); (first() || dialog.querySelector('button'))?.focus();}
      return;
    }
    if(dialog.open) {historyClosed=true;dialog.close();}
    if(found) clearStaleHistory();
  });
  actions.append(field('Practice scenario',scenario),add,
    button('Export JSON',doExport),button('Reset tasks',confirmReset));
  filterrow.append(field('Find a task',search),field('Filter by status',filter));
  mount.classList.add('tr-shell');
  mount.append(header,actions,filterrow,counts,message,list,dialog);
  search.addEventListener('input',render);
  filter.addEventListener('change',render);
  function open(title) {
    restore=document.activeElement;
    dialog.replaceChildren(e('h3',title,{id:'tr-dialog-title'}));
    dialog.showModal();
    try {
      dialogToken=Date.now()+'-'+Math.random().toString(36).slice(2);
      window.history.pushState({...window.history.state,[dialogHistoryKey]:dialogToken},'');
    } catch {dialogToken=null;}
  }
  const first = () => dialog.querySelector('input:not([type=hidden]),textarea,select');
  function compose(option) {
    const tpl = option==='custom' ? null : templates[Number(option)];
    open('Create a fictional task');
    const form=e('form',null,{class:'tr-form'});
    if(tpl) form.append(e('p',tpl.description,{class:'tr-help'}));
    const title=e('input',null,{name:'title',required:true,maxlength:120});
    title.value=tpl?.title || '';
    const priority=select([['normal','Normal'],['low','Low'],['high','High']]);
    const notes=e('textarea',null,{name:'notes',maxlength:1200,rows:3});
    form.append(field('Task title',title),field('Priority',priority));
    const fields=(tpl?.fields || []).map(def=>{
      const options=(def.options || []).map(o=>Array.isArray(o) ? o : typeof o==='object' ? [o.value,o.label] : [o,o]);
      const control=def.type==='select' ? select([['','Choose a value'],...options]) :
        e('input',null,{type:['date','number','text'].includes(def.type) ? def.type:'text',maxlength:160});
      control.setAttribute('name', 'practice-'+def.key);
      if (def.required) control.required=true;
      form.append(field(def.label,control));return [def,control];
    });
    form.append(field('Fictional notes',notes));
    const row=e('div',null,{class:'tr-actions'});
    row.append(e('button','Create task',{type:'submit',class:'tr-primary'}),button('Cancel',()=>dialog.close()));
    form.append(row); dialog.append(form);
    form.addEventListener('submit',event=>{
      event.preventDefault();
      if(!title.value.trim()){title.setCustomValidity('Enter a task title.');title.reportValidity();return;}
      tasks.unshift({id:globalThis.crypto?.randomUUID?.() || Date.now()+'-'+Math.random().toString(36).slice(2),title:title.value.trim(),
        status:'todo',priority:priority.value,notes:notes.value.trim(),
        scenario:tpl?.title || 'Blank practice task',
        fields:fields.map(([def,c])=>({label:def.label,value:c.value.trim()})).filter(x=>x.value),
        history:[],updated:new Date().toISOString()});
      persist(); filter.value='all';search.value='';render();dialog.close();announce('Local task created.');
    });
    title.addEventListener('input',()=>title.setCustomValidity(''));
    first()?.focus();
  }
  function move(task,action) {
    if(!transitions[task.status].includes(action)) return;
    if(!Array.isArray(task.history)) task.history=[];
    const now=new Date().toISOString();
    task.history.push({from:task.status,to:changes[action],time:now});
    task.status=changes[action];task.updated=now;
    persist();render();announce('Task is now '+states[task.status]+'.');
    const target=Array.from(list.querySelectorAll('[data-task]')).find(x=>x.dataset.task===task.id);
    (target?.querySelector('button') || filter).focus();
  }
  function edit(task) {
    open('Edit local task notes');
    const area=e('textarea',null,{maxlength:1200,rows:5});
    area.value=task.notes || '';
    const row=e('div',null,{class:'tr-actions'});
    row.append(button('Save notes',()=>{
      task.notes=area.value.trim();task.updated=new Date().toISOString();
      persist();render();dialog.close();announce('Local task notes saved.');
    },'tr-primary'),button('Cancel',()=>dialog.close()));
    dialog.append(field('Fictional notes',area),row);area.focus();
  }
  function render() {
    const terms=search.value.toLocaleLowerCase().trim().split(/\s+/).filter(Boolean);
    const visible=tasks.filter(t=>(filter.value==='all'||t.status===filter.value) && terms.every(term=>
      [t.title,t.notes,t.scenario,t.priority,...(Array.isArray(t.fields)?t.fields.map(f=>f.value):[])].join(' ').toLocaleLowerCase().includes(term)));
    counts.textContent=visible.length+' of '+tasks.length+' local tasks · '+Object.keys(states).map(s=>states[s]+': '+tasks.filter(t=>t.status===s).length).join(' · ');
    list.replaceChildren();
    if(!visible.length) list.append(e('li',tasks.length?'No matching tasks.':'No local tasks yet. Pick a fictional scenario or start with a blank task.',{class:'tr-empty'}));
    for(const task of visible) {
      const row=e('li',null,{class:'tr-card','data-task':task.id});
      const main=e('div',null,{class:'tr-card-head'});
      const text=e('div');text.append(e('h3',task.title),e('p',task.scenario || 'Local practice task',{class:'tr-help'}));
      const meta=e('div',null,{class:'tr-tags'});
      meta.append(e('span',states[task.status],{class:'tr-state','data-state':task.status}),e('span',(task.priority||'normal')+' priority',{class:'tr-tag'}));
      main.append(text,meta);row.append(main);
      if(Array.isArray(task.fields) && task.fields.length) {
        const d=e('details');d.append(e('summary','Scenario fields'));
        const dl=e('dl');for(const f of task.fields) dl.append(e('dt',f.label),e('dd',f.value));d.append(dl);row.append(d);
      }
      if(task.notes) {const d=e('details');d.append(e('summary','Notes'),e('p',task.notes));row.append(d);}
      if(Array.isArray(task.history)&&task.history.length) {
        const d=e('details');d.append(e('summary','Status history'));
        const hist=e('ul');for(const h of task.history) hist.append(e('li',states[h.from]+' → '+states[h.to]+' · '+new Date(h.time).toLocaleString()));d.append(hist);row.append(d);
      }
      const buttons=e('div',null,{class:'tr-actions'});
      for(const action of transitions[task.status])buttons.append(button(labels[action],()=>move(task,action),action==='complete'?'tr-primary':''));
      buttons.append(button('Edit notes',()=>edit(task)));
      row.append(buttons);list.append(row);
    }
  }
  function doExport() {
    const blob=new Blob([JSON.stringify({fictional:true,dashboardCode:code,tasks},null,2)+'\n'],{type:'application/json'});
    const url=URL.createObjectURL(blob);const a=e('a',null,{href:url,download:'primecare-practice-'+code+'.json'});
    mount.append(a);a.click();a.remove();setTimeout(()=>URL.revokeObjectURL(url),1000);
    announce('Local practice file prepared for download.');
  }
  function confirmReset() {
    open('Reset this dashboard’s local tasks?');
    dialog.append(e('p','This removes only practice tasks on this dashboard. Export first if you want a copy.'));
    const row=e('div',null,{class:'tr-actions'});
    row.append(button('Cancel',()=>dialog.close()),button('Reset this dashboard',()=>{
      tasks=[];
      try {localStorage.removeItem(key);}
      catch {available=false;}
      render();dialog.close();announce('Local tasks cleared for this dashboard.');
    },'tr-danger'));
    dialog.append(row);row.firstChild.focus();
  }
  load();render();announce('');
})();

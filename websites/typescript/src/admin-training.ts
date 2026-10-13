import course from './training/admin-course.json';
import {TrainingProgress} from './training/progress';
import {liveScreenText} from './screen-text';
type Locale='en'|'fr'|'es';
export function trainingText(gateway:string,locale:Locale,key:string):string {
 return liveScreenText(gateway).text('admin_training',locale,key,(course.locales[locale] as Record<string,string>)[key]??key);
}
/** Self-study content never invokes business mutations or sends a report. */
export function trainingPanel(gateway:string,actor:string,initialLocale:Locale='en'):HTMLElement {
 const root=document.createElement('section');root.className='section admin-training';root.dataset.cy='screen-admin-training';
 let locale=initialLocale,selected=course.modules[0],answer:number|null=null,noticeKey='';
 let progress:TrainingProgress;try{progress=new TrainingProgress(gateway,actor);}catch{progress=new TrainingProgress(gateway,actor,{getItem:()=>null,setItem:()=>{throw Error('Storage unavailable');},removeItem:()=>{throw Error('Storage unavailable');}});}
 const text=(key:string)=>trainingText(gateway,locale,key);
 function updateText(){root.lang=locale;root.querySelector('[data-cy=training-language]')?.setAttribute('aria-label',text('language'));root.querySelector('[data-cy=training-lessons]')?.setAttribute('aria-label',text('lessons'));root.querySelectorAll<HTMLElement>('[data-training-text]').forEach(el=>el.textContent=text(el.dataset.trainingText!));root.querySelectorAll<HTMLButtonElement>('[data-language]').forEach(el=>el.setAttribute('aria-pressed',String(el.dataset.language===locale)));const status=root.querySelector<HTMLOutputElement>('[data-cy=training-status]');if(status)status.textContent=noticeKey?text(noticeKey):'';}
 const label=(key:string)=>`<span data-training-text="${key}"></span>`;
 function draw(){const passed=progress.results();const count=passed.length;root.innerHTML=`<h2 data-training-text="title"></h2><p data-training-text="scope"></p><p class="notice" data-training-text="local_note"></p><p data-training-text="safety"></p>
 <div role="group" data-cy="training-language" aria-label=""><span data-training-text="language"></span>${(['en','fr','es'] as Locale[]).map(l=>`<button type="button" data-language="${l}" data-cy="training-language-${l}" lang="${l}">${label({en:'language_en',fr:'language_fr',es:'language_es'}[l])}</button>`).join('')}</div>
 <p data-cy="training-progress">${label('progress')}: <strong>${count}/${course.modules.length}</strong></p>${count===course.modules.length?'<p class="notice" data-training-text="complete" data-cy="training-complete"></p>':''}
 <nav data-cy="training-lessons">${course.modules.map(m=>`<button type="button" data-lesson="${m.id}" data-cy="training-lesson-${m.id}" aria-current="${m.id===selected.id?'step':'false'}">${label(m.keys.title)} · ${label(passed.some(r=>r.lesson===m.id)?'passed':'pending')}</button>`).join('')}</nav>
 <article data-cy="training-lesson"><h3 tabindex="-1" data-training-text="${selected.keys.title}"></h3><h4 data-training-text="procedure"></h4><p data-training-text="${selected.keys.procedure}"></p><h4 data-training-text="practice"></h4><p data-training-text="${selected.keys.practice}"></p>
 <fieldset><legend data-training-text="${selected.keys.question}"></legend>${selected.keys.options.map((key,i)=>`<button type="button" data-answer="${i}" data-cy="training-answer-${i}" aria-pressed="${i===answer}">${label(key)}</button>`).join('')}</fieldset><button type="button" data-cy="training-submit">${label('submit')}</button><output role="status" aria-live="polite" data-cy="training-status"></output></article>
 <p data-training-text="export_scope"></p><div class="report-controls"><button type="button" data-cy="training-export">${label('export')}</button><button type="button" data-cy="training-reset">${label('reset')}</button></div>`;
 updateText();
 root.querySelectorAll<HTMLButtonElement>('[data-language]').forEach(button=>button.onclick=()=>{locale=button.dataset.language as Locale;updateText();});
 root.querySelectorAll<HTMLButtonElement>('[data-lesson]').forEach(button=>button.onclick=()=>{selected=course.modules.find(m=>m.id===button.dataset.lesson)!;answer=null;noticeKey='';draw();root.querySelector<HTMLElement>('article h3')?.focus();});
 root.querySelectorAll<HTMLButtonElement>('[data-answer]').forEach(button=>button.onclick=()=>{answer=Number(button.dataset.answer);root.querySelectorAll<HTMLButtonElement>('[data-answer]').forEach(b=>b.setAttribute('aria-pressed',String(Number(b.dataset.answer)===answer)));});
 root.querySelector<HTMLButtonElement>('[data-cy=training-submit]')!.onclick=()=>{if(answer===null){noticeKey='select_answer';updateText();return;}try{noticeKey=progress.answer(selected.id,answer)?'correct':'incorrect';}catch{noticeKey='storage_error';}draw();root.querySelector<HTMLButtonElement>('[data-cy=training-submit]')?.focus();};
 root.querySelector<HTMLButtonElement>('[data-cy=training-export]')!.onclick=()=>{const url=URL.createObjectURL(new Blob([JSON.stringify(progress.summary(),null,2)],{type:'application/json'}));const a=document.createElement('a');a.href=url;a.download='PrimeCare-Admin-Training-Summary.json';a.click();setTimeout(()=>URL.revokeObjectURL(url),1000);};
 root.querySelector<HTMLButtonElement>('[data-cy=training-reset]')!.onclick=()=>{if(!confirm(text('reset_confirm')))return;try{progress.reset();noticeKey='';}catch{noticeKey='storage_error';}draw();root.querySelector<HTMLButtonElement>('[data-cy=training-reset]')?.focus();};
 }
 draw();const stop=liveScreenText(gateway).subscribe(()=>{if(root.isConnected)updateText();else stop();});return root;
}
export function openAdminTraining(gateway:string,actor:string,locale:Locale='en'):void {
 const dialog=document.createElement('dialog');dialog.className='layout-customizer';dialog.dataset.cy='training-dialog';dialog.setAttribute('aria-label',trainingText(gateway,locale,'title'));
 const close=document.createElement('button');close.type='button';close.dataset.cy='training-close';close.textContent=trainingText(gateway,locale,'close');close.onclick=()=>dialog.close();dialog.append(close,trainingPanel(gateway,actor,locale));document.body.append(dialog);dialog.addEventListener('close',()=>dialog.remove(),{once:true});dialog.showModal();
}

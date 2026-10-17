import assert from 'node:assert/strict';
import {mkdir,writeFile} from 'node:fs/promises';

/** Retain the original axe finding; recheck its live element after bringing it into view. */
export async function reviewContrast(page,name){
 const report=await page.evaluate(async()=>{
  const options={runOnly:['color-contrast'],elementRef:true};
  const original=await window.axe.run(document,options);
  const candidates=original.incomplete.flatMap(rule=>rule.id==='color-contrast'?rule.nodes:[]);
  const outcomes=[];
  const luminance=rgb=>rgb.map(value=>{const s=value/255;return s<=0.04045?s/12.92:((s+0.055)/1.055)**2.4;}).reduce((sum,value,i)=>sum+value*[0.2126,0.7152,0.0722][i],0);
  const ratio=(a,b)=>(Math.max(luminance(a),luminance(b))+0.05)/(Math.min(luminance(a),luminance(b))+0.05);
  if(ratio([0,0,0],[255,255,255])!==21||ratio([90,90,90],[90,90,90])!==1)throw Error('Contrast reference check failed');
  const color=value=>{const m=/^rgba?\(([^)]+)\)$/.exec(value);if(!m)return null;const values=m[1].split(',').map(Number);if(![3,4].includes(values.length)||values.some(v=>!Number.isFinite(v))||values.slice(0,3).some(v=>v<0||v>255)||values.length===4&&(values[3]<0||values[3]>1))return null;return {rgb:values.slice(0,3),alpha:values[3]??1};};
  for(const candidate of candidates){
   const element=candidate.element,base={target:candidate.target,html:candidate.html,original:candidate.any.map(check=>({message:check.message,data:check.data}))};
   if(!(element instanceof Element)||typeof element.scrollIntoView!=='function'||!element.isConnected){outcomes.push({...base,status:'unresolved',reason:'No connected HTML element reference'});continue;}
   const state={x:scrollX,y:scrollY,parents:[]};for(let p=element.parentElement;p;p=p.parentElement)if(p.scrollWidth>p.clientWidth||p.scrollHeight>p.clientHeight)state.parents.push({element:p,x:p.scrollLeft,y:p.scrollTop});
   const control=element instanceof HTMLTextAreaElement&&!element.disabled&&!element.readOnly&&element.maxLength!==0&&element.value===''?{value:element.value,start:element.selectionStart,end:element.selectionEnd,direction:element.selectionDirection,x:element.scrollLeft,y:element.scrollTop}:null;
   if(control){base.probe='Temporary typed-text state, restored after measurement';element.value='Aa09'.slice(0,element.maxLength>0?element.maxLength:4);}
   try{
    element.scrollIntoView({block:'center',inline:'center',behavior:'instant'});await new Promise(requestAnimationFrame);
    const rect=element.getBoundingClientRect();
    if(rect.bottom<=0||rect.top>=innerHeight||rect.right<=0||rect.left>=innerWidth){outcomes.push({...base,status:'unresolved',reason:'Element remains outside the viewport'});continue;}
    const retry=await window.axe.run(element,options);
    const direct=group=>retry[group].flatMap(rule=>rule.nodes).find(node=>node.element===element);
    if(retry.violations.length){outcomes.push({...base,status:'violation',reason:retry.violations.flatMap(rule=>rule.nodes.map(node=>({target:node.target,summary:node.failureSummary})))});continue;}
    if(direct('passes')){outcomes.push({...base,status:control?'axe_pass_with_control_probe':'axe_pass_after_scroll'});continue;}
    // Supplemental measurements never turn an axe incomplete into an axe pass.
    // Require opaque sRGB colors, plain content and unobscured text/graphic samples.
    const graphic=element instanceof HTMLElement&&element.dataset.cy==='sidebar-toggle'&&candidate.any.some(check=>check.data?.messageKey==='nonBmp');
    const plainText=element instanceof HTMLElement&&element.childElementCount===0&&/[\p{L}\p{N}]/u.test(element.textContent??'');
    if(graphic||plainText||control){
     let supported=true,background=null;const fg=color(getComputedStyle(element).color),foreground=fg?.alpha===1?fg.rgb:null;
     for(let p=element;p;p=p.parentElement){const css=getComputedStyle(p);if(css.opacity!=='1'||css.filter!=='none'||css.mixBlendMode!=='normal')supported=false;for(const pseudo of ['::before','::after'])if(!['none','normal'].includes(getComputedStyle(p,pseudo).content))supported=false;if(!background){if(css.backgroundImage!=='none')supported=false;const bg=color(css.backgroundColor);if(!bg||bg.alpha>0&&bg.alpha<1)supported=false;if(bg?.alpha===1)background=bg.rgb;}}
     if(element.closest('table')?.querySelector('col,colgroup'))supported=false;
     const css=getComputedStyle(element);if(css.textShadow!=='none'||css.webkitTextFillColor!==css.color||parseFloat(css.webkitTextStrokeWidth)>0)supported=false;
     const range=document.createRange();range.selectNodeContents(element);const boxes=control?[element.getBoundingClientRect()]:[...range.getClientRects()];
     if(!boxes.length||boxes.some(box=>{const x=box.left+box.width/2,y=box.top+box.height/2;return x<0||y<0||x>=innerWidth||y>=innerHeight||document.elementFromPoint(x,y)!==element;}))supported=false;
     if(supported&&foreground&&background){const threshold=graphic||parseFloat(css.fontSize)>=24||parseFloat(css.fontSize)>=56/3&&Number(css.fontWeight)>=700?3:4.5;const contrast=ratio(foreground,background);outcomes.push({...base,status:contrast>=threshold?(graphic?'supplemental_graphic_measurement':control?'supplemental_control_measurement':'supplemental_text_measurement'):'violation',contrast,threshold,foreground,background,reason:'Computed opaque solid-color contrast on an unobscured element; original axe incomplete retained'});continue;}
    }
    const remaining=direct('incomplete');outcomes.push({...base,status:'unresolved',reason:remaining?.failureSummary??'Target was not individually classified on recheck'});
   }finally{if(control){element.value=control.value;element.setSelectionRange(control.start,control.end,control.direction);element.scrollLeft=control.x;element.scrollTop=control.y;}for(const parent of state.parents){parent.element.scrollLeft=parent.x;parent.element.scrollTop=parent.y;}window.scrollTo({left:state.x,top:state.y,behavior:'instant'});}
  }
  return {scope:'Current rendered state; original automated findings retained',candidateCount:candidates.length,outcomes};
 });
 await mkdir('test-results/contrast',{recursive:true});
 await writeFile('test-results/contrast/'+name+'.json',JSON.stringify(report,null,2));
 assert.deepEqual(report.outcomes.filter(item=>item.status==='violation'),[],'Confirmed contrast failures: '+name);
 return report;
}

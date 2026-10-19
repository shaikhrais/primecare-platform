/** Presentation only: retain readable place names without covering territory markers. */
export function observeTerritoryLabels(map:SVGSVGElement):()=>void{
 const probe=document.createElement('span');probe.dataset.cy='territory-label-metrics';probe.setAttribute('aria-hidden','true');probe.style.cssText='position:absolute;visibility:hidden;pointer-events:none;font-size:var(--font-size-caption);padding:var(--spacing-xs);border:var(--media-border-width) solid transparent';map.parentElement!.append(probe);
 const layout=()=>{
  const matrix=map.getScreenCTM(),frame=map.getBoundingClientRect();
  if(!matrix||!frame.width)return;
  const scale=Math.hypot(matrix.a,matrix.b),css=getComputedStyle(probe);
  const font=parseFloat(css.fontSize);
  const gap=parseFloat(css.paddingLeft);
  const stroke=parseFloat(css.borderTopWidth);
  if(!scale||![font,gap,stroke].every(Number.isFinite))return;
  type Box={left:number;right:number;top:number;bottom:number};
  const intersects=(a:Box,b:Box)=>a.left<b.right+gap&&a.right+gap>b.left&&a.top<b.bottom+gap&&a.bottom+gap>b.top;
  const occupied:Box[]=[...map.querySelectorAll<SVGGElement>('[data-cy^="territory-number-"]')].map(e=>e.getBoundingClientRect());
  for(const label of map.querySelectorAll<SVGTextElement>('[data-map-label]')){
   const x=Number(label.dataset.mapX),y=Number(label.dataset.mapY);
   label.setAttribute('x',String(x));label.setAttribute('y',String(y));
   label.style.fontSize=`${font/scale}px`;label.style.strokeWidth=`${stroke/scale}px`;label.style.visibility='visible';
   const anchor=new DOMPoint(x,y).matrixTransform(matrix),rect=label.getBoundingClientRect();
   if(anchor.x<frame.left||anchor.x>frame.right||anchor.y<frame.top||anchor.y>frame.bottom){label.style.visibility='hidden';continue;}
   // Prefer the original position, then the other three sides of the place anchor.
   const positions=[[rect.left,rect.top],[rect.left,rect.top-rect.height-gap*2],[anchor.x+gap,anchor.y-rect.height/2],[anchor.x-rect.width-gap,anchor.y-rect.height/2]];
   let placed=false;
   for(const [left,top] of positions){
    const box={left:left-stroke,right:left+rect.width+stroke,top:top-stroke,bottom:top+rect.height+stroke};
    if(box.left<frame.left+gap||box.right>frame.right-gap||box.top<frame.top+gap||box.bottom>frame.bottom-gap||occupied.some(other=>intersects(box,other)))continue;
    label.setAttribute('x',String(x+(left-rect.left)/scale));label.setAttribute('y',String(y+(top-rect.top)/scale));occupied.push(box);placed=true;break;
   }
   if(!placed)label.style.visibility='hidden';
  }
  map.dataset.labelsReady='true';
 };
 const observer=new ResizeObserver(layout);observer.observe(map);layout();
 return ()=>{observer.disconnect();probe.remove();};
}

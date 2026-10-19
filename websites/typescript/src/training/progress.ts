import course from './admin-course.json';
export type TrainingResult={lesson:string;passedAt:string};
export type TrainingSummary={course:string;version:string;recordType:'device-self-assessment';generatedAt:string;passed:TrainingResult[];total:number;supervisorVerified:false};
/** Device progress is scoped to gateway, account and immutable course version. */
export class TrainingProgress {
 private key:string;
 constructor(gateway:string,actor:string,private storage:Pick<Storage,'getItem'|'setItem'|'removeItem'>=localStorage){
  if(!actor)throw Error('Training account scope required');
  this.key='primecare.training.v1.'+encodeURIComponent(gateway.replace(/\/+$/,''))+'.'+encodeURIComponent(actor)+'.'+course.version;
 }
 results():TrainingResult[]{
  try{const raw=this.storage.getItem(this.key)??'[]';if(raw.length>32768)return [];const value=JSON.parse(raw);if(!Array.isArray(value)||value.length>course.modules.length)return [];const seen=new Set<string>();return value.filter(r=>r&&typeof r.lesson==='string'&&course.modules.some(m=>m.id===r.lesson)&&typeof r.passedAt==='string'&&Number.isFinite(Date.parse(r.passedAt))&&!seen.has(r.lesson)&&!!seen.add(r.lesson)).map(({lesson,passedAt})=>({lesson,passedAt}));}catch{return [];}
 }
 answer(lesson:string,answer:number):boolean{
  const module=course.modules.find(m=>m.id===lesson);if(!module||!Number.isInteger(answer)||answer<0||answer>2)throw Error('Invalid training answer');
  if(module.correct!==answer)return false;
  const results=this.results();if(!results.some(r=>r.lesson===lesson))results.push({lesson,passedAt:new Date().toISOString()});
  this.storage.setItem(this.key,JSON.stringify(results));return true;
 }
 reset(){this.storage.removeItem(this.key);}
 summary():TrainingSummary{return {course:course.course,version:course.version,recordType:'device-self-assessment',generatedAt:new Date().toISOString(),passed:this.results(),total:course.modules.length,supervisorVerified:false};}
}

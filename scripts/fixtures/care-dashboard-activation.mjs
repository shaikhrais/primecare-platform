import {readFile} from 'node:fs/promises';
/** Exercise the dedicated strict Care renderer without activating it in any product portal. */
export const syntheticCareActivation = {
  name:'synthetic-care-activation',
  setup(build){
    build.onLoad({filter:/[/\\]dashboard-activation\.json$/},async({path})=>{
      const data=JSON.parse(await readFile(path,'utf8'));
      data.retained.push({project:'primecare-clinic',appCode:'ci',code:'care_delivery',route:'/care'});
      return {contents:JSON.stringify(data),loader:'json'};
    });
  },
};

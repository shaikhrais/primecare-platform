import registry from '../growth/registry.json' with {type:'json'};
const text=(maxLength=500)=>({type:'string',minLength:1,maxLength});
const due={anyOf:[{type:'string',format:'date-time',maxLength:40},{type:'null'}]};
const schema=(properties,required=Object.keys(properties))=>({type:'object',additionalProperties:false,properties,required});
/** Only model-entered business fields. Existing API versions, destination,
 * authentication, actor, tenant, lead, owner and operation key stay host-bound. */
export const nativeGrowthToolSchemas=Object.freeze({
 'lead.lookup':schema({}),
 'lead.contact_preferences':schema({}),
 'lead.create':schema({name:text(150),email:{type:'string',maxLength:254},phone:{type:'string',maxLength:40},source:{type:'string',enum:[...registry.sources]},reference:text(),contactBasis:{type:'string',enum:['requested','not_requested']},dueAt:due},['name','source','reference','contactBasis']),
 'lead.advance':schema({evidence:text(),dueAt:due},['evidence']),
 'lead.followup':schema({outcome:{type:'string',enum:[...registry.callOutcomes]},notes:text(),dueAt:due},['outcome','notes']),
 'lead.suppress':schema({notes:text()}),
 'lead.contact_update':schema({name:text(150),email:{type:'string',maxLength:254},phone:{type:'string',maxLength:40},evidence:text()}),
 'consultation.create':schema({startsAt:{type:'string',format:'date-time',maxLength:40},duration:{type:'integer',minimum:15,maximum:180},notes:text()}),
 'consultation.update':schema({status:{type:'string',enum:['completed','cancelled','no_show']},notes:text()})
});

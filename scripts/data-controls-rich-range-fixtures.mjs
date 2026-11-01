/** Shared web/Dart oracle. UI-independent projections, never business records. */
export function richRangeFixture(api){
 const cases=[];
 for(const text of ['Hello world','a😀b','e\u0301 café',''])for(const bold of [false,true])for(const italic of [false,true]){
  let block={text,bold,italic,kind:'paragraph'},steps=[];
  for(let i=0;i<8;i++){
   const bounds=Array.from({length:block.text.length+1},(_,n)=>n).filter(n=>api.richTextBoundary(block.text,n));
   if(bounds.length>1){const a=(i*3)%(bounds.length-1),b=a+1+(i*7)%(bounds.length-a-1),style=i%2?'italic':'bold';
    block=api.toggleRichRange(block,bounds[a],bounds[b],style);steps.push({action:'toggle',start:bounds[a],end:bounds[b],style,expected:block,runs:api.richRuns(block)});
   }
   const replacement=i%3===0?'X'+block.text:i%3===1?block.text+'!':block.text.replace('X','');
   block=api.replaceRichText(block,replacement);steps.push({action:'replace',text:replacement,expected:block,runs:api.richRuns(block)});
  }
  cases.push({initial:{text,bold,italic,kind:'paragraph'},steps});
 }
 return {format:1,offsetUnit:'UTF-16; no surrogate-pair split',cases};
}

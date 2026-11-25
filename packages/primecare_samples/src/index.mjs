import {demoTableRows,demoChartSeries} from '@primecare/demo';

/** Reusable presentation sample configurations, independent of any business route. */
export function tableSample(labels) {
  return {
    columns:[{key:'name',label:labels.name,width:180,visible:true,pinned:true},{key:'status',label:labels.status,width:140,visible:true,pinned:false}],
    rows:demoTableRows(labels.demo,labels.success),
    options:{rowHeight:48,height:240,minWidth:100,maxWidth:500,actionWidth:160,pageSize:6},
  };
}
export function chartSample(kind,labels) {
  return {
    data:{kind,title:labels.title,
      categories:kind==='donut'?Array.from({length:6},(_,i)=>labels.demo+' '+(i+1)):[labels.optionOne,labels.optionTwo,labels.status],
      series:demoChartSeries(kind,labels.demo)},
    options:{width:420,height:220,stroke:2},
  };
}

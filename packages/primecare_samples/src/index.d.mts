import type {DemoRow,DemoSeries} from '@primecare/demo';
type ChartKind='line'|'area'|'bar'|'donut';
export function tableSample(labels:{name:string;status:string;demo:string;success:string}): {
  columns:{key:string;label:string;width:number;visible:boolean;pinned:boolean}[];
  rows:DemoRow[];
  options:{rowHeight:number;height:number;minWidth:number;maxWidth:number;actionWidth:number;pageSize:number};
};
export function chartSample(kind:ChartKind,labels:{title:string;demo:string;optionOne:string;optionTwo:string;status:string}): {
  data:{kind:ChartKind;title:string;categories:string[];series:DemoSeries[]};
  options:{width:number;height:number;stroke:number};
};

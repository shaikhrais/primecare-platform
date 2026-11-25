export interface DemoRow {id:string;values:{name:string;status:string}}
export interface DemoSeries {id:string;label:string;values:number[]}
export function demoTableRows(demoLabel:string,statusLabel:string): DemoRow[];
export function demoChartSeries(kind:'line'|'area'|'bar'|'donut',demoLabel:string): DemoSeries[];

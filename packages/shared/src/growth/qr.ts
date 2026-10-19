import QRCode from './vendor/qrcode/index.js';
import {registry} from './contract';
export function enquiryUrl(origin:string,key:string){
 const url=new URL(origin);if(!['https:','http:'].includes(url.protocol)||url.username||url.password||url.pathname!=='/'||url.search||url.hash||! /^[0-9a-f]{64}$/.test(key))throw Error('Invalid enquiry URL');
 return url.origin+registry.intakePolicy.route+key+'?enable-semantics=true';
}
export function qrSymbol(url:string){
 if(url.length>registry.intakePolicy.qr.maxUrlLength||!/^[\x20-\x7e]+$/.test(url))throw Error('QR payload out of range');
 const parsed=new URL(url);if(!['https:','http:'].includes(parsed.protocol)||parsed.username||parsed.password)throw Error('Invalid QR URL');
 const qr=new QRCode(-1,0);qr.addData(url);qr.make();const size=qr.getModuleCount(),quiet=registry.intakePolicy.qr.quietZone,width=size+quiet*2;
 const matrix=Array.from({length:size},(_,r)=>Array.from({length:size},(_,c)=>qr.isDark(r,c)));
 const path=matrix.flatMap((row,r)=>row.flatMap((dark,c)=>dark?[`M${c+quiet} ${r+quiet}h1v1h-1z`]:[])).join('');
 const svg=`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} ${width}" width="${width*6}" height="${width*6}" shape-rendering="crispEdges"><rect width="${width}" height="${width}" fill="${registry.intakePolicy.qr.background}"/><path d="${path}" fill="${registry.intakePolicy.qr.foreground}"/></svg>`;
 return {matrix,quiet,width,svg};
}

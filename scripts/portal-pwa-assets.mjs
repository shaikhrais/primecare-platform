import {deflateSync} from 'node:zlib';
import {mkdirSync,writeFileSync} from 'node:fs';
import {join} from 'node:path';
const crc32=bytes=>{let value=0xffffffff;for(const byte of bytes){value^=byte;for(let bit=0;bit<8;bit++)value=(value>>>1)^((value&1)?0xedb88320:0);}return (value^0xffffffff)>>>0;};
const chunk=(name,data)=>{const tag=Buffer.from(name),size=Buffer.alloc(4),crc=Buffer.alloc(4);size.writeUInt32BE(data.length);crc.writeUInt32BE(crc32(Buffer.concat([tag,data])));return Buffer.concat([size,tag,data,crc]);};
/** Code-owned app mark, padded inside the maskable safe area. No image dependency. */
export function portalIcon(size){
 if(![192,512].includes(size))throw Error('Unsupported app icon size');
 const raw=Buffer.alloc(size*(1+size*4));
 for(let y=0;y<size;y++)for(let x=0;x<size;x++){
  const offset=y*(1+size*4)+1+x*4;
  const u=(x+.5)/size,v=(y+.5)/size;
  const cross=u>=.42&&u<=.58&&v>=.24&&v<=.76||v>=.42&&v<=.58&&u>=.24&&u<=.76;
  raw.set(cross?[255,255,255,255]:[0,107,104,255],offset);
 }
 const header=Buffer.alloc(13);header.writeUInt32BE(size,0);header.writeUInt32BE(size,4);header[8]=8;header[9]=6;
 return Buffer.concat([Buffer.from([137,80,78,71,13,10,26,10]),chunk('IHDR',header),chunk('IDAT',deflateSync(raw)),chunk('IEND',Buffer.alloc(0))]);
}
export function portalManifest(name){
 if(typeof name!=='string'||!name.trim()||name.length>150)throw Error('Portal name required');
 return {id:'/',name,short_name:'PrimeCare',description:'PrimeCare staff and account portal',start_url:'/login?source=pwa',scope:'/',display:'standalone',background_color:'#f5f8fa',theme_color:'#006b68',prefer_related_applications:false,icons:[{src:'/icons/primecare-192.png',sizes:'192x192',type:'image/png',purpose:'any'},{src:'/icons/primecare-512.png',sizes:'512x512',type:'image/png',purpose:'any maskable'}]};
}
// Only navigations get an offline explanation. No cached logins, APIs or private pages.
export const portalServiceWorker=`self.addEventListener('install',event=>{event.waitUntil(self.skipWaiting());});
self.addEventListener('activate',event=>{event.waitUntil(self.clients.claim());});
self.addEventListener('fetch',event=>{
 if(event.request.method!=='GET'||event.request.mode!=='navigate'||new URL(event.request.url).origin!==self.location.origin)return;
 event.respondWith(fetch(event.request,{cache:'no-store'}).catch(()=>new Response('<!doctype html><html lang="en"><meta name="viewport" content="width=device-width,initial-scale=1"><title>PrimeCare · Offline</title><main><h1>You are offline</h1><p>Reconnect to the internet and reload this page to sign in or make calls.</p></main></html>',{status:503,headers:{'content-type':'text/html; charset=utf-8','cache-control':'no-store'}})));
});
`;
export function writePortalPwa(target,name){
 mkdirSync(join(target,'icons'),{recursive:true});
 for(const size of [192,512])writeFileSync(join(target,'icons','primecare-'+size+'.png'),portalIcon(size));
 writeFileSync(join(target,'manifest.webmanifest'),JSON.stringify(portalManifest(name),null,2)+'\n');
 writeFileSync(join(target,'service-worker.js'),portalServiceWorker);
}

import {defineConfig} from 'vite';
import base from './vite.config.mts';
import {fileURLToPath} from 'node:url';
// Original Vite plugins, Tailwind, aliases and CSS; only auth's user hook is local.
export default defineConfig({...base,server:{host:'127.0.0.1',port:4317,strictPort:true,open:false},
 optimizeDeps:{include:['react','react-dom','@mui/material','lodash']},
 resolve:{...base.resolve,alias:[{find:'@auth/useUser',replacement:fileURLToPath(new URL('./src/cloud-user-fixture.ts',import.meta.url))},...Object.entries(base.resolve?.alias??{}).map(([find,replacement])=>({find,replacement}))]}});

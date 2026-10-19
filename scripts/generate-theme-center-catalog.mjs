import {readFile,writeFile} from 'node:fs/promises';
const presets=JSON.parse(await readFile('scripts/fuse_presets.json','utf8'));const keys=['primary','primaryContainer','secondary','background','surface','text','muted','border','sidebar','topbar'];
const source=`// Generated from scripts/fuse_presets.json. Run scripts/generate-theme-center-catalog.mjs.\nconst themeCenterPresetNames = <String>[${Object.keys(presets).map(k=>JSON.stringify(k)).join(',')}];\nconst themeCenterColorKeys = <String>[${keys.map(k=>JSON.stringify(k)).join(',')}];\n`;
const file='packages/flutter_core/lib/theme/theme_center_catalog_generated.dart';if(process.argv.includes('--check')){if(await readFile(file,'utf8')!==source)throw Error('Theme Center catalog drift');}else await writeFile(file,source);

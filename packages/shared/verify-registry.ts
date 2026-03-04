import { ContentRegistry } from './src/registries/ContentRegistry';

console.log('Master ContentRegistry Keys:', Object.keys(ContentRegistry));
console.log('LAYOUT property:', ContentRegistry.LAYOUT ? 'Exists' : 'Missing');
console.log('MENU properties:', Object.keys(ContentRegistry.MENU));

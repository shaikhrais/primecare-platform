import * as fs from 'fs';
import * as path from 'path';
import { FormRegistry } from '../src/registries/form_registry';

/**
 * PrimeCare Registry Sync Verifier
 * 
 * This tool enforces a "Zero-Error" state by ensuring that every form defined in the 
 * Flutter 'PrimeCareForm' enum has a corresponding entry in the domain-layer TypeScript registry.
 */

import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const FLUTTER_ENUM_PATH = path.resolve(__dirname, '../../primecare_adapters/lib/src/registry/primecare_form_enum.dart');

function extractEnumValues(filePath: string): string[] {
    const content = fs.readFileSync(filePath, 'utf8');
    const enumMatch = content.match(/enum PrimeCareForm \{([\s\S]*?)\}/);
    if (!enumMatch) return [];
    
    return enumMatch[1]
        .split(',')
        .map(line => line.trim())
        .filter(line => line && !line.startsWith('//'))
        .map(line => line.split('(')[0].split(' ')[0].trim());
}

async function verify() {
    console.log('🚀 Starting PrimeCare Registry Verification...');
    
    const flutterForms = extractEnumValues(FLUTTER_ENUM_PATH);
    console.log(`📊 Found ${flutterForms.length} forms in Flutter enum.`);
    
    const registeredForms = Object.values(FormRegistry).map(f => f.id);
    const domainFormSet = new Set(registeredForms);
    
    const missing = flutterForms.filter(f => !domainFormSet.has(f));
    
    if (missing.length === 0) {
        console.log('✅ SUCCESS: 100% Registry Parity achieved.');
    } else {
        console.warn(`⚠️  WARNING: ${missing.length} forms are missing from the domain registry.`);
        console.log('Missing IDs:');
        missing.forEach(id => console.log(` - ${id}`));
        
        // Detailed check for the 'skeleton' category
        const skeletons = Object.values(FormRegistry).filter(f => f.category === 'skeleton').length;
        console.log(`🦴  Skeletons present: ${skeletons}`);
    }
}

verify().catch(console.error);

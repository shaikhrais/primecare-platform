import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const FLUTTER_ENUM_PATH = path.resolve(__dirname, '../../primecare_adapters/lib/src/registry/primecare_form_enum.dart');
const OUTPUT_PATH = path.resolve(__dirname, '../src/registries/FormRegistry/skeleton-forms.ts');

function extractEnumValues(filePath: string): string[] {
    const content = fs.readFileSync(filePath, 'utf8');
    const enumMatch = content.match(/enum PrimeCareForm \{([\s\S]*?)\}/);
    if (!enumMatch) return [];
    
    return enumMatch[1]
        .split(',')
        .map(line => line.trim())
        .filter(line => line && !line.startsWith('//') && line !== ';')
        .map(line => line.split('(')[0].split(' ')[0].trim())
        .filter(id => id.length > 0);
}

function generateSkeletonFile(ids: string[]) {
    const header = `import { FormEntry } from '../form_registry';\n\n/**\n * Skeleton Form Definitions\n * Automatically generated transient placeholders for the 351-entry Flutter registry.\n */\nexport const SKELETON_FORMS: FormEntry[] = [\n`;
    
    const body = ids.map(id => `    { id: '${id}', label: '${id.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase())} (Skeleton)', category: 'skeleton', fields: [] }`).join(',\n');
    
    const footer = `\n];\n`;
    
    fs.writeFileSync(OUTPUT_PATH, header + body + footer);
    console.log(`✅ Generated ${ids.length} skeletons at ${OUTPUT_PATH}`);
}

const ids = extractEnumValues(FLUTTER_ENUM_PATH);
generateSkeletonFile(ids);

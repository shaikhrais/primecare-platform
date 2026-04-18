const fs = require('fs');
const path = require('path');

const directoryPath = 'packages/factory_system/primecare_ui/lib/src';

function migrateAdapters(dir) {
    fs.readdirSync(dir).forEach(file => {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            migrateAdapters(fullPath);
        } else if (fullPath.endsWith('.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');

            // Find // TODO: Prisma API binding
            if (content.includes('// TODO: Prisma API binding')) {
                console.log(`Migrating ${fullPath}...`);

                // Ensure primecare_core is imported
                if (!content.includes('package:primecare_core/flutter_core.dart')) {
                    content = content.replace(/(import 'package:flutter_riverpod\/flutter_riverpod.dart';)/, "$1\nimport 'package:primecare_core/flutter_core.dart';");
                }

                // Identify the ViewModel name from the signature
                // e.g. state = AssignCarePodFormViewModel(isLoading: true, data: state.data);
                const stateRegex = /state\s*=\s*([A-Za-z0-9_]+ViewModel)\(isLoading:\s*true/;
                const match = content.match(stateRegex);
                const viewModelName = match ? match[1] : 'dynamic';

                const endpointPath = `/api/v1/${path.basename(file, '.dart').replace(/_/g, '-')}`;

                const replacementString = `    state = ${viewModelName}(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('${endpointPath}');
      state = ${viewModelName}(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = ${viewModelName}(isLoading: false, data: {});
    }`;

                const oldBlockRegex = /\/\/ TODO: Prisma API binding([\s\S]*?)(?:state\s*=\s*[A-Za-z0-9_]+ViewModel\(isLoading:\s*false.*?;)/;
                
                content = content.replace(oldBlockRegex, replacementString);

                fs.writeFileSync(fullPath, content, 'utf8');
                console.log(`✅ Updated ${fullPath}`);
            }
        }
    });
}

console.log("Starting Adapter Migration...");
migrateAdapters(directoryPath);
console.log("Migration Complete.");

const fs = require('fs');

function processFile(path, replacer) {
    if (fs.existsSync(path)) {
        let content = fs.readFileSync(path, 'utf8');
        let newContent = replacer(content);
        if (content !== newContent) {
            fs.writeFileSync(path, newContent, 'utf8');
            console.log('Updated ' + path);
        }
    } else {
        console.log('Not found ' + path);
    }
}

// 1. Unused local variables
processFile('lib/offices/client/roles/client/chat_with_provider.dart', c => c.replace('final theme = Theme.of(context);\n', ''));
processFile('lib/routes/app_router.dart', c => c.replace('final authNotifier = ref.watch(authProvider);\n', ''));
processFile('lib/services/auth_service.dart', c => c.replace('final String _baseUrl = \'https://api.primecare.org/v1/clinical\';\n', ''));

// 2. Deprecated activeColor inside Switch.adaptive
const activeColorFiles = [
    'lib/offices/clinic/roles/chiro/chiro_notes.dart',
    'lib/offices/clinic/roles/occupational_therapist/ot_notes.dart',
    'lib/offices/clinic/roles/physio/physio_notes.dart',
    'lib/offices/clinic/roles/rmt/rmt_notes.dart',
    'lib/offices/clinic/roles/rn/treatment_notes.dart',
    'lib/offices/clinic/roles/social_worker/counseling_notes.dart',
    'lib/offices/clinic/roles/speech_pathologist/slp_notes.dart'
];
for (const file of activeColorFiles) {
    processFile(file, c => c.replace(/activeColor:\s*(.+?),/g, 'activeTrackColor: $1,'));
}

processFile('lib/services/auth_service.dart', c => c.replace('      return true;\n    }\n    return false;\n  }', '      return true;\n    }\n  }'));

processFile('../../scripts/generate_office.dart', c => c.replace(/print\(/g, 'debugPrint('));
processFile('../../scripts/upgrade_stubs.dart', c => c.replace(/print\(/g, 'debugPrint(').replace('final int upgradedCount', '// final int upgradedCount'));

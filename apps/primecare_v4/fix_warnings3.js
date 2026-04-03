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

processFile('scripts/generate_office.dart', c => c.replace(/print\(/g, 'debugPrint(').replace("void main(List<String> args) {", "import 'package:flutter/foundation.dart';\nvoid main(List<String> args) {"));
processFile('scripts/upgrade_stubs.dart', c => c.replace(/print\(/g, 'debugPrint(').replace('final int upgradedCount', '// final int upgradedCount').replace("void main() async {", "import 'package:flutter/foundation.dart';\nvoid main() async {"));

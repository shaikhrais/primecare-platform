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

processFile('scripts/generate_office.dart', c => c.replace(/debugPrint\(/g, 'print(').replace("import 'package:flutter/foundation.dart';\n", "// ignore_for_file: avoid_print\n"));
processFile('scripts/upgrade_stubs.dart', c => c.replace(/debugPrint\(/g, 'print(').replace("import 'package:flutter/foundation.dart';\n", "// ignore_for_file: avoid_print, unused_local_variable\n"));

const fs = require('fs');
const path = require('path');

const UI_DIR = path.join(__dirname, 'packages', 'primecare_ui', 'lib', 'src', 'features', 'generated_screens');

for (let i = 1; i <= 251; i++) {
  const filePath = path.join(UI_DIR, `premium_feature_${i}.dart`);
  if (fs.existsSync(filePath)) {
    let content = fs.readFileSync(filePath, 'utf8');
    content = content.replace("import 'package:flutter/material.dart';\n", "");
    fs.writeFileSync(filePath, content);
  }
}
console.log('Removed flutter/material.dart from all 251 screens.');

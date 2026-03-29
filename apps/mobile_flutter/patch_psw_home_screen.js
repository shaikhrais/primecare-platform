const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'lib/features/roles/psw/psw_home_screen.dart');
let content = fs.readFileSync(filePath, 'utf8');

// 1. Add import
if (!content.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
  content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';");
}


// 2. Remove the helper functions completely
content = content.replace(/Widget _buildTopKpiCard[\s\S]*?Widget _buildUpcomingVisits/, "Widget _buildUpcomingVisits");

// Wait, the regex might be tricky if it spans hundreds of lines. Let's do string indexOf.
const startIndex = content.indexOf("Widget _buildTopKpiCard");
const endIndex = content.indexOf("  // --- WIDGETS ---");

if (startIndex !== -1 && endIndex !== -1) {
    content = content.substring(0, startIndex) + content.substring(endIndex + "  // --- WIDGETS ---\n".length);
}

// 3. Replace usages
content = content.replaceAll(
  /_buildTopKpiCard\(([^,]+), ([^,]+), ([^,]+), ([^\)]+)\)/g, 
  "PrimeCareKpiCard(title: $1, value: $2, icon: $3, subtitle: $4)"
);

content = content.replaceAll(
  /_buildSectionHeader\(([^)]+)\)/g, 
  "PrimeCareSectionHeader(title: $1)"
);

content = content.replaceAll(
  /_buildSectionHeaderWhite\(([^)]+)\)/g, 
  "PrimeCareSectionHeader(title: $1, isWhite: true)"
);

content = content.replaceAll(
  /_buildCardContainer\(/g, 
  "PrimeCareCardContainer("
);

fs.writeFileSync(filePath, content, 'utf8');
console.log("Successfully patched psw_home_screen.dart");

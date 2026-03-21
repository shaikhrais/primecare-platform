const fs = require('fs');
const path = require('path');

const targetDirs = [
  path.join(__dirname, '..', 'lib'),
  path.join(__dirname, '..', '..', '..', 'packages', 'primecare_ui', 'lib')
];

// Master Map of Hex Codes to PrimeCareColors variables
const COLOR_MAPPINGS = {
  '0xFF0F172A': 'PrimeCareColors.radarDark',
  '0xFF1E293B': 'PrimeCareColors.slate800',
  '0xFF334155': 'PrimeCareColors.slate700',
  '0xFF38BDF8': 'PrimeCareColors.skyBlue',
  '0xFF10B981': 'PrimeCareColors.emerald',
  '0xFFE11D48': 'PrimeCareColors.rose',
  '0xFFF59E0B': 'PrimeCareColors.amber',
  '0xFF64748B': 'PrimeCareColors.slate500',
  '0xFF94A3B8': 'PrimeCareColors.slate400',
  '0xFFCBD5E1': 'PrimeCareColors.slate300',
  '0xFFE2E8F0': 'PrimeCareColors.slate200',
  '0xFF020617': 'PrimeCareColors.darkMatrix',
  '0xFF141416': 'PrimeCareColors.darkMatrixCard',
  '0xFF8B5CF6': 'PrimeCareColors.purple',
  '0xFFFFFFFF': 'Colors.white',
  '0xFF000000': 'Colors.black',
  '0xFFFFF1F2': 'const Color(0xFFFFF1F2) /* TODO: Rose Background */',
  '0xFFE1E1E1': 'const Color(0xFFE1E1E1) /* TODO: Gray bg */',
  // SDU Form Engine values
  '0x0A000000': 'const Color(0x0A000000) /* Soft Shadow */',
  '0x0D000000': 'const Color(0x0D000000) /* Soft Shadow */',
};

// Colors to explicitly ignore (white, black) handled natively
const IGNORES = ['0xFFFFFFFF', '0xFF000000'];

let totalReplaced = 0;
let totalBlunders = 0;
const blunderLog = new Set();
const refactoredFiles = new Set();

function processDirectory(dirPath) {
  if (!fs.existsSync(dirPath)) return;
  const files = fs.readdirSync(dirPath);

  for (const file of files) {
    const fullPath = path.join(dirPath, file);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      processDirectory(fullPath);
    } else if (fullPath.endsWith('.dart')) {
      processFile(fullPath);
    }
  }
}

function processFile(filePath) {
  let content = fs.readFileSync(filePath, 'utf-8');
  let originalContent = content;

  // Regex to find things like Color(0xFF0F172A) or const Color(0xFF...)
  const colorRegex = /Color\((0x[A-Fa-f0-9]{8})\)/g;
  
  let match;
  let fileHasModifications = false;
  let hasMissingImports = false;

  while ((match = colorRegex.exec(originalContent)) !== null) {
    const rawMatch = match[1];
    const hex = rawMatch.toUpperCase().replace('0X', '0x');

    if (COLOR_MAPPINGS[hex]) {
      // It's a known mapped color
      content = content.replace(new RegExp(`const Color\\(${match[1]}\\)`, 'g'), COLOR_MAPPINGS[hex]);
      content = content.replace(new RegExp(`Color\\(${match[1]}\\)`, 'g'), COLOR_MAPPINGS[hex]);
      
      // Fix implicit "const Colors.white" parsing errors
      content = content.replace(/const PrimeCareColors\./g, 'PrimeCareColors.');
      content = content.replace(/const Colors\./g, 'Colors.');
      
      totalReplaced++;
      fileHasModifications = true;
      hasMissingImports = true;
    } else {
      // It's a BLUNDER - An unmapped, rogue color destroying the global aesthetic
      if (!IGNORES.includes(hex)) {
        blunderLog.add(`${hex} found in ${path.basename(filePath)}`);
        totalBlunders++;
      }
    }
  }

  if (fileHasModifications) {
    // Inject the import at the top if it doesn't exist
    if (!content.includes('core/colors.dart') && content.includes('PrimeCareColors.')) {
      // Naive auto-resolver for absolute depth (Assuming we are in lib/)
      const depth = filePath.split('lib\\').pop().split('\\').length - 1;
      let importStr = "import '";
      if (depth === 0) importStr += "core/colors.dart';\n";
      else {
        for(let i=0; i<depth; i++) importStr += "../";
        importStr += "core/colors.dart';\n";
      }
      
      // Inject after material.dart if possible
      if (content.includes("import 'package:flutter/material.dart';")) {
        content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\n" + importStr);
      } else {
        content = importStr + content;
      }
    }

    fs.writeFileSync(filePath, content, 'utf-8');
    refactoredFiles.add(path.basename(filePath));
  }
}

console.log("==========================================");
console.log("   PRIMECARE UI/UX AUDIT ENGINE v1.0");
console.log("==========================================\n");

console.log(`Scanning targets:`);
targetDirs.forEach(d => console.log(`- ${d}`));
console.log("");

targetDirs.forEach(dir => processDirectory(dir));

console.log(`\n[+] Phase 1: Normalization Complete`);
console.log(`[-] Exact Hex Codes Replaced: ${totalReplaced}`);
console.log(`[-] Files successfully refactored: ${refactoredFiles.size}`);

if (totalBlunders > 0) {
  console.log(`\n[!] Phase 2: BLUNDER AUDIT REPORT`);
  console.log(`[!] Found ${totalBlunders} unmapped rogue colors threatening the ecosystem:\n`);
  blunderLog.forEach(b => console.log(`    ⚠️ ${b}`));
} else {
  console.log(`\n[+] No unmapped rogue colors found. UI/UX is mathematically flawless.`);
}

console.log("\n==========================================");
console.log("         SYSTEM AUDIT COMPLETE");
console.log("==========================================");

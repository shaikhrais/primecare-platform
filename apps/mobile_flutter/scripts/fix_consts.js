const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log("Running flutter analyze to locate invalid_constant hooks...");
let output = '';
try {
    output = execSync('flutter analyze', { encoding: 'utf8' });
} catch (error) {
    output = error.stdout;
}

const lines = output.split('\n');
let fixedCount = 0;

for (const line of lines) {
    if (line.includes('invalid_constant')) {
        // Example: error - Invalid constant value - lib\main.dart:265:113 - invalid_constant
        const match = line.match(/(lib[^\:]+)\:(\d+)\:/);
        if (match) {
            const filePath = match[1].trim();
            const lineNumber = parseInt(match[2], 10) - 1; // 0-indexed

            if (fs.existsSync(filePath)) {
                const content = fs.readFileSync(filePath, 'utf8');
                const fileLines = content.split('\n');
                
                if (lineNumber >= 0 && lineNumber < fileLines.length) {
                    let currLine = lineNumber;
                    let found = false;
                    
                    // Look upwards up to 8 lines to find the offending `const`
                    while(currLine >= Math.max(0, lineNumber - 8)) {
                        if (fileLines[currLine].includes('const ')) {
                            fileLines[currLine] = fileLines[currLine].replace(/const\s+/g, '');
                            found = true;
                            // Re-write file immediately
                            fs.writeFileSync(filePath, fileLines.join('\n'), 'utf8');
                            fixedCount++;
                            break;
                        }
                        currLine--;
                    }
                }
            }
        }
    }
}

console.log(`Successfully severed ${fixedCount} invalid constant hierarchies natively.`);

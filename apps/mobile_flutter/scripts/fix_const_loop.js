const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

async function runLoop() {
    let hasIssues = true;
    let iterations = 0;

    while (hasIssues && iterations < 10) {
        iterations++;
        console.log(`\n--- Iteration ${iterations} ---`);
        let output = '';
        try {
            output = execSync('flutter analyze', { encoding: 'utf8' });
        } catch (error) {
            output = error.stdout;
        }

        const lines = output.split('\n');
        let fixedThisRound = 0;

        for (const line of lines) {
            if (line.includes('invalid_constant')) {
                const match = line.match(/(lib[^\:]+)\:(\d+)\:/);
                if (match) {
                    const filePath = match[1].trim();
                    const lineNumber = parseInt(match[2], 10) - 1;

                    if (fs.existsSync(filePath)) {
                        const content = fs.readFileSync(filePath, 'utf8');
                        const fileLines = content.split('\n');
                        
                        if (lineNumber >= 0 && lineNumber < fileLines.length) {
                            let currLine = lineNumber;
                            // Search upwards up to 60 lines for the 'const ' keyword
                            while(currLine >= Math.max(0, lineNumber - 60)) {
                                if (fileLines[currLine].includes('const ')) {
                                    fileLines[currLine] = fileLines[currLine].replace(/const\s+/g, '');
                                    fs.writeFileSync(filePath, fileLines.join('\n'), 'utf8');
                                    fixedThisRound++;
                                    break;
                                }
                                currLine--;
                            }
                        }
                    }
                }
            }
        }

        console.log(`Fixed ${fixedThisRound} invalid contexts.`);
        if (fixedThisRound === 0) {
            hasIssues = false;
        }
    }
    console.log("AST Const Sweeper Complete.");
}

runLoop();

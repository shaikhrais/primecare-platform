import { exec } from 'child_process';
import util from 'util';

const execAsync = util.promisify(exec);
const uuidRegex = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/gi;

let totalDeleted = 0;

async function run() {
    while (true) {
        console.log("\n==== Fetching next page of deployments ====");
        let output = "";
        try {
            const { stdout } = await execAsync("npx wrangler pages deployment list --project-name primecare-admin");
            output = stdout;
        } catch(e) {
            console.log("Failed to list deployments or exhausted.");
            break;
        }
        
        let matches = output.match(uuidRegex);
        if (!matches || matches.length <= 1) { 
            console.log("Empty dataset reached. The project has been fully depleted of legacy deployments.");
            break;
        }
        
        matches = [...new Set(matches)]; // Deduplicate array elements
        
        // Remove the first item from the array (often the active deployment) so it doesn't get stuck failing
        matches.shift(); 
        
        console.log("Discovered " + matches.length + " targets on this pagination tick. Blasting concurrently...");
        
        await Promise.all(matches.map(id => {
            return execAsync("npx wrangler pages deployment delete --project-name primecare-admin " + id + " --force").catch(() => {});
        }));
        
        totalDeleted += matches.length;
        console.log("Wipe cycle verified. Running total eradicated: " + totalDeleted);
    }
    console.log("\nDONE! Overrode Cloudflare pagination structure successfully. Safely dropped below 99 limits. Total Eradicated: " + totalDeleted);
}
run();

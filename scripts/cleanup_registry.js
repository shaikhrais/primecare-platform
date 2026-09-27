const fs = require('fs');
const path = require('path');

const REGISTRY_PATH = path.join(__dirname, '..', 'packages', 'primecare_ui', 'lib', 'src', 'registry', 'screen_registry.dart');
const ROLE_ACCESS_PATH = path.join(__dirname, '..', 'packages', 'primecare_ui', 'lib', 'src', 'features', 'admin', 'role_screen_access_screen.dart');

function cleanupFile(filePath) {
  if (!fs.existsSync(filePath)) {
    console.log(`File not found: ${filePath}`);
    return;
  }
  let content = fs.readFileSync(filePath, 'utf8');
  
  // Remove lines containing premium_feature_ or SCREEN_PREMIUM_FEATURE_
  const lines = content.split('\n');
  const newLines = lines.filter(line => 
    !line.includes('premium_feature_') && 
    !line.includes('SCREEN_PREMIUM_FEATURE_')
  );
  
  fs.writeFileSync(filePath, newLines.join('\n'), 'utf8');
  console.log(`Cleaned up ${filePath}`);
}

cleanupFile(REGISTRY_PATH);
cleanupFile(ROLE_ACCESS_PATH);

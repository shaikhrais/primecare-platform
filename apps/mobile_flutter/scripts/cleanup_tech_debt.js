const fs = require('fs');
const path = require('path');

const filesToNuke = [
    'lib/main_backup.dart',
    'test/api_mock_test.dart',
    'test/routing_regression_test.dart',
];

for (const file of filesToNuke) {
    if (fs.existsSync(file)) {
        fs.unlinkSync(file);
        console.log(`Successfully de-allocated deprecated legacy module: ${file}`);
    }
}

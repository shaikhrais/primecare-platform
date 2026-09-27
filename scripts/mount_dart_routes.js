const fs = require('fs');
const path = require('path');

const SERVICES_DIR = path.join(__dirname, '..', 'services');

const services = fs.readdirSync(SERVICES_DIR).filter(file => fs.statSync(path.join(SERVICES_DIR, file)).isDirectory());

let mountedCount = 0;

services.forEach(service => {
    const serverFilePath = path.join(SERVICES_DIR, service, 'bin', 'server.dart');
    const routesFilePath = path.join(SERVICES_DIR, service, 'lib', 'routes.dart');
    
    // Only mount if the service actually has generated routes
    if (fs.existsSync(serverFilePath) && fs.existsSync(routesFilePath)) {
        let content = fs.readFileSync(serverFilePath, 'utf8');
        
        // Don't mount twice
        if (!content.includes('ApiRoutes()')) {
            // Add import
            content = content.replace(/import 'package:shelf_router\/shelf_router.dart';/, 
              `import 'package:shelf_router/shelf_router.dart';\nimport 'package:${service}/routes.dart';`);
            
            // Add router mount
            content = content.replace(/final router = Router\(\);/, 
              `final router = Router();\n\n  // Mount the 456 AI-generated routes\n  final apiRoutes = ApiRoutes();\n  router.mount('/', apiRoutes.router.call);`);
              
            fs.writeFileSync(serverFilePath, content, 'utf8');
            mountedCount++;
        }
    }
});

console.log(`Successfully mounted generated ApiRoutes into ${mountedCount} backend server executables.`);

const fs = require('fs');
const path = require('path');

const APPS_DIR = path.join(__dirname, '..', 'apps');

function getDirectories(srcPath) {
  if (!fs.existsSync(srcPath)) return [];
  return fs.readdirSync(srcPath).filter(file => fs.statSync(path.join(srcPath, file)).isDirectory());
}

function getDartControllers(srcPath) {
    if (!fs.existsSync(srcPath)) return [];
    let results = [];
    const list = fs.readdirSync(srcPath);
    list.forEach(file => {
        const fullPath = path.join(srcPath, file);
        const stat = fs.statSync(fullPath);
        if (stat && stat.isDirectory()) { 
            results = results.concat(getDartControllers(fullPath));
        } else {
            if(file.endsWith('_controller.dart')) {
                results.push(fullPath);
            }
        }
    });
    return results;
}

const apps = getDirectories(APPS_DIR);

let modifiedCount = 0;

apps.forEach(app => {
  const libPath = path.join(APPS_DIR, app, 'lib');
  const controllerFiles = getDartControllers(libPath);
  
  controllerFiles.forEach(file => {
      let content = fs.readFileSync(file, 'utf8');
      
      // Target controllers that are currently using Future.delayed mock data
      if (content.includes('await Future.delayed(')) {
          
          // 1. Inject the Dio import at the top
          if (!content.includes('import \'package:dio/dio.dart\';')) {
              content = content.replace(/import 'package:riverpod_annotation\/riverpod_annotation.dart';/, 
                "import 'package:riverpod_annotation/riverpod_annotation.dart';\nimport 'package:dio/dio.dart';");
          }
          
          const endpointRoot = path.basename(file).replace('_controller.dart', '').replace(/_/g, '-');
          
          // 2. Replace the initial build() method's mock latency with real dio.get
          const buildRegex = /await Future\.delayed\(const Duration\(milliseconds: 600\)\);\s*return \{([\s\S]*?)\};/g;
          content = content.replace(buildRegex, (match, mockData) => {
              return `final dio = Dio();\n    try {\n      final response = await dio.get('http://localhost:3000/api/${endpointRoot}');\n      return response.data as Map<String, dynamic>;\n    } on DioException catch (e) {\n      // Fallback gracefully on 404 per user preference\n      if (e.response?.statusCode == 404) {\n        return {\n${mockData}        };\n      }\n      throw Exception('Failed to load data from backend API');\n    }`;
          });
          
          // 3. Replace the action method's mock latency with real dio.post
          const actionRegex = /await Future\.delayed\(const Duration\(milliseconds: 1200\)\);\s*return \{([\s\S]*?)\};/g;
          content = content.replace(actionRegex, (match, mockData) => {
              return `final dio = Dio();\n      final response = await dio.post('http://localhost:3000/api/${endpointRoot}/action');\n      return response.data as Map<String, dynamic>;`;
          });
          
          fs.writeFileSync(file, content, 'utf8');
          modifiedCount++;
      }
  });
});

console.log(`Successfully wired up real Dio HTTP networking into ${modifiedCount} Riverpod controllers.`);

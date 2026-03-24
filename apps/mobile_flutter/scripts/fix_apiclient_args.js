const fs = require('fs');
const path = require('path');

const apiPath = path.join(__dirname, '..', 'lib', 'core', 'api_client.dart');
let apiCode = fs.readFileSync(apiPath, 'utf8');

if (!apiCode.includes('Future<dynamic> patch(')) {
  const patchCode = `  Future<dynamic> patch(String endpoint, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    final response = await http.patch(
      Uri.parse('\$baseUrl\$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Server returned \${response.statusCode}');
    }
  }

  Future<dynamic> get(`;
  apiCode = apiCode.replace('Future<dynamic> get(', patchCode);
  fs.writeFileSync(apiPath, apiCode);
}

const f1 = path.join(__dirname, '..', 'lib', 'features', 'shared', 'universal_daily_tasks_screen.dart');
const f2 = path.join(__dirname, '..', 'lib', 'features', 'shared', 'universal_timeline_screen.dart');

[f1, f2].forEach(f => {
  if (fs.existsSync(f)) {
    let code = fs.readFileSync(f, 'utf8');
    
    // Explicit targeting resolving 'body:' named arguments into positional arrays securely
    code = code.split("apiClient.post('/v1/activities', body: {").join("apiClient.post('/v1/activities', {");
    code = code.split("body: { 'status': newStatus }").join("{ 'status': newStatus }");
    code = code.split("... } )").join("})"); // Any trailing cleanup
    
    fs.writeFileSync(f, code);
  }
});

console.log("ApiClient definitions and Flutter execution files seamlessly normalized physically.");

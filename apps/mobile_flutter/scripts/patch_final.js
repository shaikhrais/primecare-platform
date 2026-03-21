const fs = require('fs');

let cjm = fs.readFileSync('lib/features/coordinator/coordinator_jane_matrix_screen.dart', 'utf8');
cjm = cjm.replace(/PrimeCareCard\(width: 12, height: 12, \)/g, 'PrimeCareCard(child: const SizedBox.shrink(), width: 12, height: 12)');
cjm = cjm.replace(/alignment: Alignment\.centerLeft,/g, '');
cjm = cjm.replace(/\}\)\.toList\(\),/g, '}).toList().cast<Widget>(),');
fs.writeFileSync('lib/features/coordinator/coordinator_jane_matrix_screen.dart', cjm);

let clm = fs.readFileSync('lib/features/coordinator/coordinator_live_map_screen.dart', 'utf8');
clm = clm.replace(/extendBodyBehindAppBar:\s*true,/g, '');
clm = clm.replace(/PrimeCareCard\(\s*width:\s*50,\s*height:\s*50,/g, 'PrimeCareCard(child: const SizedBox.shrink(), width: 50, height: 50,');
clm = clm.replace(/PrimeCareCard\(\s*width:\s*20,\s*height:\s*20,/g, 'PrimeCareCard(child: const SizedBox.shrink(), width: 20, height: 20,');
fs.writeFileSync('lib/features/coordinator/coordinator_live_map_screen.dart', clm);

let cjs = fs.readFileSync('lib/features/coordinator/coordinator_jane_scheduler_screen.dart', 'utf8');
cjs = cjs.replace(/shadowColor:\s*Colors\.black12,/g, '');
cjs = cjs.replace(/PrimeCareCard\(height:\s*50,\s*\)/g, 'PrimeCareCard(child: const SizedBox.shrink(), height: 50)');
fs.writeFileSync('lib/features/coordinator/coordinator_jane_scheduler_screen.dart', cjs);

let mds = fs.readFileSync('lib/features/manager/manager_dashboard_screen.dart', 'utf8');
mds = mds.replace(/PrimeCareCard\(\s*margin:\s*EdgeInsets\.symmetric\(horizontal:\s*4\),\s*height:\s*height,/g, 'PrimeCareCard(child: const SizedBox.shrink(), margin: EdgeInsets.symmetric(horizontal: 4), height: height,');
fs.writeFileSync('lib/features/manager/manager_dashboard_screen.dart', mds);

let mtd = fs.readFileSync('lib/features/mt/mt_dashboard_screen.dart', 'utf8');
mtd = mtd.replace(/PrimeCareCard\(\s*width:\s*8,\s*height:\s*100,/g, 'PrimeCareCard(child: const SizedBox.shrink(), width: 8, height: 100,');
fs.writeFileSync('lib/features/mt/mt_dashboard_screen.dart', mtd);

console.log('Final native UI patches applied successfully.');

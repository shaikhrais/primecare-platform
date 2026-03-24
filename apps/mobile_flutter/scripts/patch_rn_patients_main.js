const fs = require('fs');
const path = require('path');

const mainPath = path.join(__dirname, '..', 'lib', 'main.dart');
let mainCode = fs.readFileSync(mainPath, 'utf8');

if (!mainCode.includes("import 'features/rn/rn_patients_screen.dart';")) {
  mainCode = "import 'features/rn/rn_patients_screen.dart';\n" + mainCode;
}

const targetStr = "GoRoute(path: '/rn/patients', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.rnPatientsScopeActive)))),";
const replacementStr = "GoRoute(path: '/rn/patients', builder: (context, state) => const RnPatientsScreen()),";

mainCode = mainCode.split(targetStr).join(replacementStr);

fs.writeFileSync(mainPath, mainCode);
console.log('Main.dart successfully patched mapping the real RN Patients UI Route precisely.');

const fs = require('fs');

function replaceFile(path, oldTextRegex, newText) {
    if (fs.existsSync(path)) {
        let content = fs.readFileSync(path, 'utf8');
        content = content.replace(oldTextRegex, newText);
        fs.writeFileSync(path, content);
    }
}

let psh = fs.readFileSync('lib/features/psw/psw_home_screen.dart', 'utf8');
psh = psh.replace(/AppLocalizations\.of\(context\)!\.organizationalFeed/g, "'Organizational Feed'");
psh = psh.replace(/AppLocalizations\.of\(context\)!\.surgeActiveLabel/g, "'Surge Active'");
fs.writeFileSync('lib/features/psw/psw_home_screen.dart', psh);

let pdb = fs.readFileSync('lib/features/psw/psw_dashboard_screen.dart', 'utf8');
pdb = pdb.replace(/alignment:\s*Alignment\.centerLeft,/g, '');
pdb = pdb.replace(/alignment:\s*Alignment\.centerRight,/g, '');
fs.writeFileSync('lib/features/psw/psw_dashboard_screen.dart', pdb);

let pcs = fs.readFileSync('lib/features/psw/psw_clients_screen.dart', 'utf8');
pcs = pcs.replace(/duration:\s*Duration\(milliseconds:\s*200\),/g, '');
pcs = pcs.replace(/PrimeCareCard\(\s*width:\s*8,\s*height:\s*8,/g, 'PrimeCareCard(child: const SizedBox.shrink(), width: 8, height: 8,');
fs.writeFileSync('lib/features/psw/psw_clients_screen.dart', pcs);

// Daily schedule
let pds = fs.readFileSync('lib/features/psw/psw_daily_schedule_screen.dart', 'utf8');
pds = pds.replace(/PrimeCareCard\(\s*width:\s*16,\s*height:\s*16,/g, 'PrimeCareCard(child: const SizedBox.shrink(), width: 16, height: 16,');
fs.writeFileSync('lib/features/psw/psw_daily_schedule_screen.dart', pds);

// Timesheet
let pts = fs.readFileSync('lib/features/psw/psw_timesheet_screen.dart', 'utf8');
pts = pts.replace(/PrimeCareCard\(\s*width:\s*24,\s*height:\s*24,/g, 'PrimeCareCard(child: const SizedBox.shrink(), width: 24, height: 24,');
fs.writeFileSync('lib/features/psw/psw_timesheet_screen.dart', pts);

// Messages
let pms = fs.readFileSync('lib/features/psw/psw_messages_screen.dart', 'utf8');
pms = pms.replace(/duration:\s*Duration\(milliseconds:\s*200\),/g, '');
fs.writeFileSync('lib/features/psw/psw_messages_screen.dart', pms);

// Live Visit
let plv = fs.readFileSync('lib/features/psw/psw_live_visit_screen.dart', 'utf8');
plv = plv.replace(/duration:\s*Duration\(milliseconds:\s*300\),/g, '');
plv = plv.replace(/PrimeCareCard\(\s*width:\s*280 \+ \(_pulseController\.value \* 40\),\s*height:\s*280 \+ \(_pulseController\.value \* 40\),/gm, 'PrimeCareCard(child: const SizedBox.shrink(), width: 280 + (_pulseController.value * 40), height: 280 + (_pulseController.value * 40),');
fs.writeFileSync('lib/features/psw/psw_live_visit_screen.dart', plv);

// Live triage
let plvt = fs.readFileSync('lib/features/psw/psw_live_video_triage_screen.dart', 'utf8');
plvt = plvt.replace(/PrimeCareCard\(\s*width:\s*8,\s*height:\s*8,/gm, 'PrimeCareCard(child: const SizedBox.shrink(), width: 8, height: 8,');
fs.writeFileSync('lib/features/psw/psw_live_video_triage_screen.dart', plvt);

console.log('PSW Sub-component layout faults corrected natively.');

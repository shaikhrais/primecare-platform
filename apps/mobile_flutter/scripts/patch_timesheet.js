const fs = require('fs');
const { execSync } = require('child_process');

try {
    execSync('git checkout lib/features/psw/psw_timesheet_screen.dart');
    
    let code = fs.readFileSync('lib/features/psw/psw_timesheet_screen.dart', 'utf8');
    
    // First, run clean_bg.js on it directly to simulate the environment
    code = code.replace(/backgroundColor:\s*PrimeCareColors\.ocean,?/g, ''); // Explicitly clean ocean background

    // Patch background explicitly
    code = code.replace(
`            PrimeCareCard(
              padding: EdgeInsets.all(24),
              
              child: PrimeCareColumn(`,
`            PrimeCareCard(
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(24),
              
              child: PrimeCareColumn(`
    );

    code = code.replace(
`PrimeCareText('Est. October Payout', style: TextStyle(color: PrimeCareColors.slate400, fontSize: 16)),`,
`PrimeCareText('Est. October Payout', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8), fontSize: 16)),`
    );

    code = code.replace(
`PrimeCareText('\\$4,250.75', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: -1)),`,
`PrimeCareText('\\$4,250.75', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: -1)),`
    );

    code = code.replace(
`Widget _buildMetric(String label, String value) {`,
`Widget _buildMetric(BuildContext context, String label, String value) {`
    );

    code = code.replace(
`_buildMetric('Hours', '142.5'),`,
`_buildMetric(context, 'Hours', '142.5'),`
    );

    code = code.replace(
`_buildMetric('Shifts', '22'),`,
`_buildMetric(context, 'Shifts', '22'),`
    );

    code = code.replace(
`_buildMetric('Surge OT', '18h'),`,
`_buildMetric(context, 'Surge OT', '18h'),`
    );

    code = code.replace(
`PrimeCareText(value, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),`,
`PrimeCareText(value, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 20, fontWeight: FontWeight.bold)),`
    );

    code = code.replace(
`PrimeCareText(label, style: TextStyle(color: PrimeCareColors.slate500, fontSize: 13, fontWeight: FontWeight.w600)),`,
`PrimeCareText(label, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.w600)),`
    );

    fs.writeFileSync('lib/features/psw/psw_timesheet_screen.dart', code);
    console.log('Successfully patched psw_timesheet_screen.dart natively.');
} catch (e) {
    console.error('Failed to execute replacement logic:', e.message);
}

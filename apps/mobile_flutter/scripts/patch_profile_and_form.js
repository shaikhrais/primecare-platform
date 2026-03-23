const fs = require('fs');

// 1. Fix psw_profile_screen.dart Camera Avatar Stack Background
try {
    let profile = fs.readFileSync('lib/features/psw/psw_profile_screen.dart', 'utf8');
    profile = profile.replace(
`                      PrimeCareCard(
                        
                        padding: EdgeInsets.all(8),
                        child: PrimeCareIcon(Icons.camera_alt, size: 16, color: Colors.white),
                      ),`,
`                      PrimeCareCard(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.all(8),
                        child: PrimeCareIcon(Icons.camera_alt, size: 16, color: Theme.of(context).colorScheme.onPrimary),
                      ),`
    );
    fs.writeFileSync('lib/features/psw/psw_profile_screen.dart', profile);
    console.log('Successfully patched profile static avatar payload.');
} catch(e) { console.error('Profile patch failed:', e); }

// 2. Fix sdui_form_builder.dart (SDUI engine static colors)
try {
    let formPath = '../../packages/primecare_ui/lib/src/components/sdui_form_builder.dart';
    let form = fs.readFileSync(formPath, 'utf8');
    
    // Replace hardcoded static layouts explicitly with reactive layout themes
    form = form.replace(/color:\s*Colors\.white/g, 'color: Theme.of(context).textTheme.bodyLarge?.color');
    form = form.replace(/color:\s*Colors\.grey\[400\]/g, 'color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6)');
    
    // Form Inputs & Containers mapping
    form = form.replace(/fillColor:\s*PrimeCareColors\.slate800/g, 'fillColor: Theme.of(context).cardColor');
    form = form.replace(/color:\s*Colors\.white24/g, 'color: Theme.of(context).dividerColor');
    form = form.replace(/dropdownColor:\s*PrimeCareColors\.slate800/g, 'dropdownColor: Theme.of(context).cardColor');
    
    // Boolean switch structural backgrounds
    form = form.replace(/decoration: BoxDecoration\(color: PrimeCareColors\.slate800/g, 'decoration: BoxDecoration(color: Theme.of(context).cardColor');
    
    // Primary Wrapper Background map
    form = form.replace(/decoration: BoxDecoration\(color: PrimeCareColors\.radarDark/g, 'decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface');
    
    fs.writeFileSync(formPath, form);
    console.log('Successfully injected dynamic context themes into SDUI payload rendering.');
} catch(e) { console.error('SDUI patch failed:', e); }

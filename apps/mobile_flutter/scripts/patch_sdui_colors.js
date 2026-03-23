const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

try {
    const rootDir = path.resolve(__dirname, '../../../../'); 
    // Wait, __dirname is .../apps/mobile_flutter/scripts
    // rootDir is .../primecare-platform
    execSync('git checkout packages/primecare_ui/lib/src/components/sdui_form_builder.dart', { 
        cwd: '../../', // From apps/mobile_flutter to primecare-platform
        stdio: 'inherit' 
    });

    let formPath = '../../packages/primecare_ui/lib/src/components/sdui_form_builder.dart';
    let form = fs.readFileSync(formPath, 'utf8');
    
    // REMOVE illegitmate 'const' identifiers causing Theme() evaluation crashes!
    form = form.replace(/const BorderSide/g, 'BorderSide');
    form = form.replace(/const TextStyle/g, 'TextStyle');
    form = form.replace(/const SizedBox\(height: 20, width: 20, child: CircularProgressIndicator\(color: Colors\.white\)\)/g, 'SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white))');

    // FIX the regex execution hierarchy natively! (Longest matches first!)
    form = form.replace(/color:\s*Colors\.white24/g, 'color: Theme.of(context).dividerColor');
    form = form.replace(/color:\s*Colors\.white/g, 'color: Theme.of(context).textTheme.bodyLarge?.color');
    form = form.replace(/color:\s*Colors\.grey\[400\]/g, 'color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6)');
    
    // Form Inputs & Containers mapping
    form = form.replace(/fillColor:\s*PrimeCareColors\.slate800/g, 'fillColor: Theme.of(context).cardColor');
    form = form.replace(/dropdownColor:\s*PrimeCareColors\.slate800/g, 'dropdownColor: Theme.of(context).cardColor');
    
    // Boolean switch structural backgrounds
    form = form.replace(/decoration: BoxDecoration\(color: PrimeCareColors\.slate800/g, 'decoration: BoxDecoration(color: Theme.of(context).cardColor');
    
    // Primary Wrapper Background map
    form = form.replace(/decoration: BoxDecoration\(color: PrimeCareColors\.radarDark/g, 'decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface');
    
    fs.writeFileSync(formPath, form);
    console.log('Successfully injected dynamic context themes into SDUI payload rendering without const exceptions.');
} catch(e) { console.error('SDUI const patch failed:', e); }

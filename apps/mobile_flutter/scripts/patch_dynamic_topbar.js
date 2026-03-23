const fs = require('fs');

try {
    let topBar = fs.readFileSync('lib/core/widgets/global_top_bar.dart', 'utf8');

    // Replace the title color
    topBar = topBar.replace(
        'color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold',
        'color: Theme.of(context).textTheme.titleLarge?.color ?? Theme.of(context).iconTheme.color, fontWeight: FontWeight.bold'
    );

    // Replace all icon colors logically
    topBar = topBar.replace(
        /icon: PrimeCareIcon\([^,]+,\s*color:\s*PrimeCareColors\.radarDark\),/g,
        (match) => {
            return match.replace(/color:\s*PrimeCareColors\.radarDark/, 'color: Theme.of(context).iconTheme.color');
        }
    );

    fs.writeFileSync('lib/core/widgets/global_top_bar.dart', topBar);
    console.log('Successfully injected dynamic color attributes natively.');
} catch (e) {
    console.error('Failed formatting:', e);
}

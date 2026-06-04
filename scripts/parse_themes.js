const fs = require('fs');
const path = require('path');
const vm = require('vm');

const scratchDir = 'C:/Users/Admin2/.gemini/antigravity-ide/brain/40de769e-b3d6-42f8-a99a-8850fb20d9fe/scratch';
const tsPath = path.join(scratchDir, 'themesConfig.ts');
const presetsJsonPath = path.join(__dirname, 'fuse_presets.json');

try {
  let content = fs.readFileSync(tsPath, 'utf8');

  // Strip TypeScript annotations and imports
  content = content.replace(/import\s+.*?\s+from\s+['"].*?['"];?/g, '');
  
  // Define our mocks for colors
  const mocks = `
const fuseDark = {
	50: '#e5e6e8',
	100: '#bec1c5',
	200: '#92979f',
	300: '#666d78',
	400: '#464e5b',
	500: '#252f3e',
	600: '#212a38',
	700: '#1b2330',
	800: '#161d28',
	900: '#0d121b',
	A100: '#5d8eff',
	A200: '#2a6aff',
	A400: '#004af6',
	A700: '#0042dd',
	contrastDefaultColor: 'light'
};
const skyBlue = {
	50: '#e4fafd',
	100: '#bdf2fa',
	200: '#91e9f7',
	300: '#64e0f3',
	400: '#43daf1',
	500: '#22d3ee',
	600: '#1eceec',
	700: '#19c8e9',
	800: '#14c2e7',
	900: '#0cb7e2',
	A100: '#ffffff',
	A200: '#daf7ff',
	A400: '#a7ecff',
	A700: '#8de6ff',
	contrastDefaultColor: 'dark'
};
const blueGrey = {
	50: '#eceff1',
	100: '#cfd8dc',
	200: '#b0bec5',
	300: '#90a4ae',
	400: '#78909c',
	500: '#607d8b',
	600: '#546e7a',
	700: '#455a64',
	800: '#37474f',
	900: '#263238',
};
  `;

  content = mocks + '\n' + content;

  // Strip export default statement
  content = content.replace(/export\s+default\s+.*?;/g, '');

  // Strip type annotations
  content = content.replace(/:\s*FuseThemesType/g, '');

  // Strip "export" keywords
  content = content.replace(/\bexport\s+/g, '');

  // Add module.exports at the end
  content += '\nmodule.exports = { themesConfig, lightPaletteText, darkPaletteText };\n';

  // Evaluate the code using a simple CommonJS module wrapper
  const m = { exports: {} };
  const context = vm.createContext({
    module: m,
    exports: m.exports,
    console
  });

  vm.runInContext(content, context);

  const presets = m.exports.themesConfig;
  
  // Clean the presets to only contain color palettes we need
  const cleanPresets = {};
  for (const [name, theme] of Object.entries(presets)) {
    const palette = theme.palette;
    if (!palette) continue;

    cleanPresets[name] = {
      mode: palette.mode || 'light',
      primary: {
        main: palette.primary?.main || '#000000',
        light: palette.primary?.light || '#000000',
        dark: palette.primary?.dark || '#000000',
        contrastText: palette.primary?.contrastText || '#FFFFFF',
      },
      secondary: {
        main: palette.secondary?.main || '#000000',
        light: palette.secondary?.light || '#000000',
        dark: palette.secondary?.dark || '#000000',
        contrastText: palette.secondary?.contrastText || '#FFFFFF',
      },
      background: {
        default: palette.background?.default || '#FFFFFF',
        paper: palette.background?.paper || '#FFFFFF',
      },
      text: {
        primary: palette.text?.primary || 'rgb(0,0,0)',
        secondary: palette.text?.secondary || 'rgb(100,100,100)',
        disabled: palette.text?.disabled || 'rgb(150,150,150)',
      },
      divider: palette.divider || '#E5E7EB',
      sidebarBackground: palette.primary?.main || '#0F172A',
      topbarBackground: palette.primary?.main || '#0F172A'
    };
  }

  fs.writeFileSync(presetsJsonPath, JSON.stringify(cleanPresets, null, 2), 'utf8');
  console.log(`Successfully parsed themes to ${presetsJsonPath}`);
} catch (e) {
  console.error('Error parsing themes:', e);
  process.exit(1);
}

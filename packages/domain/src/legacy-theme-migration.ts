import {themePresets, validateThemeLibrary, type PersonalTheme} from './theme_center';
import {defaultAdvancedTheme, foreground, validateAdvancedLibrary, type AdvancedTheme} from './advanced_theme';

/** Prepare an export for explicit review. The validated original remains alongside the preview. */
export function prepareLegacyThemeMigration(raw: unknown) {
  const original = validateThemeLibrary(raw);
  const convert = (legacy: PersonalTheme): AdvancedTheme => {
    const theme = defaultAdvancedTheme();
    const preset = themePresets[legacy.preset as keyof typeof themePresets];
    const colors = legacy.colors;
    const background = colors.background ?? preset.background.default;
    const surface = colors.surface ?? preset.background.paper;
    const text = foreground([background, surface], colors.text ?? theme.regions.main.text);
    const main = { ...theme.regions.main, mode: preset.mode as 'light' | 'dark',
      background, surface, text, primary: colors.primary ?? preset.primary.main,
      secondary: colors.secondary ?? preset.secondary.main,
      border: colors.border ?? theme.regions.main.border };
    theme.name = legacy.name;
    theme.regions.main = main;
    theme.tokens = { ...theme.tokens, fontFamily: legacy.fontFamily,
      fontScale: legacy.fontScale, radius: legacy.radius };
    return theme;
  };
  const candidate = validateAdvancedLibrary({
    version: 2,
    active: original.active ? convert(original.active) : null,
    items: original.items.map(item => ({ id: item.id, theme: convert(item.theme) })),
  });
  return { original, candidate, requiresReview: true,
    unmappedFields: ['preset', 'primaryContainer', 'muted', 'sidebar', 'topbar'] as const };
}

# Complete theme color match

The supplied outer ZIP contains Next.js demo/skeleton and Vite demo/skeleton archives. All four `src/configs/themesConfig.ts` files are identical: SHA-256 `6ec91d4b620e51033b99db9c0c6c2871807f9d0fc5eea8d97ad843001aa757bb`.

Read all 37 palettes (19 light, 18 dark), shared neutral/status definitions, the full fuseDark and skyBlue ramps (28 shades), and settings defaults. The checked-in reference snapshot contains normalized color data, not vendor widgets or a runtime dependency. Runtime uses `scripts/primecare_presets.json`; generators publish the same palette catalog to Dart and TypeScript.

All declared colors are retained: primary/secondary main, light, dark, contrast; paper/default backgrounds; text primary/secondary/disabled; dividers; success/info/warning/error shades; grey ramps; action hover/selected/focus/disabled states, including alpha. Fields omitted by an individual source palette use the shared neutral/status fallback for its mode. Such fallback fields are additional values, not claims that the original palette declared them.

All 22 four-region combinations in `src/configs/themeOptions.ts` are also recorded in `scripts/theme_color_combinations.json`. The central Dart Theme Center applies each complete combination atomically, including mixed light content with dark navigation/footer.

The original PrimeCare light/dark colors remain available as `primecareDay` and `primecareNight`, giving 39 selectable presets. Existing preset names and per-user settings/import/export contracts remain accepted. Users with explicit custom overrides retain those overrides; users who selected a built-in preset now receive its matched source colors.

Dart exposes complete semantic tokens through `AppThemePalette.tokens`, `PrimePaletteTokens`, and `themeColorRamps`. Material controls receive source error, hover, focus, selected and disabled colors. Shared status widgets receive success/warning colors. Web exposes all palette tokens as `--theme-palette-*`, with active status and primary-hover tokens updated. No screen-local color definitions were added.

Existing PrimeCare tenant defaults still select `navyTealPalette`, now with its exact source colors. The default ZIP combination is main `default`, navbar `defaultNavbar`, toolbar/footer `default`. Each region can still select its own palette. A palette's default background color is used for its chrome (as in the source ToolbarLayout1 and theme previews), rather than substituting its primary accent.

Day/night follows `changeThemeMode` from the ZIP: light background/paper `#F7F7F7`/`#FFFFFF`, dark `#121212`/`#1E2125`, and matching text/divider colors. It preserves primary/secondary accents. Named dark presets remain separately selectable; toggling mode is a background/text transformation. The mode alpha divider is retained in source data; the portable override stores its RGB blend over the background. These generated mode combinations are not presented as additional source presets. Automatic schedules/system-mode detection are not added. Text and button foregrounds retain the existing readable-contrast protection, so a low-contrast source foreground can be adjusted at rendering time while the exact source token remains available.

| Preset | Mode | Primary | Secondary | Background | Paper |
| --- | --- | --- | --- | --- | --- |
| default | light | #1F232B | #1565C0 | #F6F7F8 | #FFFFFF |
| defaultDark | dark | #2B2F38 | #3C83D6 | #0F1115 | #1A1D22 |
| defaultNavbar | light | #1F232B | #1565C0 | #E5E7EB | #FFFFFF |
| legacyDefault | light | #0A74DA | #00A4EF | #E8E8E8 | #F4F4F4 |
| legacyDark | dark | #0A74DA | #00A4EF | #121212 | #1E1E1E |
| navyTealPalette | light | #0F3C6E | #00B4A6 | #F6F8FA | #FFFFFF |
| indigoAmberPalette | light | #21255F | #FFB547 | #F7F8FC | #FFFFFF |
| darkBlueSilver | light | #0D47A1 | #B0BEC5 | #F1F5F9 | #FFFFFF |
| darkBlueSilverDark | dark | #0D47A1 | #B0BEC5 | #263238 | #2D3940 |
| slateCrimson | light | #37474F | #D32F2F | #E6E6E6 | #F2F2F2 |
| slateCrimsonDark | dark | #37474F | #D32F2F | #212121 | #2E2E2E |
| emeraldGold | light | #00695C | #FFD740 | #DCF2F2 | #F2FDFA |
| emeraldGoldDark | dark | #00695C | #FFD740 | #004D40 | #00544A |
| indigoCoral | light | #283593 | #FF7043 | #EAEBFB | #F6F7FD |
| indigoCoralDark | dark | #283593 | #FF7043 | #1A237E | #283593 |
| charcoalTeal | light | #094A43 | #009688 | #EDF6FA | #F7FCFC |
| charcoalTealDark | dark | #455A64 | #009688 | #000000 | #102027 |
| skyBlueOrange | light | #64B5F6 | #FAA528 | #F5F5F5 | #FFFFFF |
| skyBlueOrangeDark | dark | #64B5F6 | #FAA528 | #1A1A1A | #333333 |
| softGreenMaroon | light | #81C784 | #D81B60 | #F5F5F5 | #FAFCFA |
| softGreenMaroonDark | dark | #81C784 | #D81B60 | #1A1A1A | #323332 |
| coolGreyPink | light | #DDE6EB | #F06292 | #F5F5F5 | #FFFFFF |
| coolGreyPinkDark | dark | #DDE6EB | #F06292 | #1A1A1A | #292929 |
| legacy | light | #252F3E | #22D3EE | #F6F7F9 | #FFFFFF |
| light1 | light | #006565 | #FFBE2C | #F0F7F7 | #FFFFFF |
| light2 | light | #1B9E85 | #FF6231 | #F2F8F1 | #FFFFFF |
| light3 | light | #6B2C57 | #36336A | #FAFAFE | #FFFFFF |
| light4 | light | #404B57 | #354968 | #F5F4F6 | #FFFFFF |
| light5 | light | #3A3A3A | #CBCAC3 | #FAF8F2 | #EFEEE7 |
| dark1 | dark | #323338 | #129B7F | #1E1D1E | #262526 |
| dark2 | dark | #4B4F5A | #E6DED5 | #2A2D35 | #31343E |
| dark3 | dark | #354968 | #D55847 | #1B2A3F | #23354E |
| dark4 | dark | #5A4E93 | #00BC77 | #180F3D | #22184B |
| dark5 | dark | #56789D | #796CC4 | #232931 | #465261 |
| dark6 | dark | #252949 | #5079FC | #202441 | #2D3159 |
| dark7 | dark | #204657 | #00BD3E | #15171E | #1C1E27 |
| greyDark | dark | #1B2330 | #22D3EE | #263238 | #455A64 |

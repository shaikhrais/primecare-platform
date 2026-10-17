# Growth dashboard design and asset notes

The user requested a brighter UI with more icons and images. This changes the default presentation of the existing growth dashboard. It does not create marketing results, clinical records or advertising campaigns.

## Design

- White sidebar and surfaces, soft mint cards, teal actions and readable dark text.
- Line icons alongside navigation, section headings and summary metrics.
- In-page section navigation that retains unfinished form values.
- Care illustration in the page header and a marketing illustration beside campaign planning.
- Governed `growth_daylight` colors and component mappings; saved personal themes take precedence.

## Project asset paths

- `websites/typescript/public/assets/growth/home-care.png`
- `websites/typescript/public/assets/growth/marketing-team.png`
- Vector icon definitions: `docs/marketing/growth-seed.json`, exported through governance into the shared registry.
- Asset consumer: `websites/typescript/src/growth/visuals.ts`.

Raster illustrations were created with the built-in image-generation tool and copied into the project. They show fictional illustrative characters. No CLI/API fallback was used. Vector icons were implemented directly as SVG.

## Final generation prompts

**Home care:** Use case: illustration-story. Asset type: decorative image for a light, modern home-care business dashboard. Create a polished editorial illustration showing a friendly adult care professional in teal scrubs sitting with an older adult and a family member in a bright welcoming living room, calmly planning everyday home support. Warm natural light, airy white and pale mint background, restrained teal, sky blue and soft peach accents, clean sophisticated rounded shapes, gentle human expressions, inclusive adult characters. Wide landscape composition with generous breathing room; no text, no logos, no charts, no medical devices, no badges, no watermark. This is an illustrative scene, not a photograph of actual staff or clients.

**Marketing:** Use case: illustration-story. Asset type: decorative editorial image for the marketing section of a light home-care business dashboard. A friendly telephone outreach professional with a headset and a digital marketing colleague working together at a tidy bright desk with a laptop, a simple notebook and a small plant. Polished warm editorial illustration, airy cream-white backdrop, teal, sky-blue and soft peach accents, understated rounded shapes, welcoming natural light. Wide landscape composition. No text, no logos, no brand icons, no statistics, no readable screen content, no watermark. These are illustrative characters, not actual employees.

## Verification

Images load from the built website rather than a third-party image host. Growth browser cases exercise EN/FR/ES, mobile–4K layouts, image loading, permissions and retained drafts. Existing layout and Theme Center suites verify saved preferences, live changes, account isolation, 37 palettes and import/export. The refreshed default/restore behavior is tested separately. Screenshots contain synthetic fixture records. Standard CI and production deployment remain pending.

2026-10-14: administrator consoles reuse the governed Growth Daylight tokens; tenant administrators link to their own growth dashboard. Caller screenshot refreshed from the current assigned-scope fixture. Reporting, business verification/finance and central/tenant admin screenshots are in images/. Section-only business capture temporarily removes the sticky topbar to avoid screenshot overlap; screenshots remain synthetic fixture evidence.

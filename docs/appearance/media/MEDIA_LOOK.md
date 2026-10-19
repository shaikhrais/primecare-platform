# Shared media look

The visual system uses a common `BaseMediaLook` and an inherited `EntryMediaLook`. Sign-in, shared authenticated shells and growth illustrations/icons use this base. Asset definitions, text, placement bindings and media tokens are registered in governance before the browser catalog is exported. No media component connects to a database or changes authentication or approval rules.

`DashboardMediaLook` now extends the same base for operational screens. Central/platform/tenant administration inherit section icons and compact page headings. Look Manager inherits a labelled three-stage process, status badges, an illustrated empty state and read-only criterion meters beside the screenshot. Scores and approval status are supplied by the API; the presentation does not calculate a pass or grant approval. Meter fills use the theme's primary color rather than implying an independent pass/fail threshold.

## Research and placement decisions

| Media | Where and why | Implemented treatment |
|---|---|---|
| Care illustration | Entry pages: orient users to the service | Existing repository care illustration, beside the form on desktop and below the form on mobile |
| Team illustration | Growth marketing section: identify team collaboration | Existing team illustration, loaded lazily |
| SVG icons | Brand, input fields and growth navigation: recognition alongside text | Shared current-color line icons; decorative icons hidden from assistive technology |
| Workflow visuals | Growth stages: understand progress | Existing text, counts and progress bars retained; no photograph behind operational data |
| Video/audio | Training where a demonstration has instructional value | Not added: no approved recording, captions or transcript supplied; no autoplay or empty player |

NHS guidance recommends images only for a real user need and warns that decoration can frustrate transactional journeys. Ontario recommends larger imagery on entry pages, narrower imagery deeper in the hierarchy, appropriate licensing, compression, and SVG for icons. W3C distinguishes informative, functional and decorative images. These findings inform the decisions above; they do not certify that the design is optimal or accessible.

Sources consulted 2026-10-14:

- [NHS images](https://service-manual.nhs.uk/design-system/components/images)
- [Ontario images and photography](https://designsystem.ontario.ca/components/detail/images.html)
- [W3C image alternatives](https://www.w3.org/WAI/tutorials/images/)
- [W3C animation from interactions](https://www.w3.org/WAI/WCAG21/Understanding/animation-from-interactions)

## Delivery and accessibility

Care and team assets are existing illustrations, not photographs or endorsements by real staff or clients. WebP variants at 640 and 1280 pixels retain PNG fallbacks. The care variants are about 31 KB and 74 KB; team variants are about 24 KB and 56 KB. Explicit dimensions reserve image space. Entry imagery loads with high priority; secondary marketing imagery is lazy. Decorative entry imagery has empty alt text; growth keeps its existing translated descriptions. No words are embedded in a generated image.

The sign-in form appears first on small screens, with equal margins, visible labels, keyboard focus and a minimum control height from the governed token. Brand and field icons inherit theme colors. Reduced-motion and forced-colors styles are included. Broken imagery leaves the form usable. This does not replace a full accessibility audit.

## Validation and limits

`test-media-look-browser.mjs` runs the built website, not a static design mockup. It checks English, French and Spanish at 390/1440 pixels, English at 320/3840, and the sign-in page in all nine portal builds. It verifies loaded WebP assets, equal mobile margins, no horizontal overflow, email → password → submit keyboard order, localized entry copy, absence of page JavaScript errors and retained controls when imagery is removed.

The local test server chooses the portal with a test-only header and sets the HTML document language for localized cases. External API requests are blocked in this visual test. No login submission or production authentication is claimed. Keyboard checks use a test email address, cleared before capture. Shared growth and Look Manager regressions additionally exercise API-backed workflows using PGlite and synthetic identities/provider responses.

Browser captures are in this folder. The implementation has been reviewed locally; human visual acceptance, native Flutter media widgets, device testing and deployment remain pending. This change does not record AI-provider or human approval of production pages.

Local results: 17 media browser checks, 22 auth-client/growth checks, 3 Look Manager policy/API suites (including six browser flows), and 34 growth browser workflows passed. TypeScript checking and all nine website builds passed. These were local runs; PostgreSQL CI and native device tests were not run.

Operational extension validation: six central/tenant administrator workflows passed in EN/FR/ES at 320 and 1440 pixels, covering partner activation, tenant scope and protected account controls. Look Manager's three local suites passed, including six browser approval flows, all eight score values and the transition from `ready_human` to `approved` only after the inspection confirmation and reason. Entry-page regression checks also passed. The updated operational screenshots use synthetic identities, evidence and a mock vision provider; they are not production approval records.

The review preview now includes localized loading/error/ready text and an explicit retry button. Human controls remain disabled until the image has decoded and matches the API's digest. Form drafts survive language changes and successful refreshes in page memory. The image-error capture demonstrates this failure state with synthetic evidence; no production AI or human approval is represented.

# Schema-Driven UI (SDUI) Form Framework
*The ultimate architecture for scaling clinical and operational forms without writing UI code.*

## The Problem
Currently, if the company determines it needs a new "COVID Screening Form" or a "Palliative Patient Intake Profile", a Flutter engineer has to open the codebase, physically type out 200 lines of `TextField` and `Dropdown` widgets, recompile the app, wait 12 minutes, and push it to the App Store.
This is **too slow** for a scalable franchise model.

## The Solution: JSON-to-Form Engine
We will construct a master **SDUI Framework** (`PrimeCareDynamicFormBuilder.dart`).
Instead of creating 50 different physical Flutter screens for 50 forms, we will build ONE master screen.

When you (as the Superuser) want a new form, you don't write Dart code. You literally just configure a JSON payload in Cloudflare:

```json
{
  "formId": "onboarding_101",
  "title": "Caregiver Clinical Registration",
  "fields": [
    { "type": "header", "label": "Personal Information" },
    { "key": "firstName", "type": "text", "label": "Legal First Name", "required": true },
    { "key": "hasVehicle", "type": "boolean", "label": "Do you own a physical dispatch vehicle?" },
    { "key": "preferredRegion", "type": "dropdown", "options": ["North York", "Etobicoke", "Downtown"] }
  ]
}
```

### How the Framework processes it:
1. The Flutter App downloads this JSON from the Cloudflare API `/v1/sdui/forms/{id}`.
2. The `PrimeCareDynamicFormBuilder` reads the JSON array and loop-generates the physical screen instantly.
3. When the user taps "Submit", the Framework aggregates all the physical inputs into a `Map<String, dynamic>` and POSTs it directly into the Prisma backend.

### Benefits to the Founder:
- **Zero Frontend Code:** You can deploy 10,000 different forms across your franchises globally strictly by saving JSON configurations on your Cloudflare home.
- **Instant Deployments:** Updating a form's physical layout does not require an App Store update. It alters instantly on the user's phone on the next refresh.
- **Codebase Compression:** We can replace 30 distinct Flutter files with 1 master dynamic file.

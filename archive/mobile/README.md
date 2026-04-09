# Mobile Applications

> **Status:** Sprint 2 — Flutter/Dart cross-platform app scaffolded.

## PrimeCare PSW — `mobile/apps/PrimeCarePsw/`

A Flutter/Dart cross-platform app for **Personal Support Workers** targeting:
- 📱 **iOS** (iPhone/iPad)
- 🤖 **Android** (phone/tablet)
- 🪟 **Windows** desktop
- 🍎 **macOS** desktop
- 🌐 **Web** browser

### Architecture

| Layer | Technology | Purpose |
|---|---|---|
| **State** | Riverpod | Global state, auth, providers |
| **Routing** | go_router | Auth-aware, deep linking |
| **HTTP** | Dio | API client with interceptors |
| **Storage** | flutter_secure_storage | Token + session persistence |
| **Location** | geolocator | GPS for EVV compliance |
| **Auth** | local_auth | Biometric (Face ID / Fingerprint) |
| **Push** | firebase_messaging | Real-time alerts |
| **Theme** | Material 3 | Light/dark matching web-admin |

### Screens

1. **Login** — Email/password + biometric
2. **Schedule** — Today's shifts with pull-to-refresh
3. **Visit Check-in/out** — GPS-verified EVV
4. **SOS** — Incident reporting (6 types + GPS)
5. **Profile** — Account, training, timesheets

### Getting Started

```bash
cd mobile/apps/PrimeCarePsw
flutter pub get
flutter run                  # default platform
flutter run -d windows       # Windows desktop
flutter run -d macos          # macOS desktop
flutter run -d chrome         # Web browser
```

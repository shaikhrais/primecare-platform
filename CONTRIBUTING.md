# Contributing to PrimeCare

Welcome to the team! This document will guide you through the architectural patterns and CI/CD rules required to contribute to the PrimeCare monorepo.

Because this ecosystem is massive (11 apps, 17 microservices), we strictly enforce the following patterns. **Any PR that breaks these patterns will be automatically rejected by our GitHub Actions pipeline.**

---

## 1. Frontend Architecture (Flutter & Riverpod)

Every single screen in the 11 Flutter apps MUST be split into a View and a Controller.

### Creating a New Screen
1. Create your UI file (e.g., `feature_screen.dart`). It **MUST** extend `ConsumerWidget` or `ConsumerStatefulWidget`.
2. Create your logic file (e.g., `feature_screen_controller.dart`). It **MUST** use `@riverpod` code generation.
3. Your screen MUST contain a `Scaffold` at the root.

### Networking
Do **not** use `Future.delayed` to mock data. Always use the `dio` package to query the backend:
```dart
final dio = Dio();
final response = await dio.get('http://localhost:3000/api/your-feature');
```

---

## 2. Backend Architecture (Dart Shelf)

Our backend does not use Node.js. It uses **Full-Stack Dart** via `shelf_router`.

### Adding a New Route
1. Locate the correct microservice in `/services/` (e.g., `auth_api` or `billing_api`).
2. Open `lib/routes.dart`.
3. Add your `router.get` or `router.post` mapping.
4. **Always** return a standardized JSON response:
```dart
return Response.ok(jsonEncode({
  'status': 'success',
  'message': 'Operation complete',
  'data': results
}), headers: {'Content-Type': 'application/json'});
```

---

## 3. Database Architecture (Prisma)

We use PostgreSQL managed by Prisma. 

### Modifying the Database
1. Navigate to `/packages/database/prisma/schema/`.
2. Find the correct modular schema file (e.g., `04_clinical.prisma` or `14_corporate_portal.prisma`).
3. Add your new `model`.
4. Run the format and push commands to sync your local database:
```bash
npm run format
npm run db-sync
npm run generate
```

---

## 4. The CI/CD Pipeline

Our GitHub Actions pipeline protects the `main` branch. Before pushing code, ensure you manually verify the following locally to avoid breaking the build:

1. **Spider Validation:** Run `node scripts/frontend_spider.js`. This will instantly scan your new Flutter screens to ensure they contain `ConsumerWidget` and `Scaffold`.
2. **Backend Analysis:** Run `dart analyze services` from the root directory to ensure your Shelf routing logic compiles cleanly.
3. **Database Integrity:** If you changed Prisma files, ensure `npm run generate` runs without throwing relational errors.

Happy Coding!

enum Environment { dev, demo, staging, prod }

class EnvConfig {
  static Environment environment = Environment.dev;

  static String get apiBaseUrl {
    switch (environment) {
      case Environment.dev:
        return 'https://dev-api.primecare.local/v1';
      case Environment.demo:
        return 'https://demo-api.primecare.local/v1';
      case Environment.staging:
        return 'https://staging-api.primecare.local/v1';
      case Environment.prod:
        return 'https://api.primecare.io/v1';
    }
  }

  static bool get showDebugBanner => environment != Environment.prod;
}

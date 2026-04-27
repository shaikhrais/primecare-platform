// Layer: 01_INFRASTRUCTURE
import 'dart:convert';

/// A robust utility for decoding JSON Web Tokens (JWT) locally without relying on
/// heavy cryptographic libraries. It extracts claims and verifies expirations.
class JwtDecoder {
  /// Parses the JWT standard Base64Url payload and returns it as a Map.
  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return {};
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);

    if (payloadMap is! Map<String, dynamic>) {
      return {};
    }

    return payloadMap;
  }

  /// Evaluates whether the given token has expired based on its 'exp' claim.
  static bool isTokenExpired(String token) {
    try {
      final payload = parseJwt(token);
      if (payload.containsKey('exp')) {
        final exp = payload['exp'];
        // Handle cases where exp might be parsed as double or int
        final int expInt;
        if (exp is int) {
          expInt = exp;
        } else if (exp is double) {
          expInt = exp.toInt();
        } else if (exp is String) {
          expInt = int.tryParse(exp) ?? 0;
        } else {
          expInt = 0;
        }

        if (expInt == 0) return true; // Fail safe

        final expirationDate = DateTime.fromMillisecondsSinceEpoch(
          expInt * 1000,
          isUtc: true,
        );

        // Return true if the current time in UTC is after the expiration date
        return DateTime.now().toUtc().isAfter(expirationDate);
      }
      // If there's no expiration claim, we assume it's valid (or handle per specific security requirements)
      return false;
    } catch (e) {
      // If we can't parse or decode it properly, inherently treat it as an expired/invalid token
      return true;
    }
  }

  /// Attempts to extract the active role from common backend structures.
  /// Checks root `role`, root `activeRole`, `user.roles`, and `app_metadata.role`.
  static String? extractRole(String token) {
    try {
      final payload = parseJwt(token);

      // Direct root parameters
      if (payload['role'] != null && payload['role'].toString().isNotEmpty) {
        return payload['role'].toString();
      }
      if (payload['activeRole'] != null &&
          payload['activeRole'].toString().isNotEmpty) {
        return payload['activeRole'].toString();
      }

      // Check standard backend objects
      if (payload['user'] != null && payload['user'] is Map) {
        final Map<String, dynamic> userObj =
            payload['user'] as Map<String, dynamic>;
        if (userObj['roles'] != null &&
            userObj['roles'] is List &&
            (userObj['roles'] as List).isNotEmpty) {
          final roles = userObj['roles'] as List;
          return roles[0].toString();
        }
      }

      // Supabase / identity provider standard metadata formats
      if (payload['app_metadata'] != null && payload['app_metadata'] is Map) {
        final Map<String, dynamic> appMeta =
            payload['app_metadata'] as Map<String, dynamic>;
        if (appMeta['role'] != null) {
          return appMeta['role'].toString();
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Attempts to extract a tenant identifier safely.
  static String? extractTenantId(String token) {
    try {
      final payload = parseJwt(token);
      if (payload['tenantId'] != null) {
        return payload['tenantId'].toString();
      }
      if (payload['user'] != null && payload['user'] is Map) {
        final userObj = payload['user'] as Map<String, dynamic>;
        if (userObj['tenantId'] != null) {
          return userObj['tenantId'].toString();
        }
      }
      if (payload['app_metadata'] != null && payload['app_metadata'] is Map) {
        final appMeta = payload['app_metadata'] as Map<String, dynamic>;
        if (appMeta['tenantId'] != null) {
          return appMeta['tenantId'].toString();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        return '';
    }
    return utf8.decode(base64Url.decode(output));
  }
}

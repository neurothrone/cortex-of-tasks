import 'package:flutter/foundation.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConstants {
  const EnvironmentConstants._();

  static late final String appwriteEndpoint;
  static late final bool appwriteSelfSigned;
  static late final String appwriteProjectId;
  static late final String appwriteDatabaseId;

  static void init() {
    appwriteEndpoint = _loadEnvFromKey(key: "APPWRITE_ENDPOINT");
    appwriteSelfSigned = _loadEnvFromKey(key: "APPWRITE_SELF_SIGNED") == "true";
    appwriteProjectId = _loadEnvFromKey(key: "APPWRITE_PROJECT_ID");
    appwriteDatabaseId = _loadEnvFromKey(key: "APPWRITE_DATABASE_ID");
  }

  static String _loadEnvFromKey({required String key}) {
    final String? environmentVariable = dotenv.env[key];

    if (environmentVariable == null) {
      throw FlutterError("❌ -> Environment Key missing. Key: $key");
    }

    return environmentVariable;
  }
}

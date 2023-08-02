import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';

final appwriteClientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint(EnvironmentConstants.appwriteEndpoint)
      .setProject(EnvironmentConstants.appwriteProjectId)
      // For self signed certificates, only use for development
      .setSelfSigned(
        status: EnvironmentConstants.appwriteSelfSigned,
      );
});

final appwriteAccountProvider = Provider<Account>((ref) {
  final Client client = ref.watch(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabasesProvider = Provider<Databases>((ref) {
  final Client client = ref.watch(appwriteClientProvider);
  return Databases(client);
});

final appwriteRealtimeProvider = Provider<Realtime>((ref) {
  final Client client = ref.watch(appwriteClientProvider);
  return Realtime(client);
});

final appwriteStorageProvider = Provider<Storage>((ref) {
  final Client client = ref.watch(appwriteClientProvider);
  return Storage(client);
});

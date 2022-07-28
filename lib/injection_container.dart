import 'package:get_it/get_it.dart';
import 'package:team_dart_knights_sih/core/platform_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/role_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => PlatformChecker());
  getIt.registerLazySingleton(() => RoleChecker());
  getIt.registerLazySingleton<AWSApiClient>(() => AWSApiClientImpl());
}

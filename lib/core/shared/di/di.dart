import 'package:acces_make_mobile/core/shared/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', preferRelativeImports: true, 
  asExtension: false,
)
void configureDependencies() {
  $initGetIt(getIt);
}
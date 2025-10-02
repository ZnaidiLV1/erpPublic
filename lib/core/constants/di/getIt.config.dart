// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:biboo_pro/core/services/expense_service.dart' as _i881;
import 'package:biboo_pro/core/services/hive_repository.dart' as _i748;
import 'package:biboo_pro/core/services/revenue_service.dart' as _i453;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i748.HiveRepository>(() => _i748.HiveRepository());
    gh.lazySingleton<_i881.ExpenseService>(() => _i881.ExpenseService());
    gh.lazySingleton<_i453.RevenueService>(() => _i453.RevenueService());
    return this;
  }
}

import 'package:get_it/get_it.dart';
import '../../features/portfolio/data/datasources/portfolio_local_datasource.dart';
import '../../features/portfolio/data/repositories/portfolio_repository_impl.dart';
import '../../features/portfolio/domain/repositories/portfolio_repository.dart';
import '../../features/portfolio/domain/usecases/get_projects.dart';
import '../../features/portfolio/presentation/bloc/portfolio_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Portfolio
  // Bloc
  sl.registerFactory(() => PortfolioBloc(getProjects: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetProjects(sl()));

  // Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<PortfolioLocalDataSource>(
    () => PortfolioLocalDataSourceImpl(),
  );
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/project.dart';
import '../../domain/usecases/get_projects.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetProjects getProjects;

  PortfolioBloc({required this.getProjects}) : super(PortfolioInitial()) {
    on<GetPortfolioData>((event, emit) async {
      emit(PortfolioLoading());
      try {
        final projects = await getProjects();
        emit(PortfolioLoaded(projects: projects));
      } catch (e) {
        emit(const PortfolioError("Failed to load portfolio data"));
      }
    });
  }
}

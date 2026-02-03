import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Theme State
enum AppThemeMode { dark, light }

class ThemeState extends Equatable {
  final AppThemeMode mode;

  const ThemeState({this.mode = AppThemeMode.dark});

  @override
  List<Object?> get props => [mode];

  ThemeState copyWith({AppThemeMode? mode}) {
    return ThemeState(mode: mode ?? this.mode);
  }
}

// Theme Cubit
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  void toggleTheme() {
    emit(
      ThemeState(
        mode:
            state.mode == AppThemeMode.dark
                ? AppThemeMode.light
                : AppThemeMode.dark,
      ),
    );
  }

  void setDarkMode() {
    emit(const ThemeState(mode: AppThemeMode.dark));
  }

  void setLightMode() {
    emit(const ThemeState(mode: AppThemeMode.light));
  }
}

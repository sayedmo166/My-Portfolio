import '../../domain/entities/project.dart';
import '../../domain/entities/social_link.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_datasource.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  PortfolioRepositoryImpl(this.localDataSource);

  @override
  Future<List<Project>> getProjects() async {
    return await localDataSource.getProjects();
  }

  @override
  Future<List<SocialLink>> getSocialLinks() async {
    // Return static list for now
    return const [
      SocialLink(
        platform: "GitHub",
        url: "https://github.com",
        iconAsset: "assets/icons/github.svg",
      ),
      SocialLink(
        platform: "LinkedIn",
        url: "https://linkedin.com",
        iconAsset: "assets/icons/linkedin.svg",
      ),
    ];
  }
}

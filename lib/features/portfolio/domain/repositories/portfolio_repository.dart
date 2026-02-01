import '../entities/project.dart';
import '../entities/social_link.dart';

abstract class PortfolioRepository {
  Future<List<Project>> getProjects();
  Future<List<SocialLink>> getSocialLinks();
}

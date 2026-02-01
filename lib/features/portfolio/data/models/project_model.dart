import '../../domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.title,
    required super.description,
    super.imageUrl,
    super.googlePlayLink,
    super.appStoreLink,
    super.webLink,
    required super.techStack,
  });

  // Create from JSON if needed later
}

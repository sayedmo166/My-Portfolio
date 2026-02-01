import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String title;
  final String description;
  final String? imageUrl;
  final String? googlePlayLink;
  final String? appStoreLink;
  final String? webLink;
  final List<String> techStack;

  const Project({
    required this.title,
    required this.description,
    this.imageUrl,
    this.googlePlayLink,
    this.appStoreLink,
    this.webLink,
    required this.techStack,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    imageUrl,
    googlePlayLink,
    appStoreLink,
    webLink,
    techStack,
  ];
}

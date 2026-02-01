import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  Future<void> _launchUrl(String? url) async {
    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return HoverableCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image / Header
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                image:
                    project.imageUrl != null
                        ? DecorationImage(
                          image: AssetImage(project.imageUrl!),
                          fit: BoxFit.cover,
                        )
                        : null,
              ),
              child:
                  project.imageUrl == null
                      ? const Center(
                        child: Icon(
                          Icons.code,
                          size: 50,
                          color: AppColors.secondaryText,
                        ),
                      )
                      : null,
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Tech Stack
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children:
                        project.techStack
                            .map(
                              (tech) => Chip(
                                label: Text(
                                  tech,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                backgroundColor: AppColors.primaryBackground,
                                padding: EdgeInsets.zero,
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: 10),
                  // Links
                  Wrap(
                    spacing: 10,
                    children: [
                      if (project.googlePlayLink != null)
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.googlePlay,
                            color: AppColors.primaryText,
                          ),
                          onPressed: () => _launchUrl(project.googlePlayLink),
                          tooltip: 'Google Play',
                        ),
                      if (project.appStoreLink != null)
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.appStore,
                            color: AppColors.primaryText,
                          ),
                          onPressed: () => _launchUrl(project.appStoreLink),
                          tooltip: 'App Store',
                        ),
                      if (project.webLink != null)
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.globe,
                            color: AppColors.primaryText,
                          ),
                          onPressed: () => _launchUrl(project.webLink),
                          tooltip: 'Website',
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HoverableCard extends StatefulWidget {
  final Widget child;
  const HoverableCard({super.key, required this.child});

  @override
  State<HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<HoverableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0, _isHovered ? -10 : 0),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: AppColors.primaryAccent.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                  : [],
        ),
        child: widget.child,
      ),
    );
  }
}

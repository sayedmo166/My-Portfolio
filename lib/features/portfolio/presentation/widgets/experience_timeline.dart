import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key});

  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      title: "Flutter Developer",
      company: "Freelance",
      period: "2024 - Present",
      description:
          "Developing full-featured mobile apps for clients with focus on Clean Architecture and State Management",
      skills: ["Flutter", "Bloc", "Firebase", "REST APIs"],
    ),
    ExperienceItem(
      title: "Mobile App Projects",
      company: "Production Apps",
      period: "2024",
      description:
          "Published apps on Google Play & App Store including: Marakiib, ALSAFA GLASS, Al-Kashkah, Dubai Hotel",
      skills: ["Google Play", "App Store", "CI/CD", "Flavors"],
    ),
    ExperienceItem(
      title: "Flutter Learning Journey",
      company: "Self Development",
      period: "2023 - 2024",
      description:
          "Deep learning of Flutter & Dart focusing on Advanced Topics and Real-world Projects",
      skills: ["Dart", "Flutter", "State Management", "Clean Code"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive padding based on screen width
        final isNarrow = constraints.maxWidth < 600;
        final horizontalPadding = isNarrow ? 16.0 : 40.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 60,
          ),
          color: AppColors.secondaryBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Experience",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isNarrow ? 28 : null,
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
              const SizedBox(height: 10),
              Text(
                "My journey in app development",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 40),
              ...experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final experience = entry.value;
                final isLast = index == experiences.length - 1;

                return _TimelineItem(
                  experience: experience,
                  isLast: isLast,
                  index: index,
                  isNarrow: isNarrow,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class ExperienceItem {
  final String title;
  final String company;
  final String period;
  final String description;
  final List<String> skills;

  const ExperienceItem({
    required this.title,
    required this.company,
    required this.period,
    required this.description,
    required this.skills,
  });
}

class _TimelineItem extends StatelessWidget {
  final ExperienceItem experience;
  final bool isLast;
  final int index;
  final bool isNarrow;

  const _TimelineItem({
    required this.experience,
    required this.isLast,
    required this.index,
    required this.isNarrow,
  });

  @override
  Widget build(BuildContext context) {
    // For narrow screens, use a simplified layout without the timeline line
    if (isNarrow) {
      return _buildMobileCard(context);
    }
    return _buildDesktopCard(context);
  }

  Widget _buildMobileCard(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(bottom: isLast ? 0 : 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryAccent.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryAccent.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Period badge at top
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  experience.period,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                experience.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              // Company
              Text(
                experience.company,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              // Description
              Text(
                experience.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryText,
                  height: 1.5,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              // Skills
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children:
                    experience.skills.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primaryAccent.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            color: AppColors.primaryAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        )
        .animate(delay: (150 * index).ms)
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildDesktopCard(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line and dot
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryAccent.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryAccent,
                            AppColors.secondaryAccent.withOpacity(0.3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Container(
                  margin: EdgeInsets.only(bottom: isLast ? 0 : 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryAccent.withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  experience.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  experience.company,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primaryAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              experience.period,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        experience.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryText,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            experience.skills.map((skill) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryAccent.withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primaryAccent.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  skill,
                                  style: TextStyle(
                                    color: AppColors.primaryAccent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                )
                .animate(delay: (200 * index).ms)
                .fadeIn(duration: 500.ms)
                .slideX(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
          ),
        ],
      ),
    );
  }
}

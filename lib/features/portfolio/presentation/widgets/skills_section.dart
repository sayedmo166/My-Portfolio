import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../core/theme/app_colors.dart';

class SkillCategory {
  final String title;
  final List<String> skills;

  SkillCategory({required this.title, required this.skills});
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static final List<SkillCategory> skillsData = [
    SkillCategory(title: "Programming Languages", skills: ["Dart"]),
    SkillCategory(
      title: "Mobile Development",
      skills: ["Flutter", "Responsive UI", "Localization", "APIs"],
    ),
    SkillCategory(
      title: "State Management",
      skills: ["Bloc", "Cubit", "Provider"],
    ),
    SkillCategory(
      title: "Architecture Patterns",
      skills: ["MVVM", "Clean Architecture"],
    ),
    SkillCategory(
      title: "Networking",
      skills: ["Dio", "Http", "Error Handling", "RESTful Services"],
    ),
    SkillCategory(
      title: "Tools & Backend",
      skills: [
        "Firebase (Auth, Firestore, Storage)",
        "Git",
        "GitHub",
        "Google Play Store",
        "Apple App Store",
        "CI/CD",
        "Flavors",
      ],
    ),
    SkillCategory(
      title: "Advanced Integrations",
      skills: [
        "Google Maps",
        "Voice & Video Calls (Agora/WebRTC)",
        "Payment (Stripe, PayPal, Vodafone Cash)",
        "Real-time (Pusher)",
        "AI Model Integration",
      ],
    ),
    SkillCategory(
      title: "Additional Features",
      skills: [
        "Notifications (Local & FCM)",
        "Data Caching",
        "Code Optimization",
        "Lazy Loading",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      width: double.infinity,
      color: AppColors.secondaryBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills & Expertise",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
          const SizedBox(height: 10),
          Text(
            "My technical proficiency and tools I use to build world-class apps.",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[400]),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: 50),
          ScreenTypeLayout.builder(
            mobile: (ctx) => _buildSkillsList(crossAxisCount: 1),
            tablet: (ctx) => _buildSkillsList(crossAxisCount: 2),
            desktop: (ctx) => _buildSkillsList(crossAxisCount: 3),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList({required int crossAxisCount}) {
    // Distribute items into columns for Masonry layout
    List<List<SkillCategory>> columns = List.generate(
      crossAxisCount,
      (_) => [],
    );
    for (int i = 0; i < skillsData.length; i++) {
      columns[i % crossAxisCount].add(skillsData[i]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < crossAxisCount; i++) ...[
          if (i > 0) const SizedBox(width: 20),
          Expanded(
            child: Column(
              children:
                  columns[i].map((category) {
                    // Calculate original index for animation delay
                    int index = skillsData.indexOf(category);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _SkillCategoryCard(category: category)
                          .animate(delay: (100 * index).ms)
                          .fadeIn(duration: 500.ms)
                          .slideY(
                            begin: 0.2,
                            end: 0,
                            curve: Curves.easeOutQuad,
                          ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;

  const _SkillCategoryCard({required this.category});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeOut,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                _isHovered
                    ? AppColors.primaryAccent.withOpacity(0.5)
                    : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  _isHovered
                      ? AppColors.primaryAccent.withOpacity(0.15)
                      : Colors.black.withOpacity(0.05),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Important: fit content
          children: [
            Text(
              widget.category.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color:
                    _isHovered
                        ? AppColors.primaryAccent
                        : AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              // Removed Expanded, added Wrap directly
              spacing: 8,
              runSpacing: 8,
              children:
                  widget.category.skills
                      .map(
                        (skill) =>
                            _SkillChip(label: skill, parentHovered: _isHovered),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final bool parentHovered;

  const _SkillChip({required this.label, required this.parentHovered});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 300.ms,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color:
            parentHovered
                ? AppColors.primaryAccent.withOpacity(0.1)
                : AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              parentHovered
                  ? AppColors.primaryAccent
                  : AppColors.primaryAccent.withOpacity(0.1),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color:
              parentHovered ? AppColors.primaryAccent : AppColors.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

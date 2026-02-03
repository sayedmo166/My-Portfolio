import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;

  SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static final List<SkillCategory> skillsData = [
    SkillCategory(
      title: "Programming Languages",
      icon: Icons.code,
      skills: ["Dart", "JavaScript"],
    ),
    SkillCategory(
      title: "Mobile Development",
      icon: Icons.phone_android,
      skills: ["Flutter", "Responsive UI", "Localization", "APIs Integration"],
    ),
    SkillCategory(
      title: "State Management",
      icon: Icons.sync_alt,
      skills: ["Bloc", "Cubit", "Provider"],
    ),
    SkillCategory(
      title: "Architecture Patterns",
      icon: Icons.architecture,
      skills: ["MVVM", "Clean Architecture", "Repository Pattern"],
    ),
    SkillCategory(
      title: "Networking",
      icon: Icons.cloud,
      skills: [
        "Dio",
        "Http",
        "Error Handling",
        "Token Refresh",
        "RESTful Services",
      ],
    ),
    SkillCategory(
      title: "Tools & Backend",
      icon: Icons.build,
      skills: [
        "Firebase (Auth, Firestore, FCM, Storage)",
        "Git & GitHub",
        "Google Play Store",
        "Apple App Store",
        "CI/CD",
        "Flavors",
      ],
    ),
    SkillCategory(
      title: "Advanced Integrations",
      icon: Icons.extension,
      skills: [
        "Google Maps",
        "Voice & Video Calls (Agora/WebRTC)",
        "Payment (Stripe, PayPal, Vodafone Cash)",
        "Real-time (Pusher/WebSocket)",
        "AI Model Integration",
      ],
    ),
    SkillCategory(
      title: "Additional Features",
      icon: Icons.star,
      skills: [
        "Push Notifications (FCM)",
        "Local Notifications",
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
            "Technologies I use to build world-class applications",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[400]),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              // Fix for Desktop Mode on mobile
              final isNarrow = constraints.maxWidth < 600;
              final isMedium = constraints.maxWidth < 900;
              final crossAxisCount = isNarrow ? 1 : (isMedium ? 2 : 3);

              return _buildSkillsList(crossAxisCount: crossAxisCount);
            },
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: _isHovered ? AppColors.primaryGradient : null,
                    color: _isHovered ? null : AppColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.category.icon,
                    size: 22,
                    color: _isHovered ? Colors.white : AppColors.primaryAccent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color:
                          _isHovered
                              ? AppColors.primaryAccent
                              : AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
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
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color:
              parentHovered ? AppColors.primaryAccent : AppColors.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

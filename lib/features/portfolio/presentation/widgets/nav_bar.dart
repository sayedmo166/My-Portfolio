import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onSkillsClick;
  final VoidCallback onProjectsClick;
  final VoidCallback onContactClick;

  const NavBar({
    super.key,
    required this.onHomeClick,
    required this.onSkillsClick,
    required this.onProjectsClick,
    required this.onContactClick,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile:
          (ctx) => _NavBarMobile(
            onHomeClick: onHomeClick,
            onSkillsClick: onSkillsClick,
            onProjectsClick: onProjectsClick,
            onContactClick: onContactClick,
          ),
      desktop:
          (ctx) => _NavBarDesktop(
            onHomeClick: onHomeClick,
            onSkillsClick: onSkillsClick,
            onProjectsClick: onProjectsClick,
            onContactClick: onContactClick,
          ),
      tablet:
          (ctx) => _NavBarMobile(
            // Use mobile layout for tablet
            onHomeClick: onHomeClick,
            onSkillsClick: onSkillsClick,
            onProjectsClick: onProjectsClick,
            onContactClick: onContactClick,
          ),
    );
  }
}

class _NavBarDesktop extends StatelessWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onSkillsClick;
  final VoidCallback onProjectsClick;
  final VoidCallback onContactClick;

  const _NavBarDesktop({
    required this.onHomeClick,
    required this.onSkillsClick,
    required this.onProjectsClick,
    required this.onContactClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppConstants.appName,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 24,
              color: AppColors.primaryAccent,
            ),
          ),
          Row(
            children: [
              _NavButton(title: "Home", onTap: onHomeClick),
              _NavButton(title: "Skills", onTap: onSkillsClick),
              _NavButton(title: "Projects", onTap: onProjectsClick),
              _NavButton(title: "Contact", onTap: onContactClick),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavBarMobile extends StatelessWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onSkillsClick;
  final VoidCallback onProjectsClick;
  final VoidCallback onContactClick;

  const _NavBarMobile({
    required this.onHomeClick,
    required this.onSkillsClick,
    required this.onProjectsClick,
    required this.onContactClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            AppConstants.appName,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 24,
              color: AppColors.primaryAccent,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              _NavButton(title: "Home", onTap: onHomeClick),
              _NavButton(title: "Skills", onTap: onSkillsClick),
              _NavButton(title: "Projects", onTap: onProjectsClick),
              _NavButton(title: "Contact", onTap: onContactClick),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8), // Reduced padding
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}

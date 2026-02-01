import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onProjectsClick;
  final VoidCallback onContactClick;

  const NavBar({
    super.key,
    required this.onHomeClick,
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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

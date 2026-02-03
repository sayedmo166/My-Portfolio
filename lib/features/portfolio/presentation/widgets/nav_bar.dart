import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onSkillsClick;
  final VoidCallback onProjectsClick;
  final VoidCallback onContactClick;
  final VoidCallback? onServicesClick;

  const NavBar({
    super.key,
    required this.onHomeClick,
    required this.onSkillsClick,
    required this.onProjectsClick,
    required this.onContactClick,
    this.onServicesClick,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Fix for Desktop Mode: Use width constraint instead of responsive_builder
        final isNarrow = constraints.maxWidth < 800;

        if (isNarrow) {
          return _NavBarMobile(
            onHomeClick: onHomeClick,
            onSkillsClick: onSkillsClick,
            onProjectsClick: onProjectsClick,
            onContactClick: onContactClick,
            onServicesClick: onServicesClick,
          );
        }
        return _NavBarDesktop(
          onHomeClick: onHomeClick,
          onSkillsClick: onSkillsClick,
          onProjectsClick: onProjectsClick,
          onContactClick: onContactClick,
          onServicesClick: onServicesClick,
        );
      },
    );
  }
}

class _NavBarDesktop extends StatelessWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onSkillsClick;
  final VoidCallback onProjectsClick;
  final VoidCallback onContactClick;
  final VoidCallback? onServicesClick;

  const _NavBarDesktop({
    required this.onHomeClick,
    required this.onSkillsClick,
    required this.onProjectsClick,
    required this.onContactClick,
    this.onServicesClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo with gradient
          ShaderMask(
            shaderCallback:
                (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            children: [
              _NavButton(title: "Home", onTap: onHomeClick),
              if (onServicesClick != null)
                _NavButton(title: "Services", onTap: onServicesClick!),
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

class _NavBarMobile extends StatefulWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onSkillsClick;
  final VoidCallback onProjectsClick;
  final VoidCallback onContactClick;
  final VoidCallback? onServicesClick;

  const _NavBarMobile({
    required this.onHomeClick,
    required this.onSkillsClick,
    required this.onProjectsClick,
    required this.onContactClick,
    this.onServicesClick,
  });

  @override
  State<_NavBarMobile> createState() => _NavBarMobileState();
}

class _NavBarMobileState extends State<_NavBarMobile> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShaderMask(
                shaderCallback:
                    (bounds) => AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    _isMenuOpen ? Icons.close : Icons.menu,
                    key: ValueKey(_isMenuOpen),
                    color: AppColors.primaryAccent,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isMenuOpen ? null : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isMenuOpen ? 1 : 0,
              child:
                  _isMenuOpen
                      ? Container(
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primaryAccent.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          children: [
                            _MobileNavButton(
                              title: "Home",
                              icon: Icons.home,
                              onTap: () {
                                widget.onHomeClick();
                                setState(() => _isMenuOpen = false);
                              },
                            ),
                            if (widget.onServicesClick != null)
                              _MobileNavButton(
                                title: "Services",
                                icon: Icons.design_services,
                                onTap: () {
                                  widget.onServicesClick!();
                                  setState(() => _isMenuOpen = false);
                                },
                              ),
                            _MobileNavButton(
                              title: "Skills",
                              icon: Icons.code,
                              onTap: () {
                                widget.onSkillsClick();
                                setState(() => _isMenuOpen = false);
                              },
                            ),
                            _MobileNavButton(
                              title: "Projects",
                              icon: Icons.work,
                              onTap: () {
                                widget.onProjectsClick();
                                setState(() => _isMenuOpen = false);
                              },
                            ),
                            _MobileNavButton(
                              title: "Contact",
                              icon: Icons.email,
                              onTap: () {
                                widget.onContactClick();
                                setState(() => _isMenuOpen = false);
                              },
                            ),
                          ],
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavButton({required this.title, required this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextButton(
          onPressed: widget.onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color:
                      _isHovered
                          ? AppColors.primaryAccent
                          : AppColors.primaryText,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 30 : 0,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileNavButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryAccent),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: AppColors.primaryAccent.withOpacity(0.1),
    );
  }
}

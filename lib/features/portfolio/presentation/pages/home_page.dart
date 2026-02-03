import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/portfolio_bloc.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/skills_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/services_section.dart';
import '../widgets/experience_timeline.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/particles_background.dart';
import '../widgets/skeleton_loading.dart';
import '../widgets/contact_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/project_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: 800.ms,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PortfolioBloc>()..add(GetPortfolioData()),
      child: Scaffold(
        body: ParticlesBackground(
          particleCount: 40,
          child: SingleChildScrollView(
            child: Column(
              children: [
                NavBar(
                  onHomeClick: () => _scrollTo(_homeKey),
                  onSkillsClick: () => _scrollTo(_skillsKey),
                  onProjectsClick: () => _scrollTo(_projectsKey),
                  onContactClick: () => _scrollTo(_contactKey),
                  onServicesClick: () => _scrollTo(_servicesKey),
                ),

                // Home/Hero Section
                Container(key: _homeKey, child: const HeroSection()),

                // Stats Section
                const StatsSection(),

                // Services Section
                Container(key: _servicesKey, child: const ServicesSection()),

                // Skills Section
                Container(key: _skillsKey, child: const SkillsSection()),

                // Experience Timeline
                const ExperienceTimeline(),

                const SizedBox(height: 60),

                // Projects Section
                Container(
                  key: _projectsKey,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Featured Projects",
                        style: Theme.of(context).textTheme.displayMedium,
                      ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                      const SizedBox(height: 10),
                      Text(
                        "Real production apps published on App Stores",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                      const SizedBox(height: 40),
                      BlocBuilder<PortfolioBloc, PortfolioState>(
                        builder: (context, state) {
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              // Fix for Desktop Mode on mobile
                              final isNarrow = constraints.maxWidth < 600;
                              final isMedium = constraints.maxWidth < 900;
                              final crossAxisCount =
                                  isNarrow ? 1 : (isMedium ? 2 : 3);

                              return _buildProjectList(
                                state,
                                crossAxisCount: crossAxisCount,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),

                // Testimonials Section
                const TestimonialsSection(),

                const SizedBox(height: 40),

                // Contact Form Section
                Container(key: _contactKey, child: const ContactFormSection()),

                // Footer
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackground,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.primaryAccent.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback:
                            (bounds) =>
                                AppColors.primaryGradient.createShader(bounds),
                        child: Text(
                          "Let's Work Together",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Text(
                      //   "تواصل معايا عشان نبني تطبيقك القادم 🚀",
                      //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      //     color: AppColors.secondaryText,
                      //   ),
                      // ),
                      const SizedBox(height: 30),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isNarrow = constraints.maxWidth < 600;

                          if (isNarrow) {
                            return Column(
                              children: [
                                _ContactItem(
                                  icon: Icons.location_on,
                                  text: "Egypt, Cairo",
                                ),
                                const SizedBox(height: 16),
                                _ContactItem(
                                  icon: Icons.phone,
                                  text: "01095990437",
                                ),
                                const SizedBox(height: 16),
                                _ContactItem(
                                  icon: Icons.email,
                                  text: "sm4679313@gmail.com",
                                ),
                              ],
                            );
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _ContactItem(
                                icon: Icons.location_on,
                                text: "Egypt, Cairo",
                              ),
                              const SizedBox(width: 40),
                              _ContactItem(
                                icon: Icons.phone,
                                text: "01095990437",
                              ),
                              const SizedBox(width: 40),
                              _ContactItem(
                                icon: Icons.email,
                                text: "sm4679313@gmail.com",
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialIcon(
                            icon: Icons.email,
                            onTap:
                                () => _launchUrl("mailto:sm4679313@gmail.com"),
                            tooltip: "Email",
                          ),
                          const SizedBox(width: 16),
                          _SocialIcon(
                            icon: FontAwesomeIcons.github,
                            onTap:
                                () =>
                                    _launchUrl("https://github.com/sayedmo166"),
                            tooltip: "GitHub",
                          ),
                          const SizedBox(width: 16),
                          _SocialIcon(
                            icon: FontAwesomeIcons.linkedin,
                            onTap:
                                () => _launchUrl(
                                  "https://www.linkedin.com/in/sayedmohamed442002/",
                                ),
                            tooltip: "LinkedIn",
                          ),
                          const SizedBox(width: 16),
                          _SocialIcon(
                            icon: FontAwesomeIcons.whatsapp,
                            onTap:
                                () => _launchUrl("https://wa.me/+201095990437"),
                            tooltip: "WhatsApp",
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Divider(color: AppColors.primaryAccent.withOpacity(0.1)),
                      const SizedBox(height: 20),
                      Text(
                        "© 2026 Sayed Mohamed. Built with Flutter 💙",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectList(
    PortfolioState state, {
    required int crossAxisCount,
  }) {
    if (state is PortfolioLoading) {
      return ProjectsSkeletonGrid(count: 4, crossAxisCount: crossAxisCount);
    } else if (state is PortfolioLoaded) {
      if (crossAxisCount == 1) {
        return Column(
          children:
              state.projects.asMap().entries.map((entry) {
                final index = entry.key;
                final project = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ProjectCard(project: project)
                      .animate(delay: (100 * index).ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),
                );
              }).toList(),
        );
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemCount: state.projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: state.projects[index])
              .animate(delay: (100 * index).ms)
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2, end: 0);
        },
      );
    } else if (state is PortfolioError) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.secondaryText),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primaryAccent, size: 20),
        const SizedBox(width: 8),
        SelectableText(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.primaryText),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  const _SocialIcon({required this.icon, required this.onTap, this.tooltip});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: widget.tooltip ?? '',
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform:
              Matrix4.identity()..translate(0.0, _isHovered ? -4.0 : 0.0),
          child: IconButton(
            onPressed: widget.onTap,
            icon: FaIcon(
              widget.icon,
              color:
                  _isHovered ? AppColors.primaryAccent : AppColors.primaryText,
            ),
            style: IconButton.styleFrom(
              backgroundColor:
                  _isHovered
                      ? AppColors.primaryAccent.withOpacity(0.1)
                      : AppColors.primaryBackground,
              padding: const EdgeInsets.all(14),
            ),
          ),
        ),
      ),
    );
  }
}

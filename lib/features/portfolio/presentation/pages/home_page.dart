import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/portfolio_bloc.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/skills_section.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(
                onHomeClick: () => _scrollTo(_homeKey),
                onSkillsClick: () => _scrollTo(_skillsKey),
                onProjectsClick: () => _scrollTo(_projectsKey),
                onContactClick: () => _scrollTo(_contactKey),
              ),

              // Home Section
              Container(key: _homeKey, child: const HeroSection()),

              // Skills Section
              Container(key: _skillsKey, child: const SkillsSection()),

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
                    ),
                    const SizedBox(height: 40),
                    BlocBuilder<PortfolioBloc, PortfolioState>(
                      builder: (context, state) {
                        return ScreenTypeLayout.builder(
                          mobile:
                              (ctx) =>
                                  _buildProjectList(state, crossAxisCount: 1),
                          tablet:
                              (ctx) =>
                                  _buildProjectList(state, crossAxisCount: 2),
                          desktop:
                              (ctx) =>
                                  _buildProjectList(state, crossAxisCount: 3),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),
              // Footer / Contact
              Container(
                key: _contactKey,
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                color: AppColors.secondaryBackground,
                child: Column(
                  children: [
                    Text(
                      "Contact Me",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: AppColors.primaryAccent),
                    ),
                    const SizedBox(height: 30),
                    SelectableText(
                      "Egypt, Cairo",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      "01095990437",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      "sm4679313@gmail.com",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialIcon(
                          icon: Icons.email,
                          onTap: () => _launchUrl("mailto:sm4679313@gmail.com"),
                          tooltip: "Email",
                        ),
                        const SizedBox(width: 20),
                        _SocialIcon(
                          icon: FontAwesomeIcons.github,
                          onTap:
                              () => _launchUrl("https://github.com/sayedmo166"),
                          tooltip: "GitHub",
                        ),
                        const SizedBox(width: 20),
                        _SocialIcon(
                          icon: FontAwesomeIcons.linkedin,
                          onTap:
                              () => _launchUrl(
                                "https://www.linkedin.com/in/sayedmohamed442002/",
                              ),
                          tooltip: "LinkedIn",
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "© 2026 Sayed Mohamed. All rights reserved.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
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
      return const Center(child: CircularProgressIndicator());
    } else if (state is PortfolioLoaded) {
      if (crossAxisCount == 1) {
        return Column(
          children:
              state.projects.map((project) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ProjectCard(project: project),
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
          return ProjectCard(project: state.projects[index]);
        },
      );
    } else if (state is PortfolioError) {
      return Center(child: Text(state.message));
    }
    return const SizedBox.shrink();
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  const _SocialIcon({required this.icon, required this.onTap, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: IconButton(
        onPressed: onTap,
        icon: FaIcon(icon, color: AppColors.primaryText),
        style: IconButton.styleFrom(
          backgroundColor: AppColors.primaryBackground,
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}

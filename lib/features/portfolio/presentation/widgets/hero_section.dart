import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Fix for Desktop Mode: Use width constraint instead of responsive_builder
        final isNarrow = constraints.maxWidth < 800;

        if (isNarrow) {
          return _HeroMobile();
        }
        return _HeroDesktop();
      },
    );
  }
}

class _HeroDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHelloText(context),
                const SizedBox(height: 10),
                _buildNameText(context, fontSize: 64),
                const SizedBox(height: 20),
                _buildTypingRoleText(context),
                const SizedBox(height: 20),
                _buildBioText(context),
                const SizedBox(height: 40),
                _buildButtons(context),
              ],
            ),
          ),
          Expanded(child: _buildHeroImage()),
        ],
      ),
    );
  }
}

class _HeroMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          _buildHelloText(context),
          const SizedBox(height: 10),
          _buildNameText(context, fontSize: 36),
          const SizedBox(height: 16),
          _buildTypingRoleText(context),
          const SizedBox(height: 16),
          _buildBioText(context, isMobile: true),
          const SizedBox(height: 30),
          _buildHeroImage(height: 280),
          const SizedBox(height: 30),
          _buildButtons(context, isMobile: true),
        ],
      ),
    );
  }
}

// Shared Widgets Helpers
Widget _buildHelloText(BuildContext context) {
  return Text(
    "Hello, I'm",
    style: Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(color: AppColors.primaryAccent),
  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2);
}

Widget _buildNameText(BuildContext context, {required double fontSize}) {
  return Text(
    "Sayed Mohamed",
    style: Theme.of(
      context,
    ).textTheme.displayLarge?.copyWith(fontSize: fontSize, height: 1.1),
  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2);
}

Widget _buildTypingRoleText(BuildContext context) {
  return SizedBox(
    height: 40,
    child: DefaultTextStyle(
      style:
          Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primaryAccent,
            fontWeight: FontWeight.w500,
          ) ??
          const TextStyle(),
      child: AnimatedTextKit(
        repeatForever: true,
        pause: const Duration(milliseconds: 1000),
        animatedTexts: [
          TypewriterAnimatedText(
            'Flutter Developer',
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            'Mobile App Expert',
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            'Clean Architecture Enthusiast',
            speed: const Duration(milliseconds: 80),
          ),
        ],
      ),
    ),
  ).animate().fadeIn(delay: 400.ms);
}

Widget _buildBioText(BuildContext context, {bool isMobile = false}) {
  return Text(
    "Passionate Flutter developer with 1.5+ years of experience building scalable, high-performance mobile apps. "
    "Expert in Bloc, Cubit, Clean Architecture, Firebase, and delivering production-ready apps to Google Play & App Store.",
    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: AppColors.secondaryText,
      height: 1.6,
    ),
    textAlign: isMobile ? TextAlign.center : TextAlign.start,
  ).animate().fadeIn(delay: 500.ms);
}

Widget _buildHeroImage({double height = 400}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: AppColors.primaryGradient,
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryAccent.withOpacity(0.3),
          blurRadius: 100,
          spreadRadius: 20,
        ),
      ],
      image: const DecorationImage(
        image: AssetImage("assets/images/upscaled-image-1769947137374.png"),
        fit: BoxFit.contain,
      ),
    ),
  ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack);
}

Widget _buildButtons(BuildContext context, {bool isMobile = false}) {
  final buttons = [
    ElevatedButton.icon(
      onPressed: () async {
        final uri = Uri.parse("https://flowcv.com/resume/s08lg7guwu");
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      icon: const Icon(Icons.description, size: 20),
      label: const Text("Download CV"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAccent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        minimumSize: isMobile ? const Size(double.infinity, 54) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ).animate().fadeIn(delay: 600.ms),
    SizedBox(width: isMobile ? 0 : 16, height: isMobile ? 12 : 0),
    OutlinedButton.icon(
      onPressed: () async {
        final uri = Uri.parse("https://wa.me/+201095990437");
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 20),
      label: const Text("WhatsApp"),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryAccent,
        side: BorderSide(color: AppColors.primaryAccent, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        minimumSize: isMobile ? const Size(double.infinity, 54) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ).animate().fadeIn(delay: 700.ms),
  ];

  if (isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttons,
    );
  } else {
    return Wrap(runSpacing: 16, spacing: 16, children: buttons);
  }
}

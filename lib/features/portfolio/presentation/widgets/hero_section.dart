import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (ctx) => _HeroMobile(),
      desktop: (ctx) => _HeroDesktop(),
      tablet:
          (ctx) =>
              _HeroMobile(), // Use mobile layout for tablet/desktop-mode on phone
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
                _buildRoleText(context),
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
          // On mobile, show image first or second? Usually Image then text, or Text then image.
          // Let's stick to standard flow: Text then Image, or maybe Image top for personal branding.
          // Let's do Text top for now properly aligned.
          _buildHelloText(context),
          const SizedBox(height: 10),
          _buildNameText(context, fontSize: 40), // Smaller font for mobile
          const SizedBox(height: 16),
          _buildRoleText(context),
          const SizedBox(height: 40),
          _buildHeroImage(height: 300),
          const SizedBox(height: 40),
          _buildButtons(context, isMobile: true),
        ],
      ),
    );
  }
}

// Shared Widgets Helpers to avoid duplication
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

Widget _buildRoleText(BuildContext context) {
  return Text(
    "Flutter Developer",
    style: Theme.of(
      context,
    ).textTheme.headlineMedium?.copyWith(color: AppColors.secondaryText),
  ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2);
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
    ElevatedButton(
      onPressed: () async {
        final uri = Uri.parse("https://flowcv.com/resume/s08lg7guwu");
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAccent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        minimumSize: isMobile ? const Size(double.infinity, 50) : null,
      ),
      child: const Text("My CV"),
    ).animate().fadeIn(delay: 600.ms),
    SizedBox(width: isMobile ? 0 : 20, height: isMobile ? 16 : 0),
    OutlinedButton(
      onPressed: () async {
        final uri = Uri.parse("https://wa.me/+201095990437");
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryAccent,
        side: BorderSide(color: AppColors.primaryAccent),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        minimumSize: isMobile ? const Size(double.infinity, 50) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FaIcon(FontAwesomeIcons.whatsapp, size: 20),
          SizedBox(width: 10),
          Text("WhatsApp"),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms),
  ];

  if (isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttons,
    );
  } else {
    // Desktop: Use Wrap to handle narrow widths safely
    return Wrap(runSpacing: 16, spacing: 20, children: buttons);
  }
}

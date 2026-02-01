import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

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
                Text(
                  "Hello, I'm",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primaryAccent,
                  ),
                ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                const SizedBox(height: 10),
                Text(
                  "Sayed Mohamed",
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(fontSize: 64, height: 1.1),
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                const SizedBox(height: 20),
                Text(
                  "Flutter Developer",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2),
                const SizedBox(height: 40),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final uri = Uri.parse(
                          "https://flowcv.com/resume/s08lg7guwu",
                        );
                        if (await canLaunchUrl(uri)) await launchUrl(uri);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                      ),
                      child: const Text("My CV"),
                    ).animate().fadeIn(delay: 600.ms),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () async {
                        final uri = Uri.parse("https://wa.me/+201095990437");
                        if (await canLaunchUrl(uri)) await launchUrl(uri);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryAccent,
                        side: BorderSide(color: AppColors.primaryAccent),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          FaIcon(FontAwesomeIcons.whatsapp, size: 20),
                          SizedBox(width: 10),
                          Text("WhatsApp"),
                        ],
                      ),
                    ).animate().fadeIn(delay: 700.ms),
                  ],
                ),
              ],
            ),
          ),
          // Placeholder for 3D Image or Avatar
          Expanded(
            child: Container(
              height: 400,
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
                  image: AssetImage(
                    "assets/images/upscaled-image-1769947137374.png",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }
}

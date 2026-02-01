import 'package:equatable/equatable.dart';

class SocialLink extends Equatable {
  final String platform; // e.g. "LinkedIn", "GitHub"
  final String url;
  final String iconAsset; // or IconData logic

  const SocialLink({
    required this.platform,
    required this.url,
    required this.iconAsset,
  });

  @override
  List<Object> get props => [platform, url, iconAsset];
}

import '../models/project_model.dart';

abstract class PortfolioLocalDataSource {
  Future<List<ProjectModel>> getProjects();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  Future<List<ProjectModel>> getProjects() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      ProjectModel(
        title: "Marakiib",
        description:
            "A complete car rental application with two separate flows (Customer & Lessor/Office). Customers can browse available cars, view car locations on an interactive map, and communicate with lessors via real-time chat. Includes an in-app wallet system for balance top-up and seamless rental payments. Real-time push notifications for rentals, messages, and updates.",
        techStack: [
          "Flutter",
          "Bloc",
          "MVVM",
          "Google Maps",
          "Firebase Messaging",
          "Real-time Chat",
        ],
        googlePlayLink:
            "https://play.google.com/store/apps/details?id=com.marakiib",
        appStoreLink: "https://apps.apple.com/tr/app/marakiib/id6473254943",
        imageUrl: "assets/images/marakib.png",
      ),
      ProjectModel(
        title: "ALSAFA GLASS",
        description:
            "A complete e-commerce application with user authentication, product browsing, cart management, wishlist, and full order placement and tracking. Users can track their order status (Pending, Processing, Shipping, Delivered) with a visual progress indicator.",
        techStack: [
          "Flutter",
          "Bloc",
          "MVVM",
          "RESTful APIs",
          "Order Tracking",
        ],
        googlePlayLink:
            "https://play.google.com/store/apps/details?id=com.alsafaglass&pli=1",
        appStoreLink: "https://apps.apple.com/fi/app/alsafa-glass/id6451291258",
        imageUrl: "assets/images/alsafa.png",
      ),
      ProjectModel(
        title: "Al-Kashkah",
        description:
            "A barber salon app for showcasing services and products. Includes user authentication, service and product browsing, and a smooth user interface. Integrated with an Admin Panel.",
        techStack: ["Flutter", "Bloc", "MVVM", "Local Notifications"],
        googlePlayLink:
            "https://play.google.com/store/apps/details?id=com.ahdafweb.elkashkha",
        appStoreLink: "https://apps.apple.com/us/app/al-kashkha/id6747615292",
        imageUrl: "assets/images/alkashka.jpg",
      ),
      ProjectModel(
        title: "Dubi Hotel",
        description:
            "A home services booking app featuring full API integration including authentication, service browsing, booking, and status tracking. Includes scheduled notifications to remind users about offers.",
        techStack: ["Flutter", "Bloc", "MVVM", "RESTful APIs"],
        googlePlayLink:
            "https://play.google.com/store/apps/details?id=com.ahdafweb.dubai_hotel",
        appStoreLink: "https://apps.apple.com/sa/app/dubai-hotel/id6744968446",
        imageUrl: "assets/images/dubai.png",
      ),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:shafeek_portfolio/pages/dopamine_detox_page.dart';
import 'package:shafeek_portfolio/pages/workshop_overview_page.dart';

class FeaturedProject extends StatefulWidget {
  const FeaturedProject({super.key});

  @override
  State<FeaturedProject> createState() => _FeaturedProjectState();
}

class _FeaturedProjectState extends State<FeaturedProject> {
  bool _isHoveringMain = false;
  bool _isHoveringSide = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: isMobile
              ? Column(
                  children: [
                    _buildMainProject(context, true),
                    const SizedBox(height: 32),
                    _buildSideProject(context, true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _buildMainProject(context, false)),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: _buildSideProject(context, false),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildMainProject(BuildContext context, bool isMobile) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            reverseTransitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const DopamineDetoxPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 0.1);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutExpo;

                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
                      .animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      );

                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(opacity: fadeAnimation, child: child),
                  );
                },
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHoveringMain = true),
        onExit: (_) => setState(() => _isHoveringMain = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHoveringMain ? -10 : 0, 0),
          clipBehavior: Clip.antiAlias,
          height: isMobile ? 260 : 360,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.backgroundBlack,
            borderRadius: BorderRadius.circular(16),

            boxShadow: _isHoveringMain
                ? [
                    BoxShadow(
                      color: AppTheme.accentRed.withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: -10,
                    ),
                  ]
                : [],
          ),
          child: Stack(
            children: [
              // Project Image
              Positioned.fill(
                child: AnimatedScale(
                  scale: _isHoveringMain ? 1.05 : 1.02,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  child: Image.asset(
                    'assets/images/pexels-olly-3768118.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white24,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Content Gradient Overlay for text visibility
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.95),
                      ],
                      stops: const [0.0, 0.2, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
              // Top Content
              Positioned(
                top: 40,
                left: 40,
                right: 40,
                child: Text(
                  "FEATURED WORK",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.accentRed,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              // Bottom Content
              Positioned(
                bottom: 40,
                left: 40,
                right: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dopamine Detox",
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: AppTheme.textWhite,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "UX Design • Case study of a tool for tracking dopamine sources to gain control over it.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
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

  Widget _buildSideProject(BuildContext context, bool isMobile) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHoveringSide = true),
      onExit: (_) => setState(() => _isHoveringSide = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WorkshopOverviewPage(
                title: "Workshop",
                description: "Crafting visual narratives through motion and typography.",
                videoUrl: "assets/video/video_small.mp4",
                category: "Workshop",
                duration: "2 Hours",
                linkUrl: "https://www.linkedin.com/posts/sqrahman18_today-i-had-the-opportunity-to-cover-the-activity-7438587862800977920-I379?utm_source=social_share_send&utm_medium=member_desktop_web&rcm=ACoAAEmLxNwBipnEU5CqsQfYmmLDECvy2opcj-0",
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHoveringSide ? -10 : 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHoveringSide
                ? [
                    BoxShadow(
                      color: AppTheme.textWhite.withOpacity(0.1),
                      blurRadius: 30,
                      spreadRadius: -5,
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Cover Image Background
                SizedBox(
                  width: double.infinity,
                  height: isMobile ? 280 : 240,
                  child: Image.asset(
                    'assets/video/workshop coverimage.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[900]),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: isMobile ? 24 : 40,
                  left: isMobile ? 24 : 40,
                  right: isMobile ? 24 : 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.play_circle_outline,
                        color: AppTheme.textWhite,
                        size: 32,
                      ),
                      SizedBox(height: isMobile ? 16 : 32),
                      Text(
                        "Workshop",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Led an end-to-end UI/UX workshop, & mentoring participants in research.",
                        style: Theme.of(context).textTheme.bodyMedium,
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
}

class AbstractLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.accentRed.withOpacity(0.05)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < 10; i++) {
      path.moveTo(size.width * 0.1 * i, 0);
      path.quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.5,
        size.width,
        size.height * 0.1 * i,
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';

class Navbar extends StatelessWidget {
  final ScrollController scrollController;
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const Navbar({
    super.key,
    required this.scrollController,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double offset = 0;
        if (scrollController.hasClients) {
          offset = scrollController.offset;
        }

        // Calculate opacity based on scroll offset (starts transparent, gets darker/blurred)
        final double blurAmount = (offset / 100).clamp(0.0, 10.0);
        final bool isScrolled = offset > 50;

        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
            child: AnimatedContainer(
              height: isScrolled ? 70 : 80,
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40),
              decoration: BoxDecoration(
                color: isScrolled
                    ? AppTheme.backgroundDark.withOpacity(0.85)
                    : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: isScrolled
                        ? Colors.white.withOpacity(0.05)
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: Logo
                      Text(
                        "SHAFEEK",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: AppTheme.textWhite,
                              letterSpacing: 2,
                            ),
                      ),

                      if (isMobile)
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          color: AppTheme.backgroundDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.white.withOpacity(0.1)),
                          ),
                          onSelected: (value) {
                            if (value == 'Home') onHomeTap();
                            if (value == 'About') onAboutTap();
                            if (value == 'Projects') onProjectsTap();
                            if (value == 'Contact') onContactTap();
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Home',
                              child: Text('Home', style: TextStyle(color: Colors.white)),
                            ),
                            const PopupMenuItem<String>(
                              value: 'About',
                              child: Text('About', style: TextStyle(color: Colors.white)),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Projects',
                              child: Text('Projects', style: TextStyle(color: Colors.white)),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Contact',
                              child: Text('Contact Me', style: TextStyle(color: AppTheme.accentRed)),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            _NavBarLink(title: "Home", onTap: onHomeTap),
                            const SizedBox(width: 32),
                            _NavBarLink(title: "About", onTap: onAboutTap),
                            const SizedBox(width: 32),
                            _NavBarLink(title: "Projects", onTap: onProjectsTap),
                            const SizedBox(width: 32),
                            ElevatedButton(
                              onPressed: onContactTap,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                              ),
                              child: const Text("Contact Me"),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavBarLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarLink({required this.title, required this.onTap});

  @override
  State<_NavBarLink> createState() => _NavBarLinkState();
}

class _NavBarLinkState extends State<_NavBarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: _isHovered ? AppTheme.accentRed : AppTheme.textGrey,
              ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}

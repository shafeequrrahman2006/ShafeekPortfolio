import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:shafeek_portfolio/widgets/navbar.dart';
import 'package:shafeek_portfolio/widgets/parallax_layer.dart';
import 'package:shafeek_portfolio/widgets/hero_section.dart';
import 'package:shafeek_portfolio/widgets/featured_project.dart';
import 'package:shafeek_portfolio/widgets/quote_section.dart';
import 'package:shafeek_portfolio/widgets/about_section.dart';
import 'package:shafeek_portfolio/widgets/core_masteries.dart';
import 'package:shafeek_portfolio/widgets/creative_archive.dart';
import 'package:shafeek_portfolio/widgets/contact_section.dart';
import 'package:shafeek_portfolio/widgets/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundBlack,
      body: Stack(
        children: [
          // Background layer with abstract red elements
          ParallaxLayer(
            scrollController: _scrollController,
            speedMultiplier: 0.3,
            child: _buildBackground(),
          ),

          // Main Scrollable Content
          SelectionArea(
            child: CustomScrollView(
              controller: _scrollController,
              physics:
                  const ClampingScrollPhysics(), // Use clamping for smoother web scrolling
              slivers: [
                SliverToBoxAdapter(
                  child: HeroSection(
                    key: _homeKey,
                    onStartProject: () => _scrollToKey(_contactKey),
                    onViewPortfolio: () => _scrollToKey(_projectsKey),
                  ),
                ),
                const SliverToBoxAdapter(child: FeaturedProject()),
                const SliverToBoxAdapter(child: QuoteSection()),
                SliverToBoxAdapter(
                  child: AboutSection(
                    key: _aboutKey,
                    scrollController: _scrollController,
                  ),
                ),
                const SliverToBoxAdapter(child: CoreMasteries()),

                // Sticky Header for Projects Collection grouped with the grid
                SliverMainAxisGroup(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _StickyTitleDelegate(
                        minHeight: 180,
                        maxHeight: 180,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.backgroundBlack,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ), // Subtle border
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1000),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "SELECTED WORKS",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: AppTheme.accentRed),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "CREATIVE ARCHIVE",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CreativeArchive(key: _projectsKey),
                    ),
                  ],
                ),
                SliverToBoxAdapter(child: ContactSection(key: _contactKey)),
                SliverToBoxAdapter(
                  child: Footer(onHomeTap: () => _scrollToKey(_homeKey)),
                ),
              ],
            ),
          ),

          // Sticky Navbar layer
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              scrollController: _scrollController,
              onHomeTap: () => _scrollToKey(_homeKey),
              onAboutTap: () => _scrollToKey(_aboutKey),
              onProjectsTap: () => _scrollToKey(_projectsKey),
              onContactTap: () => _scrollToKey(_contactKey),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToKey(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutExpo,
      );
    }
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: 4800, // Make it cover the whole page better
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [
          // Abstract red gradient blobs to break the dark void
          Positioned(
            top: -200,
            right: -200,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 800,
                height: 800,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.accentRed.withOpacity(0.2),
                      Colors.transparent,
                    ],
                    stops: const [0.1, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 1000,
            left: -400,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                width: 1200,
                height: 1200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF330000).withOpacity(0.4),
                      const Color(0xFF330000).withOpacity(0.0),
                    ],
                    stops: const [0.1, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 2800,
            right: -300,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                width: 1000,
                height: 1000,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.accentRed.withOpacity(0.15),
                      AppTheme.accentRed.withOpacity(0.0),
                    ],
                    stops: const [0.1, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyTitleDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyTitleDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyTitleDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

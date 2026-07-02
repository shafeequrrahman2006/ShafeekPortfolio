import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';

class SliderProject {
  final String title;
  final String category;
  final String imagePath;

  const SliderProject({
    required this.title,
    required this.category,
    required this.imagePath,
  });
}

class ProjectSlider extends StatefulWidget {
  const ProjectSlider({super.key});

  @override
  State<ProjectSlider> createState() => _ProjectSliderState();
}

class _ProjectSliderState extends State<ProjectSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _autoPlayTimer;
  bool _isHovered = false;
  bool _isLeftArrowHovered = false;
  bool _isRightArrowHovered = false;
  double _tiltX = 0.0;
  double _tiltY = 0.0;
  double _pageValue = 0.0;

  final List<SliderProject> _projects = const [
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/workshop coverimage.png",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/Screenshot 2026-07-01 224528.png",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/IMG_0238.JPG",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/WhatsAp1p Image 2026-06-30 at 10.32.45 PM.jpeg",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/WhatsApp Image 2026-06-30 at 10.32.47 PM (1).jpeg",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/WhatsApp Image 2026-06-30 at 10.32.47 PM.jpeg",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/WhatsApp Image 2026-06-30 at 10.32.48 PM.jpeg",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/WhatsApp Image 2026-06-30 at 10.32.51 PM (1).jpeg",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/WhatsApp Image 2026-06-30 at 10.32.51 PM.jpeg",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/WhatsApp Image 2026-06-30 at 10.32.52 PM (1).jpeg",
    ),
    SliderProject(
      title: "Every moment counts",
      category: "THE JOURNEY SO FAR",
      imagePath: "assets/images/Project5/WhatsApp Image 2026-06-30 at 10.32.53 PM.jpeg",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
    _pageController.addListener(_onPageScroll);
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageScroll() {
    if (_pageController.hasClients) {
      setState(() {
        _pageValue = _pageController.page ?? 0.0;
      });
    }
  }

  void _startAutoPlay() {
    _stopAutoPlay();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        final nextIndex = (_currentIndex + 1) % _projects.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void _nextPage() {
    if (_pageController.hasClients) {
      final nextIndex = (_currentIndex + 1) % _projects.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _prevPage() {
    if (_pageController.hasClients) {
      final prevIndex = (_currentIndex - 1 + _projects.length) % _projects.length;
      _pageController.animateToPage(
        prevIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 960;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        _stopAutoPlay();
      },
      onHover: (event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final size = box.size;
          final centerX = size.width / 2;
          final centerY = size.height / 2;
          setState(() {
            // Normalize mouse position to range [-1.0, 1.0]
            _tiltX = (event.localPosition.dx - centerX) / centerX;
            _tiltY = (event.localPosition.dy - centerY) / centerY;
          });
        }
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _tiltX = 0.0;
          _tiltY = 0.0;
        });
        _startAutoPlay();
      },
      child: TweenAnimationBuilder<Offset>(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: _isHovered ? Offset(_tiltX, _tiltY) : Offset.zero,
        ),
        builder: (context, tilt, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateX(-tilt.dy * 0.12) // Tilt up/down
              ..rotateY(tilt.dx * 0.12), // Tilt left/right
            child: Container(
              width: isMobile ? double.infinity : 380,
              height: isMobile ? 320 : 420,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFF0D0D0D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isHovered 
                      ? AppTheme.accentRed.withOpacity(0.5) 
                      : Colors.white.withOpacity(0.08),
                  width: 1.5,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: AppTheme.accentRed.withOpacity(0.18),
                          blurRadius: 40,
                          spreadRadius: -5,
                          offset: Offset(-tilt.dx * 12, -tilt.dy * 12),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 20,
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Slider Container
                  Expanded(
                    child: Stack(
                      children: [
                        // PageView for Images with smooth parallax and zoom transitions
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemCount: _projects.length,
                          itemBuilder: (context, index) {
                            final project = _projects[index];
                            
                            // Calculate scroll offset difference for parallax
                            double difference = index.toDouble() - _pageValue;
                            double scale = 1.0 - (difference.abs() * 0.12).clamp(0.0, 0.12);
                            double translation = difference * 70.0; // horizontal parallax speed
                            
                            return ClipRect(
                              child: Transform.translate(
                                offset: Offset(translation, 0.0),
                                child: Transform.scale(
                                  scale: scale,
                                  child: Image.asset(
                                    project.imagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: const Color(0xFF1E1E1E),
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image_outlined,
                                          color: AppTheme.textGrey,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        // Hover Glare overlay - tied to smooth interpolated tilt
                        if (_isHovered)
                          Positioned.fill(
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    center: Alignment(tilt.dx, tilt.dy),
                                    radius: 0.8,
                                    colors: [
                                      Colors.white.withOpacity(0.08),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // Page indicators (dots) inside the image area at the bottom center
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_projects.length, (index) {
                              final isActive = index == _currentIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutCubic,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                height: 5,
                                width: isActive ? 22 : 6,
                                decoration: BoxDecoration(
                                  color: isActive 
                                      ? AppTheme.accentRed 
                                      : Colors.white.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              );
                            }),
                          ),
                        ),

                        // Left Arrow Button Overlay
                        Positioned(
                          left: 16,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: MouseRegion(
                              onEnter: (_) => setState(() => _isLeftArrowHovered = true),
                              onExit: (_) => setState(() => _isLeftArrowHovered = false),
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _prevPage,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: _isLeftArrowHovered
                                        ? AppTheme.accentRed
                                        : Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: _isLeftArrowHovered 
                                          ? Colors.transparent 
                                          : Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Right Arrow Button Overlay
                        Positioned(
                          right: 16,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: MouseRegion(
                              onEnter: (_) => setState(() => _isRightArrowHovered = true),
                              onExit: (_) => setState(() => _isRightArrowHovered = false),
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _nextPage,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: _isRightArrowHovered
                                        ? AppTheme.accentRed
                                        : Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: _isRightArrowHovered 
                                          ? Colors.transparent 
                                          : Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Metadata / Caption Area
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.1),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        key: ValueKey<int>(_currentIndex),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _projects[_currentIndex].category,
                            style: const TextStyle(
                              color: AppTheme.accentRed,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _projects[_currentIndex].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

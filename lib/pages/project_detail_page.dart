import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:shafeek_portfolio/widgets/navbar.dart';
import 'package:shafeek_portfolio/widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shafeek_portfolio/pages/workshop_overview_page.dart';

class ProjectDetailPage extends StatefulWidget {
  final String title;
  final String heroImageUrl;
  final String description;
  final String category;
  final String client;
  final String duration;
  final String location;
  final List<String> additionalImages;
  final String? liveSiteUrl;
  final String? nextProjectTitle;
  final WidgetBuilder? nextProjectBuilder;

  const ProjectDetailPage({
    super.key,
    required this.title,
    required this.heroImageUrl,
    this.description =
        "Crafted a refined brand identity and responsive Framer site to elevate visuals and experience.",
    this.category = "Branding",
    this.client = "Sonder Studios Inc.",
    this.duration = "7 - 8 Weeks",
    this.location = "Los Angeles, USA",
    this.additionalImages = const [
      "https://images.unsplash.com/photo-1544256718-3b61027b4b1a?q=80&w=1200",
      "https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=1200",
    ],
    this.liveSiteUrl,
    this.nextProjectTitle,
    this.nextProjectBuilder,
  });

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final ScrollController _scrollController = ScrollController();
  late final GlobalKey _leftKey = GlobalKey();
  late final GlobalKey _rightKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: AppTheme.backgroundBlack,
      body: SelectionArea(
        child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftContent(),
                    const SizedBox(height: 64),
                    _buildRightImages(),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildNextProject(),
              ),
              const SizedBox(height: 120),
              Footer(onHomeTap: () => Navigator.of(context).pop()),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Navbar(
            scrollController: _scrollController,
            onHomeTap: () => Navigator.of(context).pop(),
            onAboutTap: () => Navigator.of(context).pop(),
            onProjectsTap: () => Navigator.of(context).pop(),
            onContactTap: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Stack(
      children: [
        // 1. Scrollable Layer (Right side and overall height)
        SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 120), // Navbar space
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 64.0),
                            child: Container(
                              key: _leftKey,
                              child: SelectionContainer.disabled(
                                child: Opacity(
                                  opacity:
                                      0.0, // Invisible placeholder to measure height
                                  child: _buildLeftContent(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            key: _rightKey,
                            child: _buildRightImages(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: _buildNextProject(),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              Footer(onHomeTap: () => Navigator.of(context).pop()),
            ],
          ),
        ),

        // 2. True Fixed Left Content Layer
        AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) {
            double offset = _scrollController.hasClients
                ? _scrollController.offset
                : 0;
            double maxTranslation = 800.0;

            if (_rightKey.currentContext != null &&
                _leftKey.currentContext != null) {
              final rightBox =
                  _rightKey.currentContext!.findRenderObject() as RenderBox?;
              final leftBox =
                  _leftKey.currentContext!.findRenderObject() as RenderBox?;

              if (rightBox != null &&
                  rightBox.hasSize &&
                  leftBox != null &&
                  leftBox.hasSize) {
                maxTranslation = rightBox.size.height - leftBox.size.height;
                if (maxTranslation < 0) maxTranslation = 0;
              }
            }

            double topPosition = 120.0; // Fixed below Navbar

            if (offset < 0) {
              topPosition = 120.0 - offset; // Bounce down
            } else if (offset > maxTranslation) {
              topPosition =
                  120.0 - (offset - maxTranslation); // Un-stick and scroll up
            }

            return Positioned(
              top: topPosition,
              left: 0,
              right: 0,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 64.0),
                            child:
                                _buildLeftContent(), // Visible perfectly fixed content
                          ),
                        ),
                        const Expanded(
                          flex: 6,
                          child: SizedBox(),
                        ), // Empty right space
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // 3. Fixed Navbar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Navbar(
            scrollController: _scrollController,
            onHomeTap: () => Navigator.of(context).pop(),
            onAboutTap: () => Navigator.of(context).pop(),
            onProjectsTap: () => Navigator.of(context).pop(),
            onContactTap: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, color: Colors.white70, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Back",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          widget.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white70,
            height: 1.5,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 40),

        _buildMetadataRow("Category:", widget.category),
        _buildMetadataRow("Client:", widget.client),
        _buildMetadataRow("Duration:", widget.duration),
        _buildMetadataRow("Location:", widget.location),

        if (widget.liveSiteUrl != null && widget.liveSiteUrl!.isNotEmpty) ...[
          const SizedBox(height: 40),
          InkWell(
            onTap: () async {
              final uri = Uri.parse(widget.liveSiteUrl!);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Live Site",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMetadataRow(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildRightImages() {
    return Column(
      children: [
        _buildParallaxImage(widget.heroImageUrl),
        ...widget.additionalImages
            .map(
              (img) => Column(
                children: [
                  const SizedBox(height: 24),
                  _buildParallaxImage(img),
                ],
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildParallaxImage(String url) {
    return FractionallySizedBox(
      widthFactor: 0.85,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 350,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
            AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                double offset = _scrollController.hasClients
                    ? _scrollController.offset
                    : 0;
                return Transform.translate(
                  offset: Offset(0, (offset * 0.1) - 40),
                  child: child,
                );
              },
              child: OverflowBox(
                maxHeight: 600,
                child: url.startsWith('http')
                    ? Image.network(
                        url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey[900]),
                      )
                    : Image.asset(
                        url,
                        fit: (url.contains('Screenshot') || url.contains('Project3') || url.contains('Project4')) ? BoxFit.contain : BoxFit.cover,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey[900]),
                      ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildNextProject() {
    return InkWell(
      onTap: () {
        if (widget.nextProjectBuilder != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: widget.nextProjectBuilder!,
            ),
          );
        } else {
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
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.05)),
            bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Next Project",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
          ],
        ),
      ),
    );
  }
}

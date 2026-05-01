import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:shafeek_portfolio/widgets/navbar.dart';
import 'package:shafeek_portfolio/widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class WorkshopOverviewPage extends StatefulWidget {
  final String title;
  final String description;
  final String videoUrl;
  final String category;
  final String duration;
  final String linkUrl;

  const WorkshopOverviewPage({
    super.key,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.category,
    required this.duration,
    required this.linkUrl,
  });

  @override
  State<WorkshopOverviewPage> createState() => _WorkshopOverviewPageState();
}

class _WorkshopOverviewPageState extends State<WorkshopOverviewPage> {
  final ScrollController _scrollController = ScrollController();
  late final GlobalKey _leftKey = GlobalKey();
  late final GlobalKey _rightKey = GlobalKey();
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _videoController!.setLooping(true);
          _videoController!.play();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _videoController?.dispose();
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
                    _buildRightVideo(),
                  ],
                ),
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
        // Scrollable Layer
        SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 120),
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
                                  opacity: 0.0,
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
                            child: _buildRightVideo(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              Footer(onHomeTap: () => Navigator.of(context).pop()),
            ],
          ),
        ),

        // True Fixed Left Content Layer
        AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) {
            double offset = _scrollController.hasClients ? _scrollController.offset : 0;
            double maxTranslation = 800.0;

            if (_rightKey.currentContext != null && _leftKey.currentContext != null) {
              final rightBox = _rightKey.currentContext!.findRenderObject() as RenderBox?;
              final leftBox = _leftKey.currentContext!.findRenderObject() as RenderBox?;

              if (rightBox != null && rightBox.hasSize && leftBox != null && leftBox.hasSize) {
                maxTranslation = rightBox.size.height - leftBox.size.height;
                if (maxTranslation < 0) maxTranslation = 0;
              }
            }

            double topPosition = 120.0;

            if (offset < 0) {
              topPosition = 120.0 - offset;
            } else if (offset > maxTranslation) {
              topPosition = 120.0 - (offset - maxTranslation);
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
                            child: _buildLeftContent(),
                          ),
                        ),
                        const Expanded(flex: 6, child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Fixed Navbar
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
        _buildMetadataRow("Duration:", widget.duration),

        const SizedBox(height: 40),
        InkWell(
          onTap: () async {
            final uri = Uri.parse(widget.linkUrl);
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
              "Link",
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
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightVideo() {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            border: Border.all(color: Colors.white10),
          ),
          child: _videoController != null && _videoController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                )
              : const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: CircularProgressIndicator(color: AppTheme.accentRed),
                  ),
                ),
        ),
      ),
    );
  }
}

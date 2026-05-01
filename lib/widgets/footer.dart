import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final VoidCallback onHomeTap;

  const Footer({super.key, required this.onHomeTap});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: isMobile
              ? Column(
                  children: [
                    _buildCopyright(context),
                    const SizedBox(height: 24),
                    _buildLinks(context),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCopyright(context),
                    _buildLinks(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildCopyright(BuildContext context) {
    return GestureDetector(
      onTap: onHomeTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          "© ${DateTime.now().year} SHAFEEK. ALL RIGHTS RESERVED.",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12, color: AppTheme.textGrey),
        ),
      ),
    );
  }

  Widget _buildLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => launchUrl(Uri.parse('https://github.com/shafeequrrahman2006')), 
          child: Text("GIT", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12))
        ),
        const SizedBox(width: 24),
        TextButton(
          onPressed: () => launchUrl(Uri.parse('https://www.linkedin.com/in/sqrahman18/')), 
          child: Text("LINKEDIN", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12))
        ),
        const SizedBox(width: 24),
        TextButton(onPressed: () {}, child: Text("DRIBBBLE", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12))),
      ],
    );
  }
}

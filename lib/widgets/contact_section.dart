import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Let's create something\nextraordinary.", style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 64),
              isMobile
                  ? Column(
                      children: [
                        _buildForm(context),
                        const SizedBox(height: 64),
                        _buildInfo(context),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _buildForm(context)),
                        const SizedBox(width: 80),
                        Expanded(flex: 4, child: _buildInfo(context)),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _CustomTextField(label: "Name", controller: _nameController)),
              const SizedBox(width: 24),
              Expanded(child: _CustomTextField(label: "Email", controller: _emailController)),
            ],
          ),
          const SizedBox(height: 24),
          _CustomTextField(label: "Subject", controller: _subjectController),
          const SizedBox(height: 24),
          _CustomTextField(label: "Message", maxLines: 5, controller: _messageController),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _sendEmail,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 24),
              ),
              child: const Text("Send Message"),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _sendEmail() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String subject = _subjectController.text.trim();
    final String message = _messageController.text.trim();

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'shafeequrr309@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': subject.isEmpty ? 'Contact from Portfolio' : subject,
        'body': 'Name: $name\nEmail: $email\n\nMessage:\n$message',
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Widget _buildInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoItem(icon: Icons.location_on, label: "Location", value: "Tirunelveli, Tamilnadu"),
          const SizedBox(height: 32),
          _InfoItem(icon: Icons.email, label: "Email", value: "shafeequrr309@gmail.com"),
          const SizedBox(height: 32),
          _InfoItem(icon: Icons.phone, label: "Phone", value: "+91 99434 31749"),
          const SizedBox(height: 48),
          Text("CONNECT", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12, color: AppTheme.textGrey)),
          const SizedBox(height: 16),
          Row(
            children: [
              _SocialButton(
                text: "GIT", 
                onPressed: () => launchUrl(Uri.parse('https://github.com/shafeequrrahman2006')),
              ),
              const SizedBox(width: 16),
              _SocialButton(
                text: "LINKEDIN", 
                onPressed: () => launchUrl(Uri.parse('https://www.linkedin.com/in/sqrahman18/')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final TextEditingController? controller;

  const _CustomTextField({required this.label, this.maxLines = 1, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppTheme.textGrey.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.accentRed),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.accentRed, size: 24),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12, color: AppTheme.textGrey)),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _SocialButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text, 
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white, fontSize: 12)
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class QuoteSection extends StatelessWidget {
  const QuoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  "\"Design is the silent ambassador of your brand.\"",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        height: 1.2,
                      ),
                ),
              ),
              if (MediaQuery.of(context).size.width > 800) ...[
                const SizedBox(width: 80),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("— Paul Rand", style: Theme.of(context).textTheme.labelLarge),
                        const SizedBox(height: 16),
                        Container(width: 40, height: 1, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

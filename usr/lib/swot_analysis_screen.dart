import 'package:flutter/material.dart';

class SwotAnalysisScreen extends StatefulWidget {
  const SwotAnalysisScreen({super.key});

  @override
  State<SwotAnalysisScreen> createState() => _SwotAnalysisScreenState();
}

class _SwotAnalysisScreenState extends State<SwotAnalysisScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final int _totalPages = 6; // Overview + 4 SWOT details + 1 Related Info

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Strategic Analysis Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Swipe to navigate through the analysis')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: const [
                SwotOverviewSlide(),
                DetailSlide(
                  title: 'Strengths',
                  subtitle: 'Internal Positive Factors',
                  themeColor: Colors.green,
                  icon: Icons.check_circle_outline,
                  items: [
                    'Innovative Proprietary Technology',
                    'Strong Brand Recognition in Niche Market',
                    'Highly Skilled & Dedicated Team',
                    'Debt-Free Financial Status',
                    'High Customer Retention Rate',
                  ],
                ),
                DetailSlide(
                  title: 'Weaknesses',
                  subtitle: 'Internal Negative Factors',
                  themeColor: Colors.orange,
                  icon: Icons.warning_amber_rounded,
                  items: [
                    'Limited Marketing Budget',
                    'Dependency on Single Supplier',
                    'Gaps in Management Structure',
                    'Slow Product Iteration Cycles',
                    'Limited Global Presence',
                  ],
                ),
                DetailSlide(
                  title: 'Opportunities',
                  subtitle: 'External Positive Factors',
                  themeColor: Colors.blue,
                  icon: Icons.lightbulb_outline,
                  items: [
                    'Expansion into Emerging Markets',
                    'Strategic Partnerships & Alliances',
                    'New Technology Adoption (AI/ML)',
                    'Competitor Consolidation',
                    'Changing Consumer Trends favoring our niche',
                  ],
                ),
                DetailSlide(
                  title: 'Threats',
                  subtitle: 'External Negative Factors',
                  themeColor: Colors.red,
                  icon: Icons.error_outline,
                  items: [
                    'Aggressive Price Undercutting by Competitors',
                    'Regulatory & Compliance Changes',
                    'Economic Downturn / Inflation',
                    'Cybersecurity Risks',
                    'Rapid Technological Obsolescence',
                  ],
                ),
                RelatedInfoSlide(),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _currentPage > 0
                ? () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
            child: const Text('PREVIOUS'),
          ),
          Row(
            children: List.generate(_totalPages, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: _currentPage == index ? 24.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                ),
              );
            }),
          ),
          TextButton(
            onPressed: _currentPage < _totalPages - 1
                ? () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
            child: const Text('NEXT'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SLIDE 1: SWOT OVERVIEW (Grid Layout)
// ---------------------------------------------------------------------------
class SwotOverviewSlide extends StatelessWidget {
  const SwotOverviewSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SWOT Matrix',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Comprehensive analysis of internal and external factors affecting the business.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Determine grid aspect ratio based on available space
                final double itemHeight = (constraints.maxHeight - 16) / 2;
                final double itemWidth = (constraints.maxWidth - 16) / 2;
                final double aspectRatio = itemWidth / itemHeight;

                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: aspectRatio,
                  children: const [
                    SwotSummaryCard(
                      title: 'STRENGTHS',
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                      items: ['Innovation', 'Brand', 'Team'],
                    ),
                    SwotSummaryCard(
                      title: 'WEAKNESSES',
                      icon: Icons.warning_amber_rounded,
                      color: Colors.orange,
                      items: ['Budget', 'Dependencies', 'Gaps'],
                    ),
                    SwotSummaryCard(
                      title: 'OPPORTUNITIES',
                      icon: Icons.lightbulb_outline,
                      color: Colors.blue,
                      items: ['Expansion', 'Partnerships', 'Tech'],
                    ),
                    SwotSummaryCard(
                      title: 'THREATS',
                      icon: Icons.error_outline,
                      color: Colors.red,
                      items: ['Competition', 'Regulations', 'Economy'],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SwotSummaryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  const SwotSummaryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '• $item',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SLIDES 2-5: DETAILED LISTS
// ---------------------------------------------------------------------------
class DetailSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color themeColor;
  final IconData icon;
  final List<String> items;

  const DetailSlide({
    super.key,
    required this.title,
    required this.subtitle,
    required this.themeColor,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor.withOpacity(0.05),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: themeColor),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: themeColor.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: themeColor.withOpacity(0.1)),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: themeColor,
                      radius: 12,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      items[index],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SLIDE 6: RELATED INFORMATION
// ---------------------------------------------------------------------------
class RelatedInfoSlide extends StatelessWidget {
  const RelatedInfoSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Strategic Insights',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Key takeaways and action plan based on the analysis.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          _buildInfoSection(
            context,
            'Key Success Factors',
            Icons.star,
            Colors.amber,
            [
              'Maintain agility in product development to outpace competitors.',
              'Leverage strong brand identity to enter new markets.',
              'Invest in employee training to retain top talent.',
            ],
          ),
          
          const SizedBox(height: 24),
          
          _buildInfoSection(
            context,
            'Action Plan (Q3-Q4)',
            Icons.rocket_launch,
            Colors.indigo,
            [
              'Secure strategic partnership with AI technology provider.',
              'Launch targeted marketing campaign for the new subscription model.',
              'Conduct comprehensive security audit to mitigate cyber threats.',
            ],
          ),

          const SizedBox(height: 24),

          _buildInfoSection(
            context,
            'Market Trends',
            Icons.trending_up,
            Colors.teal,
            [
              'Shift towards remote-first collaboration tools.',
              'Increased demand for sustainable and ethical business practices.',
              'Integration of generative AI in everyday workflows.',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, IconData icon, Color color, List<String> points) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...points.map((point) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Icon(Icons.arrow_right, color: color, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    point,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

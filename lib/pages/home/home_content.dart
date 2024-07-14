import 'package:emo/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeContent extends StatefulWidget {
  final int numberOfChallenges;

  const HomeContent({Key? key, this.numberOfChallenges = 100})
      : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrollingDown = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrollingDown) {
        setState(() {
          _isScrollingDown = true;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingDown) {
        setState(() {
          _isScrollingDown = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) return _buildHeader(context);
                if (index == 1) return const SizedBox(height: 24);
                if (index == 2) return _buildDailyStreak(context);
                if (index == 3) return const SizedBox(height: 24);
                if (index == 4) return _buildChallengesHeader(context);
                if (index == 5) return const SizedBox(height: 24);

                // Challenges start from index 6
                int challengeIndex = index - 6;
                return _buildChallengeItem(context, challengeIndex);
              },
              childCount:
                  widget.numberOfChallenges + 6, // Add 6 for the header items
            ),
          ),
          padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      'Welcome back, User!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildDailyStreak(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colorScheme.secondary,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Streak',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  '5 days',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0, duration: 500.ms);
  }

  Widget _buildChallengesHeader(BuildContext context) {
    return Text(
      'Daily Challenges',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildChallengeItem(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isCompleted = index == 0;
    bool isLocked = index > 1;
    bool isLeft = index.isEven;

    Color cardColor = isCompleted
        ? colorScheme.accent1
        : isLocked
            ? colorScheme.secondary.withOpacity(0.2)
            : colorScheme.secondary;

    Widget challengeCard = Padding(
      padding: EdgeInsets.only(
          left: isLeft ? 0 : 40, right: isLeft ? 40 : 0, bottom: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: cardColor,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surface,
                ),
                child: Icon(
                  isCompleted
                      ? Icons.check
                      : isLocked
                          ? Icons.lock
                          : Icons.play_arrow,
                  color: colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Challenge ${index + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      isLocked ? 'Locked' : 'Complete this challenge',
                      style: TextStyle(
                        color: colorScheme.primary.withOpacity(0.8),
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

    return challengeCard.animate().fadeIn(duration: 500.ms).slideY(
          begin: _isScrollingDown ? 0.7 : -0.7,
          end: 0,
          duration: 500.ms,
          curve: Curves.easeInOut,
        );
  }
}

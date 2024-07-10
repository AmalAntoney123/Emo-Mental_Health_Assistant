import 'package:emo/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeContent extends StatefulWidget {
  final int numberOfChallenges;

  const HomeContent({Key? key, this.numberOfChallenges = 10}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late List<bool> _visibleItems;

  @override
  void initState() {
    super.initState();
    _visibleItems = List.filled(widget.numberOfChallenges, false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildDailyStreak(context),
            const SizedBox(height: 24),
            _buildChallengesPath(context),
          ],
        ),
      ),
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
    );
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
    );
  }

  Widget _buildChallengesPath(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Challenges',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.numberOfChallenges,
          itemBuilder: (context, index) {
            return _buildChallengeItem(context, index);
          },
        ),
      ],
    );
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

    return Padding(
      padding: EdgeInsets.only(
          left: isLeft ? 0 : 40, right: isLeft ? 40 : 0, bottom: 16),
      child: VisibilityDetector(
        key: Key('item-$index'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0.5) {
            setState(() {
              _visibleItems[index] = true;
            });
          }
        },
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: _visibleItems[index] ? 1.0 : 0.0,
          child: AnimatedSlide(
            duration: Duration(milliseconds: 500),
            offset: _visibleItems[index] ? Offset(0, 0) : Offset(0, 0.2),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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
          ),
        ),
      ),
    );
  }
}

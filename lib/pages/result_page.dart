
import 'package:flutter/material.dart';

import '../calculator.dart';
import '../constants.dart';

class ResultPage extends StatelessWidget {
  final double bmr;
  final String formulaName;
  final bool useKilojoules;

  const ResultPage({
    super.key,
    required this.bmr,
    required this.formulaName,
    required this.useKilojoules,
  });

  // Convert the result to the selected unit.
  double _convertValue(double value) {
    return useKilojoules ? value * 4.184 : value;
  }

  // Round the result for readability.
  String _formatValue(double value) {
    return _convertValue(value).round().toString();
  }

  String get _unit => useKilojoules ? 'kJ/day' : 'kcal/day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: headingColor,
        elevation: 0,
        title: const Text(
          'BMR Result',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Basal Metabolic Rate',
                    style: headingTextStyle,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The estimated energy your body needs at rest '
                    'to maintain basic functions.',
                    style: secondaryTextStyle,
                  ),
                  const SizedBox(height: 24),

                  // Display the main BMR result.
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estimated BMR',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _formatValue(bmr),
                          style: resultNumberStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _unit,
                          style: const TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: borderColor),
                        const SizedBox(height: 8),
                        Text(
                          'Formula: $formulaName',
                          style: const TextStyle(
                            fontSize: 13,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Daily Calorie Needs',
                    style: sectionTitleStyle,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Estimated daily energy needs based on '
                    'activity level.',
                    style: secondaryTextStyle,
                  ),
                  const SizedBox(height: 16),

                  // Display the activity-level results table.
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        _tableHeader(),
                        for (int i = 0; i < activityLevels.length; i++)
                          _activityRow(activityLevels[i], i),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    'Daily energy needs are estimates and may vary '
                    'depending on individual body conditions and '
                    'activity levels.',
                    style: secondaryTextStyle,
                  ),

                  const SizedBox(height: 24),

                  // Return to the input form.
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: const BorderSide(color: primaryColor),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text('Back to Calculator'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build the table header.
  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFEDF2EC),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              'Activity Level',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: headingColor,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Calories',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: headingColor,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build a row for each activity level.
  Widget _activityRow(ActivityLevel activity, int index) {
    final dailyCalories = bmr * activity.multiplier;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.name,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.description,
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              _formatValue(dailyCalories),
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: headingColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

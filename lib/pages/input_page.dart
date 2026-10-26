
import 'package:flutter/material.dart';

import '../calculator.dart';
import '../constants.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bodyFatController = TextEditingController();

  Gender _gender = Gender.male;
  BMRFormula _formula = BMRFormula.mifflinStJeor;
  bool _useKilojoules = false;
  bool _showSettings = false;

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _bodyFatController.dispose();
    super.dispose();
  }

  // Validate numeric input.
  String? _validateNumber(
    String? value, {
    required String fieldName,
    required double minimum,
    required double maximum,
    bool isInteger = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }

    final number = double.tryParse(value.trim());

    if (number == null || !number.isFinite) {
      return 'Please enter a valid number.';
    }

    if (isInteger && number != number.roundToDouble()) {
      return 'Please enter a whole number.';
    }

    if (number < minimum || number > maximum) {
      return '$fieldName must be between '
          '${minimum.toInt()} and ${maximum.toInt()}.';
    }

    return null;
  }

  // Read form data and navigate to the result page.
  void _calculate() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final age = int.parse(_ageController.text.trim());
    final height = double.parse(_heightController.text.trim());
    final weight = double.parse(_weightController.text.trim());

    final bodyFat = _formula == BMRFormula.katchMcArdle
        ? double.parse(_bodyFatController.text.trim())
        : null;

    final calculator = BMRCalculator(
      weight: weight,
      height: height,
      age: age,
      gender: _gender,
      formula: _formula,
      bodyFatPercentage: bodyFat,
    );

    final bmr = calculator.calculateBMR();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          bmr: bmr,
          formulaName: calculator.getFormulaName(),
          useKilojoules: _useKilojoules,
        ),
      ),
    );
  }

  // Build a label for each input field.
  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(text, style: labelTextStyle),
    );
  }

  // Build a numeric input field.
  Widget _numberField({
    required String label,
    required TextEditingController controller,
    required String fieldName,
    required double minimum,
    required double maximum,
    bool isInteger = false,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(label),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: inputDecoration.copyWith(
            suffixText: suffix,
            hintText: 'Enter $fieldName',
          ),
          validator: (value) => _validateNumber(
            value,
            fieldName: fieldName,
            minimum: minimum,
            maximum: maximum,
            isInteger: isInteger,
          ),
        ),
      ],
    );
  }

  // Build a gender selection option.
  Widget _genderOption({
    required Gender gender,
    required String label,
  }) {
    final selected = _gender == gender;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          setState(() {
            _gender = gender;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEDF2EC) : surfaceColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: selected ? primaryColor : borderColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 18,
                color: selected ? primaryColor : secondaryTextColor,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: selected ? headingColor : textColor,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 28,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BMR Calculator',
                      style: headingTextStyle,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Calculate your body\'s energy needs at rest '
                      'based on your personal data.',
                      style: secondaryTextStyle,
                    ),
                    const SizedBox(height: 28),

                    _fieldLabel('Gender'),
                    Row(
                      children: [
                        _genderOption(
                          gender: Gender.male,
                          label: 'Male',
                        ),
                        const SizedBox(width: 12),
                        _genderOption(
                          gender: Gender.female,
                          label: 'Female',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _numberField(
                      label: 'Age',
                      controller: _ageController,
                      fieldName: 'age',
                      minimum: 15,
                      maximum: 80,
                      isInteger: true,
                      suffix: 'years',
                    ),
                    const SizedBox(height: 20),

                    _numberField(
                      label: 'Height',
                      controller: _heightController,
                      fieldName: 'height',
                      minimum: 100,
                      maximum: 250,
                      suffix: 'inches',
                    ),
                    const SizedBox(height: 20),

                    _numberField(
                      label: 'Weight',
                      controller: _weightController,
                      fieldName: 'weight',
                      minimum: 20,
                      maximum: 400,
                      suffix: 'lbs',
                    ),
                    const SizedBox(height: 20),

                    InkWell(
                      onTap: () {
                        setState(() {
                          _showSettings = !_showSettings;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.tune,
                              size: 19,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Settings',
                              style: TextStyle(
                                color: headingColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              _showSettings
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: secondaryTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_showSettings) ...[
                      const Divider(color: borderColor),
                      const SizedBox(height: 12),

                      _fieldLabel('BMR Formula'),
                      DropdownButtonFormField<BMRFormula>(
                        initialValue: _formula,
                        isExpanded: true,
                        decoration: inputDecoration,
                        items: const [
                          DropdownMenuItem(
                            value: BMRFormula.mifflinStJeor,
                            child: Text('Mifflin-St Jeor'),
                          ),
                          DropdownMenuItem(
                            value: BMRFormula.revisedHarrisBenedict,
                            child: Text('Revised Harris-Benedict'),
                          ),
                          DropdownMenuItem(
                            value: BMRFormula.katchMcArdle,
                            child: Text('Katch-McArdle'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _formula = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 18),

                      _fieldLabel('Results Unit'),
                      DropdownButtonFormField<bool>(
                        initialValue: _useKilojoules,
                        decoration: inputDecoration,
                        items: const [
                          DropdownMenuItem(
                            value: false,
                            child: Text('Calories (kcal/day)'),
                          ),
                          DropdownMenuItem(
                            value: true,
                            child: Text('Kilojoules (kJ/day)'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _useKilojoules = value;
                            });
                          }
                        },
                      ),

                      if (_formula == BMRFormula.katchMcArdle) ...[
                        const SizedBox(height: 18),
                        _numberField(
                          label: 'Body Fat Percentage',
                          controller: _bodyFatController,
                          fieldName: 'body fat percentage',
                          minimum: 1,
                          maximum: 75,
                          suffix: '%',
                        ),
                      ],
                      const SizedBox(height: 12),
                    ],

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: calculateButtonStyle,
                        onPressed: _calculate,
                        child: const Text(
                          'Calculate BMR',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    const Text(
                      'Note: Results are estimates and are not a '
                      'substitute for professional medical advice.',
                      style: secondaryTextStyle,
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

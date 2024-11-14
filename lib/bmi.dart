import 'package:flutter/material.dart';
import 'dart:math';

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  double height = 0.0;
  double weight = 0.0;
  int age = 0;
  bool isMale = true;
  double bmiResult = 0.0;
  String bmiCategory = '';
  Color categoryColor = Colors.green;

  TextEditingController heightController = TextEditingController(text: '0');
  TextEditingController weightController = TextEditingController(text: '0');
  TextEditingController ageController = TextEditingController(text: '0');

  void calculateBMI() {
    setState(() {
      bmiResult = weight / pow(height / 100, 2);

      if (bmiResult < 16.0) {
        bmiCategory = 'Severely Underweight';
        categoryColor = Colors.blue[900]!;
      } else if (bmiResult < 17) {
        bmiCategory = 'Underweight';
        categoryColor = Colors.blue;
      } else if (bmiResult < 25) {
        bmiCategory = 'Normal';
        categoryColor = Colors.green;
      } else if (bmiResult < 30) {
        bmiCategory = 'Overweight';
        categoryColor = Colors.orange;
      } else if (bmiResult < 35) {
        bmiCategory = 'Obese Class I';
        categoryColor = Colors.deepOrange;
      } else if (bmiResult < 40) {
        bmiCategory = 'Obese Class II';
        categoryColor = Colors.red;
      } else {
        bmiCategory = 'Obese Class III';
        categoryColor = Colors.red[900]!;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    calculateBMI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E2A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Lingkaran hasil BMI
            Container(
              height: 200,
              child: CustomPaint(
                size: Size(double.infinity, 10),
                painter: BMIGaugePainter(
                  bmiValue: bmiResult,
                  categoryColor: categoryColor,
                ),
              ),
            ),
            // Menampilkan nilai BMI
            
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bmiCategory,
                  style: TextStyle(
                    fontSize: 24,
                    color: categoryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 24),
            _buildBMIScaleLegend(),
            SizedBox(height: 24),
            _buildGenderSelector(),
            SizedBox(height: 16),
            _buildAgeSelector(),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputCard(
                    'Height',
                    heightController,
                    'cm',
                    onChanged: (value) {
                      setState(() {
                        height = double.tryParse(value) ?? height;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputCard(
                    'Weight',
                    weightController,
                    'kg',
                    onChanged: (value) {
                      setState(() {
                        weight = double.tryParse(value) ?? weight;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Calculate BMI'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard(
    String label,
    TextEditingController controller,
    String unit, {
    required Function(String) onChanged,
  }) {
    return Card(
      color: Color(0xFF272A4D),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  width: 80,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFF272A4D),
                    ),
                    onChanged: onChanged,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  unit,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Card(
      color: Color(0xFF272A4D),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Gender',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGenderButton(
                  icon: Icons.male,
                  label: 'Male',
                  isSelected: isMale,
                  onTap: () => setState(() {
                    isMale = true;
                  }),
                ),
                _buildGenderButton(
                  icon: Icons.female,
                  label: 'Female',
                  isSelected: !isMale,
                  onTap: () => setState(() {
                    isMale = false;
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeSelector() {
    return Card(
      color: Color(0xFF272A4D),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Age',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFF272A4D),
              ),
              onChanged: (value) {
                setState(() {
                  age = int.tryParse(value) ?? age;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIScaleLegend() {
    return Column(
      children: [
        _buildBMIScaleRow('Severely Underweight', Colors.blue[900]!),
        _buildBMIScaleRow('Underweight', Colors.blue),
        _buildBMIScaleRow('Normal', Colors.green),
        _buildBMIScaleRow('Overweight', Colors.orange),
        _buildBMIScaleRow('Obese Class I', Colors.deepOrange),
        _buildBMIScaleRow('Obese Class II', Colors.red),
        _buildBMIScaleRow('Obese Class III', Colors.red[900]!),
      ],
    );
  }

  Widget _buildBMIScaleRow(String category, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}

class BMIGaugePainter extends CustomPainter {
  final double bmiValue;
  final Color categoryColor;

  BMIGaugePainter({required this.bmiValue, required this.categoryColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = categoryColor
      ..style = PaintingStyle.fill;

    // Lingkaran yang menggambarkan BMI
    double radius = size.width / 3;
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    // Gambar angka BMI di tengah lingkaran
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: bmiValue.toStringAsFixed(1),
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width);

    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

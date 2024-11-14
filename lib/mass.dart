import 'package:flutter/material.dart';

class WeightConverterPage extends StatefulWidget {
  @override
  _WeightConverterPageState createState() => _WeightConverterPageState();
}

class _WeightConverterPageState extends State<WeightConverterPage> {
  String _selectedUnit = 'Kg';
  final TextEditingController _controller = TextEditingController();

  // Hasil konversi
  double _tonResult = 0;
  double _kgResult = 0;
  double _gramResult = 0;
  double _quintalResult = 0;

  // List untuk dropdown
  final List<String> _units = ['Ton', 'Kg', 'Gram', 'Kuintal'];

  void _convertWeight() {
    setState(() {
      if (_controller.text.isEmpty) {
        _resetResults();
        return;
      }

      double input = double.tryParse(_controller.text) ?? 0;

      // Konversi ke gram terlebih dahulu sebagai unit dasar
      double inGrams;
      switch (_selectedUnit) {
        case 'Ton':
          inGrams = input * 1000000; // 1 ton = 1,000,000 gram
          break;
        case 'Kg':
          inGrams = input * 1000; // 1 kg = 1,000 gram
          break;
        case 'Gram':
          inGrams = input;
          break;
        case 'Kuintal':
          inGrams = input * 100000; // 1 kuintal = 100,000 gram
          break;
        default:
          inGrams = 0;
      }

      // Konversi dari gram ke semua unit
      _tonResult = inGrams / 1000000;
      _kgResult = inGrams / 1000;
      _gramResult = inGrams;
      _quintalResult = inGrams / 100000;
    });
  }

  void _resetResults() {
    setState(() {
      _tonResult = 0;
      _kgResult = 0;
      _gramResult = 0;
      _quintalResult = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Conversion'),
        centerTitle: true,
        backgroundColor: Colors.blue, // Set background to blue
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Section
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Masukkan Nilai',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Change color to black
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Masukkan angka',
                            ),
                            style: TextStyle(color: Colors.black), // Change text color to black
                            onChanged: (value) {
                              _convertWeight();
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedUnit,
                              isExpanded: true,
                              underline: SizedBox(),
                              dropdownColor: Colors.blue.shade900, // Set dropdown background to blue
                              items: _units.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black), // Change text color to black
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedUnit = newValue!;
                                  _convertWeight();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Results Section
            Text(
              'Hasil Konversi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900, // Contrast color for text
              ),
            ),
            SizedBox(height: 16),
            // Result Boxes aligned in two columns (left and right)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildResultBox('Ton', _tonResult)),
                SizedBox(width: 16),
                Expanded(child: _buildResultBox('Kilogram', _kgResult)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildResultBox('Gram', _gramResult)),
                SizedBox(width: 16),
                Expanded(child: _buildResultBox('Kuintal', _quintalResult)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBox(String unit, double value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              unit,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value.toStringAsFixed(4),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade900, // Contrast color for text
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

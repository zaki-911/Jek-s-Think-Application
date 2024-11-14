import 'package:flutter/material.dart';

class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  double _discountedPrice = 0;
  bool _isResultVisible = false;

  // Function to calculate the discounted price
  void _calculateDiscount() {
    double price = double.tryParse(_priceController.text) ?? 0;
    double discountPercentage = double.tryParse(_discountController.text) ?? 0;

    // Calculating the discounted price
    double discountAmount = (price * discountPercentage) / 100;
    setState(() {
      _discountedPrice = price - discountAmount;
      _isResultVisible = true; // Show result when calculation is done
    });
  }

  // Function to format the result as currency
  String _formatCurrency(double value) {
    return value.toStringAsFixed(2); // Show result with 2 decimal places
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discount Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blue, // Set background color to blue
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
                      'Enter the Item Price',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Change label color to black
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter price',
                        hintStyle: TextStyle(color: Colors.black), // Change hint color to black
                      ),
                      style: TextStyle(color: Colors.black), // Change text input color to black
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Enter Discount Percentage',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Change label color to black
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _discountController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter discount percentage',
                        hintStyle: TextStyle(color: Colors.black), // Change hint color to black
                      ),
                      style: TextStyle(color: Colors.black), // Change text input color to black
                    ),
                    SizedBox(height: 16),
                    // Show Result Button
                    ElevatedButton(
                      onPressed: _calculateDiscount,
                      child: Text('Show Result'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue, // Button color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Results Section (Visible only after pressing the button)
            if (_isResultVisible)
              Text(
                'Discounted Price:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            if (_isResultVisible) SizedBox(height: 16),
            // Result Box
            if (_isResultVisible)
              Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white, // White background for result box
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Final Price After Discount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Change text color to black
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '\$${_formatCurrency(_discountedPrice)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // Change text color to black
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }
}

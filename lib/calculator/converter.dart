import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String _selectedConversion = 'Length';
  String _fromUnit = 'Meters';
  String _toUnit = 'Kilometers';
  double _inputValue = 0.0;
  double _convertedValue = 0.0;

  final Map<String, List<String>> _units = {
    'Length': ['Meters', 'Kilometers', 'Feet', 'Miles'],
    'Weight': ['Kilograms', 'Grams', 'Pounds', 'Ounces'],
  };

  final Map<String, double> _conversionFactors = {
    'Meters to Kilometers': 0.001,
    'Kilometers to Meters': 1000.0,
    'Feet to Miles': 0.000189394,
    'Miles to Feet': 5280.0,
    'Kilograms to Grams': 1000.0,
    'Grams to Kilograms': 0.001,
    'Pounds to Ounces': 16.0,
    'Ounces to Pounds': 0.0625,
  };

  void _convert() {
    String conversionKey = '$_fromUnit to $_toUnit';
    setState(() {
      _convertedValue = _inputValue * (_conversionFactors[conversionKey] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
        backgroundColor: const Color.fromARGB(255, 206, 128, 154),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Convert',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedConversion,
              items: _units.keys.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedConversion = newValue!;
                  _fromUnit = _units[_selectedConversion]![0];
                  _toUnit = _units[_selectedConversion]![1];
                });
              },
              decoration: InputDecoration(
                labelText: 'Conversion Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromUnit,
                    items: _units[_selectedConversion]!.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromUnit = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'From Unit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toUnit,
                    items: _units[_selectedConversion]!.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _toUnit = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'To Unit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Input Value',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.black, // Use backgroundColor
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Value: $_convertedValue',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

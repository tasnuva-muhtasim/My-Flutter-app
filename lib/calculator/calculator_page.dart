import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'converter.dart';
import 'history_model.dart';
import 'history_page.dart';
import 'package:provider/provider.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '';
  TextEditingController _xController = TextEditingController();
  TextEditingController _yController = TextEditingController();

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '⌫') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (buttonText == '=') {
        _calculateResult();
      } else {
        _expression += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      _result = eval.toString();

      // Add the calculation to history
      Provider.of<HistoryModel>(context, listen: false).addCalculation('$_expression = $_result');
    } catch (e) {
      _result = 'Error';
    }
  }

  Widget _buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: color,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildGraphSection() {
    return Column(
      children: [
        TextField(
          controller: _xController,
          decoration: InputDecoration(labelText: 'Enter x value'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        TextField(
          controller: _yController,
          decoration: InputDecoration(labelText: 'Enter y value'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        ElevatedButton(
          onPressed: () {
            _plotGraph();
          },
          child: Text('Plot Graph'),
        ),
      ],
    );
  }

  void _plotGraph() {
    double? x = double.tryParse(_xController.text);
    double? y = double.tryParse(_yController.text);

    if (x != null && y != null) {
      // Navigate to graph page and pass x and y values
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GraphPage(x: x, y: y)),
      );
    } else {
      // Show error message if values are not entered
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter values for x and y to plot the graph.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(), // Back button
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
            Text('Scientific Calculator'), // Title
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 48, color: Colors.black),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('C', color: Colors.red),
                    _buildButton('⌫', color: Colors.blue),
                    _buildButton('%', color: Colors.blue),
                    _buildButton('÷', color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('×', color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-', color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('+', color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('=', color: Colors.green),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('sin', color: Colors.orange),
                    _buildButton('cos', color: Colors.orange),
                    _buildButton('tan', color: Colors.orange),
                    _buildButton('log', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('sqrt', color: Colors.orange),
                    _buildButton('^', color: Colors.orange),
                    _buildButton('(', color: Colors.orange),
                    _buildButton(')', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ConverterPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.purple,
                          ),
                          child: Text(
                            'Convert',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Graph Section',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                _buildGraphSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GraphPage extends StatelessWidget {
  final double x;
  final double y;

  const GraphPage({Key? key, required this.x, required this.y}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graph'),
      ),
      body: Center(
        child: Text('Graph plotting for x = $x and y = $y'),
      ),
    );
  }
}

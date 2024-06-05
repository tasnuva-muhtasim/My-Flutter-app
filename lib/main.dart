import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'about/about_page.dart';
import 'calculator/calculator_page.dart';
import 'weather/weather_page.dart';
import 'quiz/quiz_page.dart';
import 'profile/profile_page.dart';
import 'calculator/history_model.dart';
import 'profile/profile_model.dart';
import 'quiz/quiz_model.dart';
import 'weather/weather_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeModel()),
        ChangeNotifierProvider(create: (context) => QuizModel()),
        ChangeNotifierProvider(create: (context) => WeatherModel()), // Add this line
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            title: 'My Flutter App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: MainPage(),
            routes: {
              '/about': (context) => AboutPage(),
              '/calculator': (context) => CalculatorPage(),
              '/weather': (context) => WeatherPage(),
              '/quiz': (context) => QuizPage(),
              '/profile': (context) => ProfilePage(),
            },
          );
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePage(),
    CalculatorPage(),
    WeatherPage(),
    QuizPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeModel>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 119, 72, 163),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          HomeCard(
            title: 'About Info',
            icon: Icons.info,
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          HomeCard(
            title: 'Scientific Calculator',
            icon: Icons.calculate,
            onTap: () => Navigator.pushNamed(context, '/calculator'),
          ),
          HomeCard(
            title: 'Weather App',
            icon: Icons.cloud,
            onTap: () => Navigator.pushNamed(context, '/weather'),
          ),
          HomeCard(
            title: 'Quiz App',
            icon: Icons.quiz,
            onTap: () => Navigator.pushNamed(context, '/quiz'),
          ),
          HomeCard(
            title: 'Profile',
            icon: Icons.person,
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  HomeCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40.0, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

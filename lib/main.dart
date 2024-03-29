import 'package:flutter/material.dart';
import 'package:apod/pages/main_page.dart';
import 'package:apod/pages/calendar_page.dart';
import 'package:apod/pages/favorite_page.dart';
import 'package:apod/model/favorite_state.dart';
import 'package:provider/provider.dart';
import 'package:apod/model/daily_apod_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue, foregroundColor: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // text color
                  backgroundColor: Colors.blue))),
      home: const MyHomePage(),
    );
  }
}

enum NoteType {
  text,
  editable,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': '月曆',
      'widget': const CalendarPage(),
    },
    {
      'title': '今日照片',
      'widget': const MainPage(),
    },
    {
      'title': '我的收藏',
      'widget': const FavoritePage(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title']),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) =>
                FavoriteState(), // 在主要頁面的上層放了 FavoriteList 作為三個頁面都可共用的state
          ),
          ChangeNotifierProvider(create: (context) => DailyApodState())
        ],
        child: _pages[_selectedIndex]['widget'],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: '月曆'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '主頁'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定')
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

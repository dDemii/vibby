// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication package
import 'package:table_calendar/table_calendar.dart'; // Import calendar package
import 'package:intl/intl.dart'; // For date formatting

void main() {
  runApp(VibbyApp());
}

class VibbyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibby App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 100),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/vibby logo.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 100),
              Text(
                'Vibby',
                style: TextStyle(
                  color: Color(0xFF200D3C),
                  fontSize: 32,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiaryPage()),
                  );
                },
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MoodSelectionWidget
class MoodSelectionWidget extends StatelessWidget {
  final Function(String) onMoodSelected;

  MoodSelectionWidget({required this.onMoodSelected});

  final List<String> moodImages = [
    "assets/mood/meh.png",
    "assets/mood/happy.png",
    "assets/mood/sad.png",
    "assets/mood/angry.png",
  ];

  final List<String> moodLabels = [
    'Meh',
    'Happy',
    'Sad',
    'Angry',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 450,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFFF8F8F8)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 20),
          Text(
            'How are you feeling today?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20.0,
            runSpacing: 20.0,
            children: List.generate(
              moodImages.length,
              (index) => _buildMoodItem(moodImages[index], moodLabels[index]),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the bottom sheet
            },
            child: Text('Save Mood'),
          ),
          SizedBox(height: 20),
        ]));
  }

  Widget _buildMoodItem(String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        onMoodSelected(label); // Pass the selected mood back to the caller
        print('Selected mood: $label');
      },
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// DiaryPage
class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 15.0), // Adjust the left padding as needed
          child: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Image.asset(
              "assets/vibby logo.png", // Replace with your Vibby logo image path
              width: 50, // Set the width as needed
              height: 50, // Set the height as needed
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DiaryPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.groups),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VirtualSupportGroupPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: DiaryContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              // Handle navigation to Diary Main Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DiaryPage(),
                ),
              );
              break;
            case 1:
              // Handle navigation to Diary To-Do Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DiaryPage(),
                ),
              );
              break;
            case 2:
              // Handle navigation to Diary Logs Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DiaryPage(),
                ),
              );
              break;
          }
        },
        selectedFontSize: 12,
        unselectedFontSize: 10,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'To-Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Logs',
          ),
        ],
      ),
    );
  }
}

class DiaryContent extends StatefulWidget {
  @override
  _DiaryContentState createState() => _DiaryContentState();
}

class _DiaryContentState extends State<DiaryContent> {
  late DateTime _selectedDate;
  late Map<DateTime, String> moodData = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });
    _showDiaryEntryPopup();
  }

  void _showDiaryEntryPopup() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MoodSelectionWidget(
          onMoodSelected: (selectedMood) {
            moodData[_selectedDate] = selectedMood;
            setState(() {});
            Navigator.of(context).pop();
          },
        );
      },
    ).then((value) {
      if (value == 'addEntry') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AddDiaryEntryPage(selectedDate: _selectedDate),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.9, // Adjust the width here
            child: TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime.now(),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              rowHeight: 50, // Adjust the height of each row
              headerStyle: HeaderStyle(
                formatButtonVisible: false, // Hide the format button
              ),
              onDaySelected: _onDaySelected,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (moodData[date] != null) {
                    return Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green, // Change color based on mood
                        shape: BoxShape.circle,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) =>
                    AddDiaryEntryPage(selectedDate: DateTime.now())),
              ),
            );
          },
          icon: Icon(Icons.add_box_rounded),
          iconSize: 40, // Adjust the icon size as needed
          color: const Color.fromARGB(255, 0, 0, 0), // Change the icon color
        ),
      ],
    );
  }
}

class AddDiaryEntryPage extends StatelessWidget {
  final DateTime selectedDate;

  AddDiaryEntryPage({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Diary Entry'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back), // Replace with Vibby logo if needed
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEEE, MMMM d, y').format(selectedDate),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Enter your diary entry...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Logic to save the diary entry
              Navigator.of(context).pop();
            },
            child: Text('Save Diary Entry'),
          ),
        ],
      ),
    );
  }
}

//Virtual Support Group
class VirtualSupportGroupPage extends StatefulWidget {
  @override
  _VirtualSupportGroupPageState createState() =>
      _VirtualSupportGroupPageState();
}

class _VirtualSupportGroupPageState extends State<VirtualSupportGroupPage> {
  int _currentIndex = 0; // Track the current index of the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Support Group'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Adjust spacing as needed
            _buildContactsSection(), // My Contacts section
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedFontSize: 12, // Adjust the font size for selected tab labels
        unselectedFontSize:
            10, // Adjust the font size for unselected tab labels
        iconSize: 20, // Adjust the size of the icons
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'My Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Group',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
          ),
        ],
      ),
    );
  }

  Widget _buildContactsSection() {
    return Container(
      width: 325,
      height: 490,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildContactItem(
            name: 'Core Group',
            image: AssetImage('assets/core.png'), // Replace with image asset
          ),
          _buildContactItem(
            name: 'Tactics GC',
            image: AssetImage('assets/tactics.png'), // Replace with image URL
          ),
          _buildContactItem(
            name: 'Nadine Beshy',
            image: AssetImage('assets/nadine.png'), // Replace with image URL
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
      {required String name, required ImageProvider<Object> image}) {
    return Container(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  width: 1,
                  color: Color(0xFFCCCCCC),
                ),
              ),
            ),
          ),
          Positioned(
            left: 35,
            top: 110,
            child: Opacity(
              opacity: 0.70,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 38,
            top: 24,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your Profile Settings page
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
      ),
      body: Center(
        child: Text('Profile Settings Page'),
      ),
    );
  }
}

class PasscodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your Passcode page
    return Scaffold(
      appBar: AppBar(
        title: Text('Passcode'),
      ),
      body: Center(
        child: Text('Passcode Page'),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication package
import 'package:table_calendar/table_calendar.dart'; // Import calendar package
import 'package:intl/intl.dart'; // For date formatting
import 'package:carousel_slider/carousel_slider.dart';

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

//
// SPLASH SCREEN
//

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

//
// MoodSelectionWidget
//

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

//
// DiaryPage
//

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
                  builder: (context) => Todo(),
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

//
// DIARY CONTENT
//

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

//
// DIARY ENTRY
//

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

//
//Virtual Support Group
//

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
      body: _getBodyContent(),
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
            label: 'Find Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
          ),
        ],
      ),
    );
  }

  Widget _getBodyContent() {
    switch (_currentIndex) {
      case 0:
        return _buildContactsSection(); // Show contacts section for index 0
      case 1:
        return FindGroupsContent(); // Show Find Groups content for index 1
      case 2:
        return Container(); // You can add content for other tabs if needed
      default:
        return Container();
    }
  }

//
// MY CONTACTS
//

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

//
//FIND GROUPS
//

class FindGroupsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430,
      height: 932,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFFF8F8F8)),
      child: Stack(
        children: [
          // Placeholder for a Small Icon or Indicator
          Positioned(
            left: 28,
            top: 100,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/exo.png'), // Replace with your image path
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
                color: Colors
                    .grey, // Replace with desired color or remove for image
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 28,
            top: 226,
            child: Container(
              width: 150,
              height: 24,
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 86,
            top: 230,
            child: Opacity(
              opacity: 0.70,
              child: Text(
                'Kpop',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
// PROFILE SETTINGS
//

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

//
//TODO
//

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          title: const Text('TO-DO LIST'),
          centerTitle: true,
          toolbarTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        body: Column(children: <Widget>[
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(
                    8.0), // Optional: Add padding for better visual appearance
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromARGB(
                      255, 30, 12, 59), // Set your desired background color
                ),
                child: const Center(
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 18.0, // Set your desired font size
                      fontWeight:
                          FontWeight.bold, // Set your desired font weight
                      color: Colors.white, // Set your desired text color
                    ),
                  ),
                ),
              ),

              //2nd Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(
                    8.0), // Optional: Add padding for better visual appearance
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white, // Set your desired background color
                    border: Border.all(
                      color: const Color.fromARGB(255, 30, 12, 59),
                    )),
                child: const Center(
                  child: Text(
                    'Important',
                    style: TextStyle(
                      fontSize: 18.0, // Set your desired font size
                      fontWeight:
                          FontWeight.bold, // Set your desired font weight
                      color: Colors.black, // Set your desired text color
                    ),
                  ),
                ),
              ),

              //3rd Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(
                    8.0), // Optional: Add padding for better visual appearance
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white, // Set your desired background color
                    border: Border.all(
                      color: const Color.fromARGB(255, 30, 12, 59),
                    )),
                child: const Center(
                  child: Text(
                    'Org Task',
                    style: TextStyle(
                      fontSize: 18.0, // Set your desired font size
                      fontWeight:
                          FontWeight.bold, // Set your desired font weight
                      color: Colors.black, // Set your desired text color
                    ),
                  ),
                ),
              ),

              //4th Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(
                    8.0), // Optional: Add padding for better visual appearance
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white, // Set your desired background color
                  border: Border.all(
                    color: const Color.fromARGB(255, 30, 12, 59),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'My Lectures',
                    style: TextStyle(
                      fontSize: 18.0, // Set your desired font size
                      fontWeight:
                          FontWeight.bold, // Set your desired font weight
                      color: Colors.black, // Set your desired text color
                    ),
                  ),
                ),
              ),

              //5th Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(
                    8.0), // Optional: Add padding for better visual appearance
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white, // Set your desired background color
                    border: Border.all(
                      color: const Color.fromARGB(255, 30, 12, 59),
                    )),
                child: const Center(
                  child: Text(
                    'Arya\'s List',
                    style: TextStyle(
                      fontSize: 18.0, // Set your desired font size
                      fontWeight:
                          FontWeight.bold, // Set your desired font weight
                      color: Colors.black, // Set your desired text color
                    ),
                  ),
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 60.0,
              enlargeCenterPage: false,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.35,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                color: Color.fromARGB(255, 68, 117, 157),
                child: SizedBox(
                  width: 150,
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                    child: Text(
                      'Important',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                color: Color.fromARGB(255, 224, 143, 232),
                child: SizedBox(
                  width: 150,
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                    child: Text(
                      'Org Tasks',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]));
  }
}

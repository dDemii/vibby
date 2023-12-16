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
      debugShowCheckedModeBanner: false,
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
  const SplashScreen({super.key});

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
  final Color tabIndicatorColor = Color(0xFF5C00A4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(
                  'assets/vibby logo.png'), // Replace with your Vibby logo image asset
            ),
            Spacer(), // Spacer to push icons to the right
            buildTabItem(Icons.home, 0), // Home icon representing Diary
            SizedBox(width: 15), // Add some space between icons
            buildTabItem(Icons.groups, 1), // Support Group icon
            SizedBox(width: 15), // Add some space between icons
            buildTabItem(Icons.settings, 2), // Settings icon
          ],
        ),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Diary',
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

  Widget buildTabItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index; // Set current index on tab tap
        });
        switch (index) {
          case 0:
            // Handle navigation to Diary Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DiaryPage(),
              ),
            );
            break;
          case 1:
            // Handle navigation to Support Group Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VirtualSupportGroupPage(),
              ),
            );
            break;
          case 2:
            // Handle navigation to Settings Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileSettingsPage(),
              ),
            );
            break;
        }
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: _currentIndex == index
                ? tabIndicatorColor
                : Colors.grey, // Highlight color for active icon
          ),
          Container(
            height: 2,
            width: 30,
            decoration: BoxDecoration(
              color: _currentIndex == index
                  ? tabIndicatorColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: EdgeInsets.only(top: 4),
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
                    String selectedMood = moodData[date]!;

                    // Map mood labels to respective mood images
                    Map<String, String> moodImages = {
                      'Meh': "assets/mood/meh.png",
                      'Happy': "assets/mood/happy.png",
                      'Sad': "assets/mood/sad.png",
                      'Angry': "assets/mood/angry.png",
                      // Add more mappings for different moods if needed
                    };

                    return Center(
                      child: Image.asset(
                        moodImages[selectedMood]!,
                        height: 40, // Adjust the size of the image as needed
                        width: 40,
                      ),
                    );
                  } else {
                    return Container(); // No mood selected for this date
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

class AddDiaryEntryPage extends StatefulWidget {
  final DateTime selectedDate;

  AddDiaryEntryPage({required this.selectedDate});

  @override
  _AddDiaryEntryPageState createState() => _AddDiaryEntryPageState();
}

class _AddDiaryEntryPageState extends State<AddDiaryEntryPage> {
  bool _isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Diary Entry'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed: () {
                    // Logic for the RawMaterialButton (to perform some action)
                  },
                  elevation: 5.0,
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 26,
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                DateFormat('EEEE, MMMM d, y').format(widget.selectedDate),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Record your day ...',
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              onChanged: (value) {
                // Add your logic when text changes in TextFormField
              },
              onTap: () {
                setState(() {
                  _isKeyboardVisible = true;
                });
              },
              onEditingComplete: () {
                setState(() {
                  _isKeyboardVisible = false;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logic for the ElevatedButton (to save the diary entry)
                  Navigator.of(context).pop();
                },
                child: Text('Save Diary Entry'),
              ),
            ),
            SizedBox(height: 80), // Space for bottom navigation
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _isKeyboardVisible
          ? BottomAppBar(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      // Logic for the image icon button
                    },
                    icon: Icon(Icons.image),
                  ),
                  IconButton(
                    onPressed: () {
                      // Logic for the alignment icon button
                    },
                    icon: Icon(Icons.format_align_left),
                  ),
                  IconButton(
                    onPressed: () {
                      // Logic for the check button
                    },
                    icon: Icon(Icons.check),
                  ),
                ],
              ),
            )
          : null,
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

class ConversationPage extends StatelessWidget {
  final String contactName;

  const ConversationPage({Key? key, required this.contactName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('$contactName'), // Display the contact's name in the app bar
      ),
      body: Center(
        child: Text(
            'Conversation with $contactName'), // Placeholder for conversation content
      ),
    );
  }
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
        return ForumContent(); // You can add content for other tabs if needed
      default:
        return Container();
    }
  }

//
// MY CONTACTS
//

  Widget _buildContactsSection() {
    return Padding(
        padding: EdgeInsets.only(
            top: 75.0), // Adjust the top padding for spacing from AppBar
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: 30.0), // Horizontal padding for contacts
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.symmetric(
                  vertical: 10.0), // Vertical padding around contacts
              mainAxisSpacing:
                  10.0, // Adjust the vertical spacing between contacts
              crossAxisSpacing:
                  20.0, // Adjust the horizontal spacing between contacts
              children: [
                _buildContactItem(
                  name: 'Core Group',
                  image: AssetImage('assets/core.png'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConversationPage(contactName: 'Core Group'),
                      ),
                    );
                  },
                ),
                _buildContactItem(
                  name: 'Tactics GC',
                  image: AssetImage('assets/tactics.png'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConversationPage(contactName: 'Tactics GC'),
                      ),
                    );
                  },
                ),
                _buildContactItem(
                  name: 'Nadine Beshy',
                  image: AssetImage('assets/nadine.png'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConversationPage(contactName: 'Nadine'),
                      ),
                    );
                  },
                ),
                _buildContactItem(
                  name: 'A Group',
                  image: AssetImage('assets/a.png'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConversationPage(contactName: 'A Group'),
                      ),
                    );
                  },
                ),
                _buildContactItem(
                  name: 'B Group',
                  image: AssetImage('assets/b.png'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConversationPage(contactName: 'B Group'),
                      ),
                    );
                  },
                ),
                _buildContactItem(
                  name: 'C Group',
                  image: AssetImage('assets/c.png'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConversationPage(contactName: 'C Group'),
                      ),
                    );
                  },
                ),
                // Add more contact items as needed...
              ],
            ),
          ],
        ));
  }

  Widget _buildContactItem({
    required String name,
    required ImageProvider<Object> image,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 75,
        height: 75,
        margin: EdgeInsets.all(10),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
// FORUM
//

class ForumContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 600,
      child: Stack(
        children: [
//section 1

          Positioned(
            left: 20,
            top: 0,
            child: Container(
              width: 400,
              height: 89,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 50,
                    child: SizedBox(
                      width: 400,
                      child: Text(
                        'Explore Community',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

//section 2

          Positioned(
            left: 20,
            top: 120,
            child: Container(
              width: 350,
              height: 75,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 350,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Color(0xFFEFCEFF),
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
                          color: Color(0xFF5C00A4), // Border color
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 275,
                    top: 2,
                    child: Container(
                      width: 70,
                      height: 70,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          // Add your content for this container
                          ),
                      child: Stack(
                        children: [
                          // Add your content for this stack
                          Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: const Color.fromRGBO(92, 0, 164, 1),
                              ),
                              iconSize: 50,
                              onPressed: () {
                                // Add your onPressed functionality here
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 23,
                    top: 28,
                    child: Text(
                      'Care to share some thoughts?',
                      style: TextStyle(
                        color: Color(0xFF200D3C),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

//section 3

          Positioned(
            left: 20,
            top: 220,
            child: Container(
              width: 400,
              height: 74,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: SizedBox(
                      width: 400,
                      child: Text(
                        'Recent Posts',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 39,
                    child: Container(
                      width: 350,
                      height: 35,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 350,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
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
                            left: 47,
                            top: 9,
                            child: Opacity(
                              opacity: 0.50,
                              child: Text(
                                'Search Community',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

//section 4

          Positioned(
            left: 20,
            top: 320,
            child: Container(
              width: 400,
              height: 25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCarouselItem('Trending'),
                  SizedBox(width: 12),

                  _buildCarouselItem('Relapse'),
                  SizedBox(width: 12),

                  _buildCarouselItem('Friendship'),
                  SizedBox(width: 12),

                  _buildCarouselItem('Christmas'),
                  SizedBox(width: 12),
                  // Add content for this stack
                ],
              ),
            ),
          ),

//section 5

          Positioned(
            left: 20,
            top: 370, // Adjust the top position accordingly
            child: Container(
              width: 360,
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 350,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFCCCCCC),
                        ),
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
                    left: 254,
                    top: 6,
                    child: Container(
                      width: 90,
                      height: 22,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 90,
                              height: 22,
                              decoration: BoxDecoration(
                                color: Color(0xFFEFCEFF),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF5C00A4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 3,
                            child: Text(
                              'Christmas',
                              style: TextStyle(
                                color: Color(0xFF5C00A4),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    top: 11,
                    child: Text(
                      'Demi Cutie   21 Nov',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    top: 38,
                    child: Opacity(
                      opacity: 0.50,
                      child: Text(
                        'layuan nyo star ng pasko ko baka kayo masabit ko hmfpx',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 63,
                    child: Container(
                      width: 30,
                      height: 30,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(), // Add your decoration here
                      child: Stack(
                        children: [
                          // Add your content for this stack
                          Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.message,
                                color: const Color.fromRGBO(92, 0, 164, 1),
                              ),
                              iconSize: 20,
                              onPressed: () {
                                // Add your onPressed functionality here
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 63,
                    child: Container(
                      width: 30,
                      height: 30,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(), // Add your decoration here
                      child: Stack(
                        children: [
                          // Add your content for this stack
                          Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: const Color.fromRGBO(92, 0, 164, 1),
                              ),
                              iconSize: 20,
                              onPressed: () {
                                // Add your onPressed functionality here
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(String label) {
    return Container(
      width: 110,
      height: 25,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 100,
              height: 25,
              decoration: BoxDecoration(
                color: Color(0xFFEFCEFF),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: Color(0xFF5C00A4),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 4,
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF5C00A4),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
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

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Image.asset(
              "assets/vibby logo.png",
              width: 50,
              height: 50,
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
      body: Container(
        color: Color(0xFFF9F9F9),
        child: ListView(
          padding: EdgeInsets.only(top: 25),
          children: [
            // Profile Picture with Border
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF5C00A4),
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/me.jpg'),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(height: 20),

            // User Information Container with special styling for the "Edit" button
            SpecialProfileInfoContainer(
              title: 'Name, Username, Birthday, Email, Password',
              buttonText: 'Edit',
              onPressed: () {
                // Implement edit functionality
              },
            ),

            // How you use Vibby
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF5C00A4),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Text
                  Text(
                    'How you use Vibby',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Row for the icons and text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // First Column (left-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.notifications),
                          Icon(Icons.edit),
                          Icon(Icons.history),
                        ],
                      ),
                      SizedBox(width: 8),
                      // Second Column (left-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Notifications'),
                          Text('Customize'),
                          Text('Session History'),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      // Third Column (right-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.chevron_right),
                          Icon(Icons.chevron_right),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // More info and support
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF5C00A4),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Text
                  Text(
                    'More info and support',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Row for the icons and text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // First Column (left-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.help),
                          Icon(Icons.info),
                        ],
                      ),
                      SizedBox(width: 8),
                      // Second Column (left-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Help'),
                          Text('About'),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      // Third Column (right-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.chevron_right),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sign Out Button (moved to the bottom)
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  // Implement sign-out functionality
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF5C00A4),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Ensure the same radius here
                  ),
                ),
                child: Text('Sign Out', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialProfileInfoContainer extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  const SpecialProfileInfoContainer({
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFF5C00A4),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SpecialProfileInfoContent(
        title: title,
        buttonText: buttonText,
        onPressed: onPressed,
      ),
    );
  }
}

class SpecialProfileInfoContent extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  const SpecialProfileInfoContent({
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Stack(
        children: [
          // Row for the first two columns
          Row(
            children: [
              // First Column
              Flexible(
                flex: 3, // Adjust the flex value as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      title.split(', ').map((item) => Text(item)).toList(),
                ),
              ),
              // Space between columns
              SizedBox(width: 8), // Adjusted the spacing here
              // Second Column
              Flexible(
                flex: 5, // Adjust the flex value as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Maria Joana Mae'),
                    Text('mariyaA192'),
                    Text('December 24, 2000'),
                    Text('mariajoanamae@gmail.com'),
                    Text('M*************'),
                  ],
                ),
              ),
            ],
          ),
          // Edit Button in the third column
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF5C00A4),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Color(0xFF5C00A4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
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
/*
class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
          child: Text(
            'Hello there, Maria Joana Mae',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 360,
            child: CarouselSlider(
              items: [
                // 1st Image of Slider
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page for the 'All' category
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Todo()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 6, 6, 6),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xFF370047),
                    ),
                    child: const Center(
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // 2nd Image of Slider
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page for the 'Important' category
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImportantPage()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 6, 6, 6),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 30, 12, 59),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Important',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // 3rd Image of Slider
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page for the 'Org Task' category
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrgTask()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 6, 6, 6),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 30, 12, 59),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Org Task',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // 4th Image of Slider
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page for the 'My Lectures' category
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyLectures()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 6, 6, 6),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 30, 12, 59),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Lectures',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // 5th Image of Slider
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page for the 'Arya's List' category
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyList()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 6, 6, 6),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 30, 12, 59),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Arya\'s List',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 60.0,
                enlargeCenterPage: false,
                autoPlay: false,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.34,
                initialPage: 1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImportantPage()),
                  );
                },
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.white,
                  margin: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                  color: const Color(0xFF8E9CD5),
                  child: SizedBox(
                    width: 180,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.horizontal_rule_rounded,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 15), // Adjust the padding here
                                    child: Text(
                                      'Important',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0), // Adjust the padding here
                                    child: Text(
                                      'Updated 2h ago',
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Color(
                                      0xFFA6B7F7), // Choose your desired background color
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.star,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 5, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Buy Food'),
                                  Text('Invest'),
                                  Text('Deposit Money'),
                                  Text('Gym'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrgTask()),
                  );
                },
                child: const Card(
                  elevation: 50,
                  shadowColor: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 10, 5, 5),
                  color: Color(0xFFBB9CC0),
                  child: SizedBox(
                    width: 140,
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 5, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Org Tasks',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '11/08/2023',
                          ),
                          SizedBox(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 5, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Permits'),
                                  Text('IGPs'),
                                  Text('Photoshoot'),
                                  Text('Budget'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyLectures()),
                  );
                },
                child: const Card(
                  elevation: 50,
                  shadowColor: Colors.white,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  color: Color(0xFFBECCFF),
                  child: SizedBox(
                    width: 350,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        'My Lectures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyList()),
                  );
                },
                child: const Card(
                  elevation: 50,
                  shadowColor: Colors.white,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  color: Color(0xFFBECCFF),
                  child: SizedBox(
                    width: 350,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        'Arya\'s List',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty Page'),
      ),
      body: const Center(
        child: Text('This is an empty page.'),
      ),
    );
  }
}


class ImportantPage extends StatelessWidget {
  const ImportantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: const Text('Important'),
        toolbarTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16.0), // Add some space between the text and the container
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const TextField(
            maxLines: 15, // Set the number of lines you want
            decoration: InputDecoration(
              hintText: 'Type here...',
            ),
          ),
        ),
      ],
    ),
  ),
),
    );
  }
}

class OrgTask extends StatelessWidget {
  const OrgTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Tasks'),
      ),
      body: const Center(
        child: Text('TACTICS?!.'),
      ),
    );
  }
}

class MyLectures extends StatelessWidget {
  const MyLectures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lectures'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.0),
            Text(
              'List of Your Lectures:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            // Replace the following with your actual lecture content
            LectureItem(title: 'Introduction to Flutter', date: '2023-01-15'),
            LectureItem(title: 'Advanced Dart Programming', date: '2023-02-01'),
            LectureItem(
                title: 'State Management in Flutter', date: '2023-02-15'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the logic for adding a new lecture
          // You can navigate to a new screen or show a dialog for adding lecture details
          // For now, let's print a message
          print('Add Lecture button pressed');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class LectureItem extends StatelessWidget {
  final String title;
  final String date;

  const LectureItem({
    required this.title,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Date: $date'),
        onTap: () {
          // Add your navigation logic here if needed
        },
      ),
    );
  }
}

class MyList extends StatelessWidget {
  const MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arya\'s List'),
      ),
      body: const Center(
        child: Text('Stark Yaarrrn?.'),
      ),
    );
  }
}

class ImportantCardContent extends StatelessWidget {
  const ImportantCardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Important',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Update 2h ago',
        ),
        SizedBox(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 5, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Buy Food'),
                Text('Invest'),
                Text('Deposit Money'),
                Text('Gym'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
*/
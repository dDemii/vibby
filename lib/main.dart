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
                    image: AssetImage("assets/vibby.png"),
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
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        width: double.infinity,
        height: 450,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFFF8F8F8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
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
            SizedBox(height: 20), // Adjusted spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMoodItem(moodImages[0], moodLabels[0]),
                SizedBox(width: 40), // Adjusted spacing
                _buildMoodItem(moodImages[1], moodLabels[1]),
              ],
            ),
            SizedBox(height: 25), // Adjusted spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMoodItem(moodImages[2], moodLabels[2]),
                SizedBox(width: 40), // Adjusted spacing
                _buildMoodItem(moodImages[3], moodLabels[3]),
              ],
            ),
            SizedBox(height: 10), // Adjusted spacing
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the bottom sheet
              },
              child: Text('Save Mood'),
            ),
            SizedBox(height: 10), // Adjusted spacing
          ],
        ),
      ),
    );
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Image.asset(
              "assets/vibby.png",
              width: 50,
              height: 50,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: Color(0xFF5C00A4),
            ),
            iconSize: 35,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Todo(),
                ),
              );
              break;
            case 2:
              // Handle navigation to Diary Logs Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Logs(),
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
            Navigator.push(
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
  TextEditingController _textEditingController = TextEditingController();
  late DateTime _selectedDate;
  bool _isTextCentered = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 7.0), // Adjust the value as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              // Logic for the CIRCLE button (to perform some action)
                            },
                            elevation: 2.5,
                            fillColor: Colors.white,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(10.0),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEEE, MMMM d, y').format(_selectedDate),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed: () {
                              // Logic for editing the date
                              _selectDate(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _textEditingController,
                      maxLines: 10,
                      textAlign:
                          _isTextCentered ? TextAlign.center : TextAlign.start,
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
                  ],
                ),
              ),
            ),
            BottomAppBar(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Logic for the image icon button
                        },
                        icon: Icon(Icons.image),
                      ),
                      IconButton(
                        onPressed: () {
                          // Toggle text alignment between left and center
                          setState(() {
                            _isTextCentered = !_isTextCentered;
                          });
                        },
                        icon: _isTextCentered
                            ? Icon(Icons
                                .format_align_center) // Center alignment icon
                            : Icon(
                                Icons.format_align_left), // Left alignment icon
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // Logic for the check button (save the diary entry)
                      saveDiaryEntry();
                    },
                    icon: Icon(Icons.check),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveDiaryEntry() {
    // Add your logic here to save the diary entry using _textEditingController.text
    print('Diary entry saved: ${_textEditingController.text}');
    Navigator.of(context).pop(); // Close the page after saving
  }

  Future<void> _selectDate(BuildContext context) async {
    // Add your logic to show a date picker and update the _selectedDate
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // Limit to the present or past
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
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

class ConversationPage extends StatefulWidget {
  final String contactName;

  const ConversationPage({Key? key, required this.contactName})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  List<ChatMessage> messages = [];
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Hardcoded initial messages
    messages.add(ChatMessage(text: 'Hello!', isMe: true));
    messages.add(ChatMessage(text: 'Hey!', isMe: false));
    messages.add(ChatMessage(text: 'My name is Wonyoung.', isMe: true));
    messages.add(ChatMessage(
        text: 'Nice to meet you, Wonyoung. Welcome to this conversation!',
        isMe: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactName),
      ),
      body: Column(
        children: [
          // List of Messages
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: messages.map((message) {
                return _buildMessage(
                  isMe: message.isMe,
                  text: message.text,
                );
              }).toList(),
            ),
          ),
          // Input field for typing messages
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildMessage({required bool isMe, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMe) // Show avatar only for messages from the other person
          Container(
            margin:
                EdgeInsets.only(right: 8.0, top: 25.0), // Move the avatar lower
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF5C00A4), width: 1.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.person, // You can use any other icon here
                    color: Color(0xFF5C00A4),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe) // Show sender's name only for messages from the other person
                Text(
                  'Annie Leonhart',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  // Adjust the maxWidth as needed
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isMe ? Color(0xFF5C00A4) : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40.0, // Set the height as needed
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message ...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        BorderSide(color: Color(0xFF5C00A4), width: 1.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0), // Adjust the padding
                ),
                onSubmitted: (message) {
                  _sendMessage(message, true);
                  _messageController.clear();
                },
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Container(
            height: 45.0, // Set the height to match the TextField
            child: IconButton(
              icon: Icon(Icons.send),
              color: Color(0xFF5C00A4), // Set the icon color to purple
              onPressed: () {
                final message = _messageController.text.trim();
                if (message.isNotEmpty) {
                  _sendMessage(message, true);
                  _messageController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text, bool isMe) {
    setState(() {
      messages.add(ChatMessage(text: text, isMe: true));
      // Simulate an immediate response from the other person
      _sendAutomaticResponse();
    });
  }

  void _sendAutomaticResponse() {
    final longMessage =
        'This is a fake response. I am actually not real, but I hope that you\'re doing fine and well!';

    setState(() {
      messages.add(ChatMessage(text: longMessage, isMe: false));
    });
  }
}

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
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
              "assets/vibby.png", // Replace with your Vibby logo image path
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
            icon: Icon(
              Icons.groups,
              color: Color(0xFF5C00A4),
            ),
            iconSize: 35,
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
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            _buildGroup(
              imagePath: 'assets/exo.png',
              groupName: 'Kpop',
              context: context,
            ),
            _buildGroup(
              imagePath: 'assets/kn.jpg',
              groupName: 'KathNiel',
              context: context,
            ),
            _buildGroup(
              imagePath: 'assets/unecs.jpg',
              groupName: 'UNECS',
              context: context,
            ),
            _buildGroup(
              imagePath: 'assets/bits.png',
              groupName: 'BITS',
              context: context,
            ),
            _buildGroup(
              imagePath: 'assets/aldub.jpg',
              groupName: 'Aldub Nation',
              context: context,
            ),
            _buildGroup(
              imagePath: 'assets/franseth.jpg',
              groupName: 'FranSeth',
              context: context,
            ),
            // Add other groups as needed
          ],
        ),
      ),
    );
  }

  Widget _buildGroup({
    required String imagePath,
    required String groupName,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupDescription(
              groupName: groupName,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Color(0xFFCCCCCC),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      groupName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
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

class GroupDescription extends StatelessWidget {
  final String groupName;
  final String imagePath;

  const GroupDescription({
    Key? key,
    required this.groupName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Description'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20),
              Text(
                groupName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Description of $groupName goes here...', // Add actual description
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Color(0xFF5B00A4),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    // Implement your logic here when the button is pressed
                  },
                  child: Text(
                    'Add to My Contacts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
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

//
// FORUM
//

class ForumContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20), // Adjust the initial space

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Explore Community',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),

            SizedBox(height: 20), // Add space between sections

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: screenWidth - 40,
                height: 75,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth - 40,
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
                          color: Color(0xFF5C00A4),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth - 145,
                      top: 2,
                      child: Container(
                        width: 70,
                        height: 70,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: const Color.fromRGBO(92, 0, 164, 1),
                          ),
                          iconSize: 50,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostPage(),
                              ),
                            );
                          },
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
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20), // Add space between sections

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recent Posts',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),

            SizedBox(height: 20), // Add space between sections

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: screenWidth - 40,
                height: 40,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth - 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
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
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 10,
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 0,
                      child: Container(
                        width: screenWidth - 100,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Community',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(120, 0, 0, 0),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCarouselItem('Trending'),
                    SizedBox(width: 12),
                    _buildCarouselItem('Relapse'),
                    SizedBox(width: 12),
                    _buildCarouselItem('Friendship'),
                    SizedBox(width: 12),
                    _buildCarouselItem('Christmas'),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20), // Add space between sections

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: screenWidth - 40,
                height: 100,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth - 40,
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
                    Positioned(
                      left: screenWidth - 146,
                      top: 6,
                      child: Container(
                        width: 90,
                        height: 22,
                        child: Stack(
                          children: [
                            Container(
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
                                  height: 1.2,
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
                          height: 1.2,
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
                            height: 1.2,
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
                    ),
                    Positioned(
                      left: 15,
                      top: 63,
                      child: Container(
                        width: 30,
                        height: 30,
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
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20), // Add space between sections

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: screenWidth - 40,
                height: 100,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth - 40,
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
                    Positioned(
                      left: screenWidth - 146,
                      top: 6,
                      child: Container(
                        width: 90,
                        height: 22,
                        child: Stack(
                          children: [
                            Container(
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
                            Positioned(
                              left: 22,
                              top: 3,
                              child: Text(
                                'Relapse',
                                style: TextStyle(
                                  color: Color(0xFF5C00A4),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
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
                        'Kathryn Bernardo   15 Dec',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 38,
                      child: Opacity(
                        opacity: 0.50,
                        child: Text(
                          'No looking back, only moving forward hihe',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.2,
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
                    ),
                    Positioned(
                      left: 15,
                      top: 63,
                      child: Container(
                        width: 30,
                        height: 30,
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
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), // Add space between sections

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: screenWidth - 40,
                height: 100,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth - 40,
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
                    Positioned(
                      left: screenWidth - 146,
                      top: 6,
                      child: Container(
                        width: 90,
                        height: 22,
                        child: Stack(
                          children: [
                            Container(
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
                            Positioned(
                              left: 22,
                              top: 3,
                              child: Text(
                                'Trending',
                                style: TextStyle(
                                  color: Color(0xFF5C00A4),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
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
                        'supremo_dp   15 Dec',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 38,
                      child: Opacity(
                        opacity: 0.50,
                        child: Text(
                          'Alam niyo sino loyal? yung aso ko si summer arf',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.2,
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
                    ),
                    Positioned(
                      left: 15,
                      top: 63,
                      child: Container(
                        width: 30,
                        height: 30,
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

  Widget _buildCarouselItem(String label) {
    return Container(
      width: 110,
      height: 25,
      child: Stack(
        children: [
          Container(
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
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 1, 30, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 15),
              _buildPostContent(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create a Post',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'You are not going through this alone. The community is always here to support you.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPostContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          height: 550,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 300,
                  height: 510,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 2,
                        top: 2,
                        child: Container(
                          width: 280,
                          height: 490,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEFCEFF),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFF5C00A4),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 14.43,
                        child: SizedBox(
                          width: 250,
                          height: 36.91,
                          child: Text(
                            'Care to share some thoughts?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF200D3C),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 230.81,
                        top: 310.92,
                        child: Container(
                          width: 94.59,
                          height: 22.30,
                          child: Stack(
                            children: [],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 348.38,
                        child: Container(
                          width: 94.59,
                          height: 22.30,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 94.59,
                                  height: 22.30,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color: Color(0xFF5C00A4),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 11.76,
                                top: 3.62,
                                child: SizedBox(
                                  width: 71.17,
                                  height: 15.40,
                                  child: Text(
                                    'Friendship',
                                    style: TextStyle(
                                      color: Color(0xFF5C00A4),
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
                      Positioned(
                        left: 230,
                        top: 348,
                        child: Container(
                          width: 94.59,
                          height: 22.30,
                          child: Stack(
                            children: [],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 384.05,
                        child: Container(
                          width: 207.16,
                          height: 22.30,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 160,
                                  height: 22.30,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color: Color(0xFF5C00A4),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 2.95,
                                child: SizedBox(
                                  width: 150,
                                  height: 15.40,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Others: ',
                                          style: TextStyle(
                                            color: Color(0xFF5C00A4),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Type it here...',
                                          style: TextStyle(
                                            color: Color(0xFF5C00A4),
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
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
              Positioned(
                left: 70,
                top: 42,
                child: Container(
                  width: 141,
                  height: 133,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/share.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32.67,
                top: 177.10,
                child: Container(
                  width: 215,
                  height: 110,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF8EBFF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF5C00A4),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 33,
                        child: SizedBox(
                          width: 205,
                          height: 44,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Type to share your thoughts...',
                              hintStyle: TextStyle(
                                color: Color(0xFF200D3C),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 110,
                top: 310,
                child: Container(
                  width: 94.59,
                  height: 22.30,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 94.59,
                          height: 22.30,
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFF5C00A4),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16.76,
                        top: 3.08,
                        child: SizedBox(
                          width: 60,
                          height: 15,
                          child: Text(
                            'Relapse',
                            style: TextStyle(
                              color: Color(0xFF5C00A4),
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
              Positioned(
                left: 32,
                top: 310.80,
                child: SizedBox(
                  width: 71.17,
                  height: 17.60,
                  child: Text(
                    'Add tags',
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
              Positioned(
                left: 0,
                right: 15,
                top: 428,
                child: Center(
                  child: SizedBox(
                    width: 200, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality to execute when the button is pressed
                        // For example, publish the message or perform an action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        primary: Color(0xFF5B00A4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Publish now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
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
        )
      ],
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
  bool isNotificationsOn = true;
  bool isSessionHistoryOn = true;
  bool isCustomizeOn = true;

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
              "assets/vibby.png",
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
            icon: Icon(
              Icons.settings,
              color: Color(0xFF5C00A4),
            ),
            iconSize: 35,
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
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF5C00A4),
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes the position of the shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Text
                  Text(
                    'How you use Vibby',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Row for the icons and text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the top
                    children: [
                      // First Column (left-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.notifications, size: 20),
                          SizedBox(height: 6),
                          Icon(Icons.lock, size: 20),
                          SizedBox(height: 6),
                          Icon(Icons.edit, size: 20),
                          SizedBox(height: 6),
                        ],
                      ),
                      SizedBox(width: 15),
                      // Second Column (left-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: 7), // Adjusted the spacing between texts
                          Text(
                            'Privacy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: 7), // Adjusted the spacing between texts
                          Text(
                            'Customize',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      // Third Column (right-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Toggle button for the second row
                          InkWell(
                            onTap: () {
                              setState(() {
                                isCustomizeOn = !isCustomizeOn;
                                // Add your logic to handle the toggle state
                              });
                            },
                            child: Icon(
                              isCustomizeOn
                                  ? Icons.toggle_on
                                  : Icons.toggle_off,
                              color: isCustomizeOn
                                  ? Color(0xFF5C00A4)
                                  : Colors.grey, // Change colors as needed
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSessionHistoryOn = !isSessionHistoryOn;
                                // Navigate to PasscodeEntryScreen when Privacy toggle is tapped
                                if (isSessionHistoryOn) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasscodeEntryScreen()),
                                  );
                                }
                              });
                            },
                            child: Icon(
                              isSessionHistoryOn
                                  ? Icons.toggle_on
                                  : Icons.toggle_off,
                              color: isSessionHistoryOn
                                  ? Color(0xFF5C00A4)
                                  : Colors.grey, // Change colors as needed
                            ),
                          ),
                          // Chevron button (you can customize the icon as needed)
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
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF5C00A4),
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes the position of the shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Text
                  Text(
                    'More info and support',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Row for the icons and text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the top
                    children: [
                      // First Column (left-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.help, size: 19),
                          SizedBox(height: 7),
                          Icon(Icons.info, size: 19),
                        ],
                      ),
                      SizedBox(width: 15),
                      // Second Column (left-aligned)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Help',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: 9), // Adjusted the spacing between texts
                          Text(
                            'About',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 4,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
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
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      title.split(', ').map((item) => Text(item)).toList(),
                ),
              ),
              // Space between columns
              SizedBox(width: 20),
              // Second Column
              Flexible(
                flex: 5,
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
            right: 0.1,
            child: Container(
              width: 75,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF5C00A4),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  alignment:
                      Alignment.center, // Align text in the middle vertically
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

///
///PASSCODE
///

class PasscodeEntryScreen extends StatefulWidget {
  @override
  _PasscodeEntryScreenState createState() => _PasscodeEntryScreenState();
}

class _PasscodeEntryScreenState extends State<PasscodeEntryScreen> {
  String enteredPasscode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Color(0xFFF9F9F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter Your Passcode',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40), // Adjusted spacing
              _buildPasscodeField(),
              SizedBox(height: 10), // Adjusted spacing
              _buildPasscodeButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasscodeField() {
    const double lineWidth =
        17; // Adjust this value for the desired horizontal spacing

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (index) {
        return Container(
          width: lineWidth,
          height: 2,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    index < enteredPasscode.length ? Colors.black : Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              index < enteredPasscode.length ? '*' : '',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPasscodeButtons() {
    return Column(
      children: [
        SizedBox(height: 60), // Adjusted vertical spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPasscodeButton('1'),
            _buildPasscodeButton('2'),
            _buildPasscodeButton('3'),
          ],
        ),
        SizedBox(height: 15), // Adjusted vertical spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPasscodeButton('4'),
            _buildPasscodeButton('5'),
            _buildPasscodeButton('6'),
          ],
        ),
        SizedBox(height: 15), // Adjusted vertical spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPasscodeButton('7'),
            _buildPasscodeButton('8'),
            _buildPasscodeButton('9'),
          ],
        ),
        SizedBox(height: 15), // Adjusted vertical spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPasscodeButton(''),
            _buildPasscodeButton('0'),
            _buildPasscodeButton('⌫', onPressed: _erasePasscode),
          ],
        ),
      ],
    );
  }

  Widget _buildPasscodeButton(String label, {VoidCallback? onPressed}) {
    return TextButton(
      onPressed: () {
        _onPasscodeButtonPressed(label);
        if (onPressed != null) onPressed();
      },
      child: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  void _onPasscodeButtonPressed(String label) {
    setState(() {
      if (label == '⌫') {
        if (enteredPasscode.isNotEmpty) {
          enteredPasscode =
              enteredPasscode.substring(0, enteredPasscode.length - 1);
        }
      } else if (enteredPasscode.length < 4) {
        enteredPasscode += label;
        if (enteredPasscode.length == 4) {
          if (_checkPasscode(enteredPasscode)) {
            Navigator.pop(context);
          } else {
            enteredPasscode = "";
          }
        }
      }
    });
  }

  void _erasePasscode() {
    setState(() {
      enteredPasscode = "";
    });
  }

  bool _checkPasscode(String passcode) {
    return passcode == '1234';
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
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: const Text(
          'To Do List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
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
                  margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  color: const Color(0xFF8E9CD5),
                  child: SizedBox(
                    width: 175,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 5),
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
                              const SizedBox(width: 15),
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
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  color: Color(0xFFBB9CC0),
                  child: SizedBox(
                    width: 150,
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
                              fontSize: 16,
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
                  color: Color(0xFF8E9CD5),
                  child: SizedBox(
                    width: 350,
                    height: 90,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Lectures',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Text('08/25/2023')
                            ],
                          ),
                        ),
                      ],
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
                  color: Color(0xFFE7BCDE),
                  child: SizedBox(
                    width: 350,
                    height: 90,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Arya\'s List',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Text('08/20/2023')
                            ],
                          ),
                        ),
                      ],
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

class ImportantPage extends StatelessWidget {
  const ImportantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Important'),
        toolbarTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: const [
          Card(
            color: Color(0xFF8E9CD5), // Set the background color to blue
            margin: EdgeInsets.fromLTRB(
                20, 0, 20, 5), // Add margin for better visual appearance
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      '17/12/2023',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    ListItem(text: 'Buy Food'),
                    ListItemChecked(text: 'Invest'),
                    ListItem(text: 'Deposit Money'),
                    ListItemChecked(text: 'Gym'),
                    // Add more items as needed
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Color(0xFFBB9CC0),
            margin: EdgeInsets.fromLTRB(
                20, 0, 20, 5), // Add margin for better visual appearance
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '16/11/2023',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    ListItemChecked(text: 'Submit Final Project'),
                    ListItemChecked(text: 'Buy Sunscreen'),
                    // Add more items as needed
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Color(0xFF8E9CD5), // Set the background color to blue
            margin: EdgeInsets.fromLTRB(
                20, 0, 20, 5), // Add margin for better visual appearance
            child: SizedBox(
              height: 150,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '15/12/2023',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    ListItemChecked(text: 'Buy Bus Tickets'),
                    ListItemChecked(text: 'Book AirBnb'),
                    ListItemChecked(text: 'Withdraw Money'),
                    ListItemChecked(text: 'Buy Essentials'),
                    // Add more items as needed
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Color(0xFFBB9CC0),
            margin: EdgeInsets.fromLTRB(
                20, 0, 20, 5), // Add margin for better visual appearance
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '15/12/2023',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    ListItemChecked(text: 'Download Flutter'),
                    ListItemChecked(text: 'Make TikTok Content'),

                    // Add more items as needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OrgTask extends StatelessWidget {
  const OrgTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Tasks'),
        centerTitle: true,
      ),
      body: Column(
        children: const [
          Card(
            color: Color(0xFF8E9CD5), // Set the background color to blue
            margin: EdgeInsets.fromLTRB(
                20, 10, 20, 5), // Add margin for better visual appearance
            child: SizedBox(
              height: 180,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TACTICS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    OrgTaskItemChecked(text: 'Finalize Concept Paper'),
                    OrgTaskItemChecked(text: 'Canvass Materials'),
                    OrgTaskItem(text: 'Submit Concept Paper'),
                    OrgTaskItem(text: 'Send a letter to Sir Adrian'),
                    // Add more items as needed
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Color(0xFFBB9CC0), // Set the background color to blue
            margin: EdgeInsets.fromLTRB(
                20, 0, 20, 5), // Add margin for better visual appearance
            child: SizedBox(
              height: 180,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ateneo Dance Club',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    OrgTaskItemChecked(text: 'Order Costumes'),
                    OrgTaskItemChecked(text: 'Submit Registration Forms'),
                    OrgTaskItem(text: 'Create a short choreography'),
                    OrgTaskItem(text: 'Mix music'),
                    // Add more items as needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OrgTaskItem extends StatelessWidget {
  final String text;

  const OrgTaskItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Left-align the items
        children: [
          Icon(Icons
              .check_box_outline_blank), // You can use your own checkbox icon
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}

class OrgTaskItemChecked extends StatelessWidget {
  final String text;

  const OrgTaskItemChecked({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Left-align the items
        children: [
          Icon(Icons.check_box_outlined), // You can use your own checkbox icon
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 17),
          ),
        ],
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
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
      color: Color(0xFFBB9CC0),
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
  const MyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arya\'s List'),
        centerTitle: true,
      ),
      body: Card(
        color: Color(0xFF8E9CD5), // Set the background color to blue
        margin: EdgeInsets.fromLTRB(
            20, 10, 20, 5), // Add margin for better visual appearance
        child: SizedBox(
          height: 180,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Arya\'s List',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 5.0),
                OrgTaskItemChecked(text: 'Cersei Lannister'),
                OrgTaskItemChecked(text: 'Walder Frey'),
                OrgTaskItem(text: 'The Mountain'),
                OrgTaskItem(text: 'Joffrey Baratheon'),
                // Add more items as needed
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;

  const ListItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons
              .check_box_outline_blank), // You can use your own checkbox icon
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ListItemChecked extends StatelessWidget {
  final String text;

  const ListItemChecked({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.check_box_outlined), // You can use your own checkbox icon
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
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

class Logs extends StatelessWidget {
  const Logs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: const Text(
          'Logs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 50,
                  shadowColor: Colors.transparent,
                  color: Color(0xFFD6EDD0),
                  child: SizedBox(
                    width: 350,
                    height: 110,
                    child: Padding(
                      padding: EdgeInsets.all(5), // Adjust padding as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image widget goes here
                          Column(
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/mood/meh.png',
                                    width:
                                        50, // Adjust the width of the image as needed
                                    height:
                                        50, // Adjust the height of the image as needed
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Container to wrap the text
                              Container(
                                width: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(0xFF9DE08B),
                                ),
                                padding: EdgeInsets.all(
                                    8.0), // Adjust padding as needed
                                child: Center(
                                  child: Text(
                                    'Saturday, December 25, 2023',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 50,
                  shadowColor: Colors.transparent,
                  color: Color(0xFFF4F4E2),
                  child: SizedBox(
                    width: 350,
                    height: 110,
                    child: Padding(
                      padding: EdgeInsets.all(5), // Adjust padding as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image widget goes here
                          Column(
                            children: [
                              Image.asset(
                                'assets/mood/happy.png',
                                width:
                                    50, // Adjust the width of the image as needed
                                height:
                                    50, // Adjust the height of the image as needed
                              ),
                              SizedBox(
                                  height:
                                      10), // Add some space between the image and text
                              // Container to wrap the text
                              Container(
                                width: 250,
                                decoration: BoxDecoration(
                                  // You can customize the container's decoration
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(0xFFFFE7AA),
                                ),
                                padding: EdgeInsets.all(
                                    8.0), // Adjust padding as needed
                                child: Center(
                                  child: Text(
                                    'Wednesday, December 6, 2023',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 50,
                  shadowColor: Colors.transparent,
                  color: Color(0xFFE2E9F4),
                  child: SizedBox(
                    width: 350,
                    height: 110,
                    child: Padding(
                      padding: EdgeInsets.all(5), // Adjust padding as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image widget goes here
                          Column(
                            children: [
                              Image.asset(
                                'assets/mood/sad.png',
                                width:
                                    50, // Adjust the width of the image as needed
                                height:
                                    50, // Adjust the height of the image as needed
                              ),
                              SizedBox(
                                  height:
                                      10), // Add some space between the image and text
                              // Container to wrap the text
                              Container(
                                width: 250,
                                decoration: BoxDecoration(
                                  // You can customize the container's decoration
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(0xFFAAD1FF),
                                ),
                                padding: EdgeInsets.all(
                                    8.0), // Adjust padding as needed
                                child: Center(
                                  child: Text(
                                    'Friday, December 1, 2023',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 50,
                  shadowColor: Colors.transparent,
                  color: Color(0xFFF4E3E2),
                  child: SizedBox(
                    width: 350,
                    height: 350, // Adjust the height as needed
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Image widget and Container go here
                          Container(
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color(0xFFFFAFAA),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Image widget
                                Image.asset(
                                  'assets/mood/angry.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                    width:
                                        5), // Add some space between the image and text
                                // Text inside the Container
                                Text(
                                  'Saturday, December 25, 2023',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: 5), // Add some space between the content
                          // Image widget
                          Image.asset(
                            'assets/coffee.jpg',
                            width: 350,
                            height: 200,
                          ),
                          SizedBox(
                              height:
                                  0), // Add some space between the image and text
                          // Text
                          Center(
                            child: const Text(
                              'today, i spilled my coffee on my laptop. \ni was so angry because i couldnt fix my \nlaptop anymore',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Import the image_picker package
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';  // Import the fl_chart package
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class AttendanceOrLeave extends StatefulWidget {
  const AttendanceOrLeave({super.key});

  @override
  State<AttendanceOrLeave> createState() => _AttendanceOrLeaveState();
}

class _AttendanceOrLeaveState extends State<AttendanceOrLeave> {
  String username = '';
  bool isEditing = false;
  bool isEdited = false;
  int attendanceCount = 0;
  int leaveCount = 0;
  bool showChart = false;
  DateTime? lastAttendanceTime; // Add this line
  DateTime? lastLeaveTime; // Add this line

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadAttendanceData();
    _loadLastMarkedTimes(); // Load the last marked times
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'User'; // Provide a default value if no username is found
    });
  }

  Future<void> _loadAttendanceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      attendanceCount = prefs.getInt('attendanceCount') ?? 0;
      leaveCount = prefs.getInt('leaveCount') ?? 0;
    });
  }

  Future<void> _loadLastMarkedTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lastAttendanceTime = DateTime.tryParse(prefs.getString('lastAttendanceTime') ?? '');
      lastLeaveTime = DateTime.tryParse(prefs.getString('lastLeaveTime') ?? '');
    });
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
      if (isEditing) {
        isEdited = false; // Reset edit status when starting editing
      }
    });
  }

  Future<void> _saveEdit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isEditing = false;
      isEdited = true;
      prefs.setInt('attendanceCount', attendanceCount);
      prefs.setInt('leaveCount', leaveCount);
    });
  }

  Future<void> _markAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();

    if (lastAttendanceTime == null || now.difference(lastAttendanceTime!).inHours >= 24) {
      setState(() {
        attendanceCount++;
        lastAttendanceTime = now;
      });
      await prefs.setString('lastAttendanceTime', now.toIso8601String());
      await _saveEdit();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only mark attendance once every 24 hours.')),
      );
    }
  }

  Future<void> _markLeave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();

    if (lastLeaveTime == null || now.difference(lastLeaveTime!).inHours >= 24) {
      setState(() {
        leaveCount++;
        lastLeaveTime = now;
      });
      await prefs.setString('lastLeaveTime', now.toIso8601String());
      await _saveEdit();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only mark leave once every 24 hours.')),
      );
    }
  }

  File? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  void _toggleChart() {
    setState(() {
      showChart = !showChart;  // Toggle the visibility of the chart
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Center(
          child: Text(
            'EZITECH INSTITUTE',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          SizedBox(width: 10), // Space between the drawer icon and circle avatar
          Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage('Image/emp2.jpeg'),
                  //child: Icon(Icons.person, color: Colors.white),
                ),
              );
            },
          ),
          SizedBox(width: 20), // Space between the circle avatar and screen edge
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('Image/ezi2.png'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EZITECH',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'LEARNING INSTITUTE',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text(
                'HOME',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text(
                'ABOUT US',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.class_),
              title: Text(
                'CERTIFICATION',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              children: [
                ListTile(
                  title: Text('Course 1'),
                ),
                ListTile(
                  title: Text('Course 2'),
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.leave_bags_at_home),
              title: Text(
                'CAREERS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              children: [
                ListTile(
                  title: Text('Job Openings'),
                ),
                ListTile(
                  title: Text('Internships'),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text(
                'SEMINAR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.point_of_sale),
              title: Text(
                'TECH BLOGS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text(
                'IPORTAL LOGIN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Category',
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(
                'AMAZON',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.design_services),
              title: Text(
                'DESIGNING',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text(
                'DEVELOPMENT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : AssetImage('Image/emp2.jpeg') as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$username',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('COURSES'),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('FAVOURITES'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20), // Top padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mark Attendance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: isEditing ? _saveEdit : _markAttendance,
                    child: Text(isEditing ? 'Save' : 'Mark'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15), // Space between rows
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mark Leave',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: isEditing ? _saveEdit : _markLeave,
                    child: Text(isEditing ? 'Save' : 'Mark'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _toggleChart,
              child: Text(showChart ? 'Hide Attendance' : 'View Attendance'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            if (showChart)
              Container(
                height: 250,
                padding: const EdgeInsets.all(16.0),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: attendanceCount.toDouble(),
                            color: Colors.green,
                            width: 30,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: leaveCount.toDouble(),
                            color: Colors.red,
                            width: 30,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ],
                        showingTooltipIndicators: [0],
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
}

import 'package:flutter/material.dart';
import 'package:internshiptask/Screen/StudentReportScreen.dart';
import 'models/student.dart';

class ActiveStudentScreen extends StatefulWidget {
  const ActiveStudentScreen({super.key});

  @override
  State<ActiveStudentScreen> createState() => _ActiveStudentScreenState();
}

class _ActiveStudentScreenState extends State<ActiveStudentScreen> {
  List<Student> students = [
    Student(name: 'John Doe', rollNo: '001'),
    Student(name: 'Jane Smith', rollNo: '002'),
    Student(name: 'Michael Brown', rollNo: '003'),
    Student(name: 'Emily Davis', rollNo: '004'),
    Student(name: 'William Wilson', rollNo: '005'),
  ];

  void _showEditDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit/Delete Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${students[index].name}'),
              Text('Roll No: ${students[index].rollNo}'),
              Text('Status: ${students[index].status}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditForm(index);
              },
              child: Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  students.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentReportScreen(
                      student: students[index],
                      attendance: 80, // Example attendance value
                      leave: 10, // Example leave value
                      leaveApplications: 5, // Example leave applications count
                    ),
                  ),
                );
              },
              child: Text('View Report'),
            ),
          ],
        );
      },
    );
  }

  void _showEditForm(int index) {
    final TextEditingController nameController = TextEditingController(text: students[index].name);
    final TextEditingController rollNoController = TextEditingController(text: students[index].rollNo);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: rollNoController,
                decoration: InputDecoration(labelText: 'Roll No'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  students[index].name = nameController.text;
                  students[index].rollNo = rollNoController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Student Screen',
      //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //   ),
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.purple, Colors.blue],
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //       ),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        title: Center(
          child: Text(
            'EZITECH INSTITUTE',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
    flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
        backgroundColor: Colors.grey[200], // Light background for the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[700], // Primary color for the header
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('Image/ezi2.png'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EZITECH',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'LEARNING INSTITUTE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700], // Primary color
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.blue[700]),
              title: Text(
                'HOME',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.note, color: Colors.blue[700]),
              title: Text(
                'ABOUT US',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
            ExpansionTile(
              leading: Icon(Icons.class_, color: Colors.blue[700]),
              title: Text(
                'CERTIFICATION',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              children: [
                ListTile(
                  title: Text('Course 1'),
                  onTap: () {
                    // Handle navigation
                  },
                ),
                ListTile(
                  title: Text('Course 2'),
                  onTap: () {
                    // Handle navigation
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.leave_bags_at_home, color: Colors.blue[700]),
              title: Text(
                'CAREERS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              children: [
                ListTile(
                  title: Text('Job Openings'),
                  onTap: () {
                    // Handle navigation
                  },
                ),
                ListTile(
                  title: Text('Internships'),
                  onTap: () {
                    // Handle navigation
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.shop, color: Colors.blue[700]),
              title: Text(
                'SEMINAR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.point_of_sale, color: Colors.blue[700]),
              title: Text(
                'TECH BLOGS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback, color: Colors.blue[700]),
              title: Text(
                'IPORTAL LOGIN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.blue[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Category',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700], // Primary color
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.blue[700]),
              title: Text(
                'AMAZON',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.design_services, color: Colors.blue[700]),
              title: Text(
                'DESIGNING',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.developer_mode, color: Colors.blue[700]),
              title: Text(
                'DEVELOPMENT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                // Handle navigation
              },
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

                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:AssetImage('Image/emp2.jpeg') ,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Admin Portal',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.blue[700]),
              title: Text('COURSES',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.blue[700]),
              title: Text('FAVOURITES',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[100], // Light background color
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 90,top: 20),
            child: Wrap(
              spacing: 20.0, // Horizontal space between cards
              runSpacing: 20.0, // Vertical space between rows
              children: [
                for (int i = 0; i < students.length; i++) ...[
                  GestureDetector(
                    onTap: () => _showEditDeleteDialog(i),
                    child: Container(
                      height: 120,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${students[i].name}',
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Roll No: ${students[i].rollNo}',
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(
                              'Status: ${students[i].status}',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

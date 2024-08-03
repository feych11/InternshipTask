import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internshiptask/Screen/MarkAttendenceLeaveScreen.dart';

class FrontPageDesigning extends StatefulWidget {
  const FrontPageDesigning({super.key});

  @override
  State<FrontPageDesigning> createState() => _FrontPageDesigningState();
}

class _FrontPageDesigningState extends State<FrontPageDesigning> {
  String username = '';
  TextEditingController leaveController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'User'; // Provide a default value if no username is found
    });
  }

  void _showLeaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          Theme(
            data: ThemeData( // Define custom theme data
            dialogBackgroundColor: Colors.grey, // Background color
            dialogTheme: DialogTheme( // Define dialog theme
            shape: RoundedRectangleBorder( // Define border shape
            side: const BorderSide(color: Colors.black,width: 4), // Border color
        borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        ),
        ),
        child:
          AlertDialog(
          title: Text('Write Leave Application'),
          content: TextField(
            controller: leaveController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Write Your Leave Application Here...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessDialog();
              },
              child: Text('Send'),
            ),
          ],
        )
          );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          Theme(
            data: ThemeData( // Define custom theme data
            dialogBackgroundColor: Colors.greenAccent, // Background color
            dialogTheme: DialogTheme( // Define dialog theme
            shape: RoundedRectangleBorder( // Define border shape
            side: const BorderSide(color: Colors.black,width: 4), // Border color
        borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        ),
        ),
        child:
          AlertDialog(
          content: Row(children: [
            Icon(Icons.check_box),
            Text('Sent Successfully',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
          ],),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        )
          );
      },
    );
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
                  backgroundImage: AssetImage('Image/emp2.jpeg'),
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

                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:AssetImage('Image/emp2.jpeg'),
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
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 160,top: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Dear, $username',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceOrLeave()));
                  },
                  child: Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'MARK ATTENDENCE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),

            SizedBox(height: 15),
            Center(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceOrLeave()));
                },
                child: Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'MARK LEAVE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: InkWell(
                onTap: (){
                  _showLeaveDialog();
                },
                child: Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'WRITE LEAVE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

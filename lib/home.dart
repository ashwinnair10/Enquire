// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unused_field, deprecated_member_use
//import 'package:enquire/calendar.dart';
import 'package:enquire/appinfo.dart';
import 'package:enquire/calendar.dart';
import 'package:enquire/dashboard.dart';
import 'package:enquire/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './buildhomepage.dart';
import './buildaboutuspage.dart';
import './buildeventspage.dart';
import './buildarchivepage.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: HomePage1(),
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});
  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> with TickerProviderStateMixin {
  late final TabController _tabController;
  bool _isSigningOut = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: AppBar(
          title: Text(
            'Enquire',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarPage(),
                  ),
                ),
              },
              icon: Icon(
                size: 25,
                Icons.calendar_month,
                color: Color.fromARGB(255, 253, 246, 255),
              ),
            ),
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(),
                      ),
                    ),
                  },
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.dashboard,
                        color: Color.fromARGB(255, 24, 12, 27),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Color.fromARGB(255, 24, 12, 27),
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppInfoPage(),
                      ),
                    ),
                  },
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Color.fromARGB(255, 24, 12, 27),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Info',
                        style: TextStyle(
                          color: Color.fromARGB(255, 24, 12, 27),
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () async {
                    setState(
                      () {
                        _isSigningOut = true;
                      },
                    );
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();
                    if (mounted) {
                      setState(
                        () {
                          _isSigningOut = false;
                        },
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    }
                  },
                  value: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 24, 12, 27),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Color.fromARGB(255, 24, 12, 27),
                        ),
                      )
                    ],
                  ),
                ),
              ],
              icon: Icon(Icons.more_vert),
              iconColor: Color.fromARGB(255, 253, 246, 255),
              offset: Offset(0, 50),
              color: Color.fromARGB(255, 253, 246, 255),
              elevation: 2,
            ),
          ],
          backgroundColor: Color.fromARGB(255, 24, 12, 27),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 8,
            indicatorColor: Color.fromARGB(255, 255, 149, 100),
            labelColor: Color.fromARGB(255, 255, 149, 100),
            unselectedLabelColor: Color.fromARGB(255, 255, 255, 255),
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home),
                    Text('Home'),
                  ],
                ),
              ),
              Tab(
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event),
                    Text('Events'),
                  ],
                ),
              ),
              Tab(
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.groups),
                    Text('The Team'),
                  ],
                ),
              ),
              Tab(
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.archive),
                    Text('Archive'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 24, 12, 27),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          buildhomepage(context),
          buildeventspage(context),
          buildaboutuspage(context),
          buildarchivepage(context),
        ],
      ),
    );
  }
}

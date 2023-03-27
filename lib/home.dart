import 'package:flutter/material.dart';
import '../pageTest/nw_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeStatefulWidget();
  }
}

class HomeStatefulWidget extends StatefulWidget {
  const HomeStatefulWidget({Key? key}) : super(key: key);

  @override
  State<HomeStatefulWidget> createState() => _HomeStatefulWidgetState();
}

class _HomeStatefulWidgetState extends State<HomeStatefulWidget> {
  final Color? color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(title: const Text('Flutter Test')),
          drawer: DrawerPage(),
          body: TabList(),
          bottomNavigationBar: TabBarList(),
        ),
      ),
    );
  }

  Widget TabList() {
    return TabBarView(
        // physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          NwPage().set('pageA', title: 'title pageA', message: 'msg pageA'),
          NwPage().set('pageB', title: 'title pageB', message: 'msg pageB'),
          NwPage().set('pageC', title: 'title pageC', message: 'msg pageC'),
          NwPage().set('pageD', title: 'title pageD', message: 'msg pageD'),
        ]);
  }

  Widget TabBarList() {
    return TabBar(
        tabs: <Widget>[
          Tab(icon: Icon(Icons.home, color: color)),
          Tab(icon: Icon(Icons.favorite, color: color)),
          Tab(icon: Icon(Icons.settings, color: color)),
          Tab(icon: Icon(Icons.star, color: color)),
        ],
        onTap: (index) {
          // print(index);
        });
  }

  Widget DrawerPage() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('NeuronWorks Flutter Test'),
          ),
          ListTile(
            title: Text('alert Test'),
            onTap: () {
              Map data = {'title': 'alert'};
              Navigator.pushNamed(context, '/alert', arguments: data);
            },
          ),
          ListTile(
            title: Text('http Test'),
            onTap: () {
              Map data = {'title': 'http'};
              Navigator.pushNamed(context, '/http', arguments: data);
            },
          ),
          ListTile(
            title: Text('image Test'),
            onTap: () {
              Map data = {'title': 'image'};
              Navigator.pushNamed(context, '/image', arguments: data);
            },
          ),
          ListTile(
            title: Text('picker Test'),
            onTap: () {
              Map data = {'title': 'picker'};
              Navigator.pushNamed(context, '/picker', arguments: data);
            },
          ),
          ListTile(
            title: Text('cupertino Test'),
            onTap: () {
              Map data = {'title': 'cupertino'};
              Navigator.pushNamed(context, '/cupertino', arguments: data);
            },
          ),
          ListTile(
            title: Text('regexp Test'),
            onTap: () {
              Map data = {'title': 'regexp'};
              Navigator.pushNamed(context, '/regexp', arguments: data);
            },
          ),
          ListTile(
            title: Text('local auth Test'),
            onTap: () {
              Map data = {'title': 'local auth'};
              Navigator.pushNamed(context, '/localauth', arguments: data);
            },
          ),
          ListTile(
            title: Text('foreground Test'),
            onTap: () {
              Map data = {'title': 'foreground'};
              Navigator.pushNamed(context, '/foreground', arguments: data);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search Bar'),
        actions: [
          IconButton(
            onPressed: () async {
              text = await showSearch(context: context, delegate: DataSearch());
              setState(() {});
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
          child: FittedBox(child: Text(text)),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
  final List<String> cities = [
    'Alexander ',
    'Andalusia',
    'Anniston',
    'Athens',
    'Atmore',
    'Auburn',
    'Bessemer',
    'Birmingham',
    'Chickasaw',
    'Clanton',
    'Cullman',
    'Decatur',
    'Demopolis',
    'Dothan',
    'Enterprise',
    'Eufaula',
    'Florence',
    'Fort Payne',
    'Gadsden',
    'Greenville',
    'Guntersville',
    'Huntsville',
    'Jasper',
    'Marion',
    'Mobile',
    'Montgomery',
    'Opelika',
  ];

  final List<String> recentCities = [
    'Marion',
    'Mobile',
    'Montgomery',
    'Opelika',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, query);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.amber,
        child: Text(query),
      ),
    );
  }

  // List<TexsSpan> _buildTextSpanList(
  //     int length, List<String> list, String quary) {
  //   return [
  //     TextSpan(text:list[0]),
  //     for(var i = 0; i <= (length *2)-2; i++)if(i %2== 0)TextSpan(text:list[i]),
  //   ];
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggesstions = query.isEmpty
        ? recentCities
        : cities
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListTile(
          onTap: () {
            close(context, suggesstions[index]);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
                text: query,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                children: [
                  TextSpan(
                    text: suggesstions[index].substring(
                      query.length,
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ]),
          ),
        );
      },
      itemCount: suggesstions.length,
    );
  }
}

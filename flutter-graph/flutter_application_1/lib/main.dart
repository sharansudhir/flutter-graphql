import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'api.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
    child: MaterialApp(
      title: 'Cook Book App',
      theme: ThemeData(
        // primarySwatch: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Cook Book App'),
    ),
    client: client);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Query(
        options:
            QueryOptions(documentNode: gql(getTasksQuery), pollInterval: 1),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return Scaffold(
              appBar: AppBar(
                title: Text("TODO App With GraphQL"),
              ),
              body: Center(
                  child: result.hasException
                      ? Text(result.exception.toString())
                      : result.loading
                          ? CircularProgressIndicator()
                          : TaskList(list: result.data['allIngredients'], onRefresh: refetch)),
       );
        });
  }
}

class TaskList extends StatelessWidget {
  TaskList({@required this.list, @required this.onRefresh});

  final list;
  final onRefresh;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: this.list.length,
    itemBuilder: (context, index)
    {
      final task = this.list[index];
      return ListTile(
        title: Text(task['notes'].toString()),
      );
    });
  }
}

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: HttpLink(uri: 'http://10.0.2.2:8000/graphql'),
  ),
);

final String getTasksQuery = """
query {
  allIngredients {
    id
    name
    notes
    category {
      id
      name
    }
  }
}
""";
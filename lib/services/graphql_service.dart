import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:money_map/services/auth_service.dart';

class GraphQlService {
  final AuthService authService;

  GraphQlService({
    required this.authService,
  });

  late GraphQLClient client;

  /*Future<void> init() async {
    final token = await authService.userToken;

    final HttpLink httpLink = HttpLink(
      'https://crisp-yak-15.hasura.app/v1/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $token',
    );

    final Link link = authLink.concat(httpLink);

    client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    );
  }*/
}

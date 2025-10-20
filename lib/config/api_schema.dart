enum ApiRoutes {
  auth,
}

class ApiSchema {
  static const String baseUrl = '';

  static String route(ApiRoutes route, {Map<String, dynamic>? params}) {
    switch (route) {
      case ApiRoutes.auth:
        return '/auth';
    }
  }
}

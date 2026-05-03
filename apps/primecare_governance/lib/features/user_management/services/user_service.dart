import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: "https://api.primecare.local/v1")
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET("/users")
  Future<List<User>> getUsers();

  @POST("/users")
  Future<User> createUser(@Body() User user);

  @PUT("/users/{id}")
  Future<User> updateUser(@Path("id") String id, @Body() User user);
}

class UserManagementService {
  final UserApiService _api;
  // In a real app, inject Drift database here

  UserManagementService(this._api);

  Future<List<User>> fetchUsers() async {
    try {
      final users = await _api.getUsers();
      // Cache in local storage (Drift) here
      return users;
    } catch (e) {
      // If offline, fetch from local storage
      return []; 
    }
  }

  Future<void> syncOfflineData() async {
    // Logic to sync queued actions from local storage
  }
}

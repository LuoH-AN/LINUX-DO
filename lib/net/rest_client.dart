import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'api_response.dart';
import '../models/post.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/posts')
  Future<ApiResponse<List<Post>>> getPosts(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @GET('/posts/{id}')
  Future<ApiResponse<Post>> getPostDetail(
    @Path('id') String id,
  );

  @POST('/posts')
  Future<ApiResponse<Post>> createPost(
    @Body() Map<String, dynamic> post,
  );

  @PUT('/posts/{id}')
  Future<ApiResponse<Post>> updatePost(
    @Path('id') String id,
    @Body() Map<String, dynamic> post,
  );

  @DELETE('/posts/{id}')
  Future<ApiResponse<dynamic>> deletePost(
    @Path('id') String id,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../models/topic_model.dart';
import '../models/post.dart';
import 'api_response.dart';
import 'http_config.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: HttpConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // 获取热门话题
  @GET("/top.json")
  Future<TopicListResponse> getTopics();

  // 获取帖子列表
  @GET("/posts")
  Future<ApiResponse<List<Post>>> getPosts(
    @Query("page") int page,
    @Query("limit") int limit,
  );

  // 获取帖子详情
  @GET("/posts/{id}")
  Future<ApiResponse<Post>> getPostDetail(@Path("id") String id);

  // 创建帖子
  @POST("/posts")
  Future<ApiResponse<Post>> createPost(@Body() Map<String, dynamic> data);

  // 更新帖子
  @PUT("/posts/{id}")
  Future<ApiResponse<Post>> updatePost(
    @Path("id") String id,
    @Body() Map<String, dynamic> data,
  );

  // 删除帖子
  @DELETE("/posts/{id}")
  @Headers({"Accept": "application/json"})
  Future<ApiResponse<dynamic>> deletePost(@Path("id") String id);
}

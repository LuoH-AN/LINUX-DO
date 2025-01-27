import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../models/login.dart';
import '../models/topic_detail.dart';
import '../models/topic_model.dart';
import 'http_config.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: HttpConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  /// 获取CSRF Token
  @GET('session/csrf')
  @Headers({
    'X-Requested-With': 'XMLHttpRequest',
  })
  Future<void> getCsrfToken();

  /// 登录
  @POST('session')
  @Headers({
    'Content-Type': 'application/x-www-form-urlencoded',
  })
  Future<void> login(@Body() LoginRequest loginRequest);

  /// 获取首页话题
  @GET("{path}.json")
  @Headers({
    'X-Requested-With': 'XMLHttpRequest'
  })
  Future<TopicListResponse> getTopics(@Path('path') String path);

  /// 获取帖子详情
  @GET("t/{id}.json")
  @DioResponseType(ResponseType.json)
  Future<TopicDetail> getTopicDetail(
    @Path("id") String id, {
    @Query("track_visit") bool trackVisit = true,
    @Query("forceLoad") bool forceLoad = true,
  });

  @GET('session/current.json')
  Future<dynamic> getCurrentUser();
}

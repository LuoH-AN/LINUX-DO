import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../models/topic_detail.dart';
import '../models/topic_model.dart';
import 'api_response.dart';
import 'http_config.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: HttpConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // 获取热门话题
  @GET("/{path}.json")
  Future<TopicListResponse> getTopics(@Path('path') String path);

  // 获取帖子详情
  @GET("/t/{id}.json")
  @DioResponseType(ResponseType.json)
  Future<TopicDetail> getTopicDetail(
    @Path("id") String id, {
    @Query("track_visit") bool trackVisit = true,
    @Query("forceLoad") bool forceLoad = true,
  });
}

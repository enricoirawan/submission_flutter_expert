import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_response.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';

import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getPopularTvSeries();
  Future<List<TvModel>> getNowPlayingTvSeries();
  Future<List<TvModel>> getTopRatedTvSeries();
  Future<TvDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvModel>> getTvSeriesRecommendations(int id);
  Future<List<TvModel>> searchTvSeries(String query);
  Future<List<EpisodeModel>> getEpisodeFromTvSeriesSeason(
    int id,
    int seasonNumber,
  );
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getPopularTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvLists;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getNowPlayingTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvLists;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvLists;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvLists;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvLists;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EpisodeModel>> getEpisodeFromTvSeriesSeason(
      int id, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonResponse.fromJson(json.decode(response.body)).episodes;
    } else {
      throw ServerException();
    }
  }
}

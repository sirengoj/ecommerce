import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:face4biz/data/datasource/remote/dio/dio_client.dart';
import 'package:face4biz/data/datasource/remote/exception/api_error_handler.dart';
import 'package:face4biz/data/model/body/support_ticket_body.dart';
import 'package:face4biz/data/model/response/base/api_response.dart';
import 'package:face4biz/utill/app_constants.dart';

class SupportTicketRepo {
  final DioClient dioClient;
  SupportTicketRepo({@required this.dioClient});

  Future<ApiResponse> sendSupportTicket(SupportTicketBody supportTicketModel) async {
    try {
      Response response = await dioClient.post(AppConstants.SUPPORT_TICKET_URI, data: supportTicketModel.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSupportTicketList() async {
    try {
      final response = await dioClient.get(AppConstants.SUPPORT_TICKET_GET_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:face4biz/data/datasource/remote/dio/dio_client.dart';
import 'package:face4biz/data/repository/auth_repo.dart';
import 'package:face4biz/data/repository/banner_repo.dart';
import 'package:face4biz/data/repository/brand_repo.dart';
import 'package:face4biz/data/repository/cart_repo.dart';
import 'package:face4biz/data/repository/category_repo.dart';
import 'package:face4biz/data/repository/chat_repo.dart';
import 'package:face4biz/data/repository/coupon_repo.dart';
import 'package:face4biz/data/repository/flash_deal_repo.dart';
import 'package:face4biz/data/repository/notification_repo.dart';
import 'package:face4biz/data/repository/onboarding_repo.dart';
import 'package:face4biz/data/repository/product_details_repo.dart';
import 'package:face4biz/data/repository/order_repo.dart';
import 'package:face4biz/data/repository/product_repo.dart';
import 'package:face4biz/data/repository/profile_repo.dart';
import 'package:face4biz/data/repository/search_repo.dart';
import 'package:face4biz/data/repository/seller_repo.dart';
import 'package:face4biz/data/repository/splash_repo.dart';
import 'package:face4biz/data/repository/support_ticket_repo.dart';
import 'package:face4biz/data/repository/wishlist_repo.dart';
import 'package:face4biz/helper/network_info.dart';
import 'package:face4biz/provider/auth_provider.dart';
import 'package:face4biz/provider/banner_provider.dart';
import 'package:face4biz/provider/brand_provider.dart';
import 'package:face4biz/provider/cart_provider.dart';
import 'package:face4biz/provider/category_provider.dart';
import 'package:face4biz/provider/chat_provider.dart';
import 'package:face4biz/provider/coupon_provider.dart';
import 'package:face4biz/provider/flash_deal_provider.dart';
import 'package:face4biz/provider/localization_provider.dart';
import 'package:face4biz/provider/notification_provider.dart';
import 'package:face4biz/provider/onboarding_provider.dart';
import 'package:face4biz/provider/product_details_provider.dart';
import 'package:face4biz/provider/order_provider.dart';
import 'package:face4biz/provider/product_provider.dart';
import 'package:face4biz/provider/profile_provider.dart';
import 'package:face4biz/provider/search_provider.dart';
import 'package:face4biz/provider/seller_provider.dart';
import 'package:face4biz/provider/splash_provider.dart';
import 'package:face4biz/provider/support_ticket_provider.dart';
import 'package:face4biz/provider/theme_provider.dart';
import 'package:face4biz/provider/wishlist_provider.dart';
import 'package:face4biz/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));
  sl.registerLazySingleton(() => FlashDealRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BrandRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BannerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => OnBoardingRepo(dioClient: sl()));
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => OrderRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SellerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CouponRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ChatRepo(dioClient: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => WishListRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => SupportTicketRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  sl.registerFactory(() => FlashDealProvider(megaDealRepo: sl()));
  sl.registerFactory(() => BrandProvider(brandRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ProductDetailsProvider(productDetailsRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl()));
  sl.registerFactory(() => SellerProvider(sellerRepo: sl()));
  sl.registerFactory(() => CouponProvider(couponRepo: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => WishListProvider(wishListRepo: sl(), productDetailsRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));
  sl.registerFactory(() => SupportTicketProvider(supportTicketRepo: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}

library index;

export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:shimmer/shimmer.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:geolocator/geolocator.dart';
export 'package:geocoding/geocoding.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:get/get.dart';

// screens
export 'presentation/pages/main/main_page.dart';
export 'presentation/pages/main/widgets/outline_btn_widget.dart';
export 'presentation/pages/details/widgets/card_bottom_body_widget.dart';
export 'presentation/widgets/btn_miuns_and_plus_widget.dart';
export 'presentation/pages/details/widgets/expandable_text_widget.dart';
export 'presentation/pages/details/popular_food_details_page.dart';
export 'presentation/pages/details/recommended_food_details_page.dart';
export 'presentation/widgets/item_list_widget.dart';
export 'presentation/pages/home/home_page.dart';
export 'presentation/pages/home/slider_body.dart';
export 'presentation/pages/home/widgets/item_slider_widget.dart';
export 'presentation/widgets/btn_widget.dart';
export 'presentation/pages/cart/cart_page.dart';
export 'presentation/pages/welcome/welcome_page.dart';
export 'presentation/pages/orders/orders_page.dart';
export 'presentation/pages/auth/auth_page.dart';
export 'presentation/pages/settings/settings_page.dart';
export 'presentation/pages/favorites/favorites_page.dart';
export 'presentation/pages/address/add_address_page.dart';
export 'presentation/pages/address/pick_address_page.dart';
export 'presentation/pages/address/address_list_page.dart';


// widgets
export 'presentation/widgets/icon_btn_widget.dart';
export 'presentation/widgets/card_widget.dart';
export 'presentation/widgets/icon_and_title_widget.dart';
export 'presentation/widgets/rating_and_val_widget.dart';
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
export 'presentation/widgets/row_icon_and_title_widget.dart';
export 'presentation/widgets/snack_bar_widget.dart';
export 'presentation/widgets/text_widget.dart';
export 'presentation/widgets/app_bar_widget.dart';
export 'presentation/widgets/loading_widget.dart';
export 'presentation/widgets/shimmer.dart';
export 'presentation/pages/settings/widgets/settings_item_widget.dart';
export 'presentation/pages/settings/widgets/small_user_card.dart';
export 'presentation/widgets/text_input_widget.dart';
export 'presentation/pages/auth/widgets/sign_in_widget.dart';
export 'presentation/pages/auth/widgets/sign_up_widget.dart';
export 'presentation/widgets/transform_widget.dart';

// controller
export '../controllers/cart_controller.dart';
export '../controllers/popular_products_controller.dart';
export '../controllers/recommended_products_controller.dart';
export '../controllers/main_controller.dart';
export '../controllers/auth_controller.dart';
export '../controllers/location_controller.dart';

// api client
export 'data/api/api_client.dart';
// models
export 'data/models/cart_model.dart';
export 'data/models/product_model.dart';
export 'data/models/sign_up_body_model.dart';
export 'data/models/response_model.dart';
export '/data/models/address_model.dart';
export 'data/models/user_model.dart';

// repository
export '../data/repository/cart_repo.dart';
export '../data/repository/popular_products_repo.dart';
export '../data/repository/recommended_products_repo.dart';
export '../data/repository/auth_repo.dart';
export '../data/repository/location_repo.dart';

// helper
export 'helper/app_binding.dart';
export '../helper/end_points.dart';
export '../helper/database_helper.dart';

// routes
export 'routes/routes.dart';
export 'routes/names.dart';

// constants
export '../constants/colors.dart';
export '../constants/constants.dart';
export '../constants/dimensions.dart';
export '../constants/images.dart';
// utils
export 'utils/date_converter.dart';

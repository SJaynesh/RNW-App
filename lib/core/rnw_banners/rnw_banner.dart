import 'package:rnw_institue/utils/app_export.dart';

Widget rnWBannerImage() {
  // Initialize CarouselSliderController to control the slider
  CarouselSliderController carouselController = CarouselSliderController();

  return BlocBuilder<BannerBloc, BannerState>(builder: (context, state) {
    // Default placeholder images in case no banners are available
    final List<String> defaultImages = List.generate(
      5,
      (index) => Assets.image.png.pngBannerPlaceholder.path,
    );

    // Calculate item count based on banner data availability
    int itemCount = (state.bannersModel?.data?.isEmpty ?? true)
        ? defaultImages.length
        : state.bannersModel!.data!.length;

    return SizedBox(
      height: 132.h,
      child: CarouselSlider.builder(
        itemCount: itemCount,
        carouselController: carouselController,
        options: CarouselOptions(
          height: 132.h,
          autoPlay: true, // Enable auto-play for the slider
          enlargeCenterPage: true, // Enlarge the current item
          viewportFraction: 1.0, // Show one item fully in view
        ),
        // Build the slider items
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
            height: 130.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (state.bannersModel?.data?.isEmpty ?? true)
                    ? AssetImage(
                        defaultImages[index]) // Use default images if no data
                    : NetworkImage(
                        "${ApiEndPoints.bannerbaseUrl}${state.bannersModel!.data![index].frontBanner}"),
                fit: BoxFit.fill, // Ensure image covers the entire area
              ),
              borderRadius: BorderRadius.circular(6.r), // Rounded corners
            ),
          );
        },
      ),
    );
  });
}

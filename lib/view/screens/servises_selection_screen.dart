import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/service_selection_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:flutter_application_1/view/components/shared/experience_syria_slider.dart';
import 'package:flutter_application_1/view/components/shared/service_card.dart';
import 'package:flutter_application_1/view/components/shared/tripmate.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class ServiceSelection extends GetView<ServicesselectController> {
  const ServiceSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: MeshGradient(
              points: [
                MeshGradientPoint(
                  position: const Offset(0, 0),
                  color: AppColors.background,
                ),
                MeshGradientPoint(
                  position: const Offset(0.02, 0.0),
                  color: AppColors.primary.withOpacity(0.5),
                ),
                MeshGradientPoint(
                  position: const Offset(0, 1),
                  color: AppColors.background,
                ),
                MeshGradientPoint(
                  position: const Offset(1, 1),
                  color: AppColors.background,
                ),
              ],
              options: MeshGradientOptions(blend: 2),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: const TripMate(),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: ExperienceSyriaSlider(
                    controller: controller,
                    showText: false,
                    sliderData: controller.sliderController.sliderLandmarks,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => Align(
                    alignment: AlignmentGeometry.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: AppShadows.neumorphicShadow,
                        color: AppColors.background,
                      ),
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.all(0),
                      child: ActionChip(
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        backgroundColor: controller.selectedCity.value == "All"
                            ? AppColors.primary.withOpacity(0.3)
                            : AppColors.golden.withOpacity(0.3),
                        avatar: Icon(
                          Icons.location_on_sharp,
                          color: controller.selectedCity.value == "All"
                              ? AppColors.primary
                              : AppColors.golden,
                        ),
                        label: Text(
                          controller.selectedCity.value == "All"
                              ? "All Cities"
                                    .tr // 👈 إضافة الترجمة هنا
                              : controller
                                    .selectedCity
                                    .value
                                    .tr, // 👈 ترجمة اسم المدينة إن وُجد بملف الترجمة
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.selectedCity.value == "All"
                                ? AppColors.primary
                                : AppColors.golden,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: controller.selectedCity.value == "All"
                                ? AppColors.primary
                                : AppColors.golden,
                          ),
                        ),
                        onPressed: () => controller.showCityPicker(),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 10),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final service = controller.servicesList[index];
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 800 + (index * 150)),
                      tween: Tween(begin: 1.0, end: 0),
                      curve: Curves.easeInCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: 1.0 - value,
                          child: Transform.translate(
                            offset: Offset(0, value * 30),
                            child: child,
                          ),
                        );
                      },
                      child: Servicecard(
                        service: service,
                        index: index,
                        onTap: () {
                          controller.loaditemsbyservice(service.id);
                          Get.toNamed("/serviceitemsscreen");
                        },
                      ),
                    );
                  }, childCount: controller.servicesList.length),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

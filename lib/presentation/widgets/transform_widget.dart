import '../../index.dart';

class TransFormWidget extends StatelessWidget {
  const TransFormWidget({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.scaleFactor,
    required this.child,
  });
  final int index;
  final double currentIndex;
  final double scaleFactor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    double height = getProportionateScreenHeight(205);
    Matrix4 matrix4 = Matrix4.identity();

    /// Matrix => عبارة عن مصفوفة
    /// لانشاء اشياء اكثر روعة مثل المنظور الثلاثي الابعاد Matrix4 تعمل هذه المصفوفة علي اجراء عمليات التحويل مثل الترجمة و القياس و التدوير و يمكننا استخدام
    if (index == currentIndex.toInt()) {
      /// floor => يساعدنا في ذلك floor عندما نتحرك يمينا و يسارا يتم تغيير قيمة الصفحة الحالية بالارقام عشرية ولكننا نريد هذه الارقام صحيحة و
      /// position == currentPageValue.floor() => يشير الي الصفحة الحالية التي موجود فيها
      double currentScale = 1 - (currentIndex - index) * (1 - scaleFactor);
      double currentTrans = height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);

      /// currentScale => مقياس المنحني عندما ننتقل يمينا و يسارا
    } else if (index == currentIndex.toInt() + 1) {
      /// position == currentPageValue.floor()+1 => يشير الي الصفحة التالية التي سوف اذهب اليها
      double currentScale =
          scaleFactor + (currentIndex - index + 1) * (1 - scaleFactor);
      double currentTrans = height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentIndex.toInt() - 1) {
      // position == currentPageValue.floor() - 1 => تشير الي الصفحة السابقة
      double currentScale = 1 - (currentIndex - index) * (1 - scaleFactor);
      double currentTrans = height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      double currentScale = scaleFactor;
      double currentTrans = height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    }
    return Transform(transform: matrix4, child: child);
  }
}

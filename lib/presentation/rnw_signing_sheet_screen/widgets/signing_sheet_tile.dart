import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/batches_model.dart';
import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/enum.dart';
import 'package:rnw_institue/utils/mixin.dart';

class SigningSheetTile extends StatefulWidget {
  final int? number;
  final BatchData? sheet;
  final int index;
  final List<StudentData> studentdetails;

  const SigningSheetTile(
      {super.key,
      this.number,
      required this.sheet,
      required this.index,
      required this.studentdetails});

  @override
  State<SigningSheetTile> createState() => _SigningSheetTileState();
}

class _SigningSheetTileState extends State<SigningSheetTile>
    with TickerProviderStateMixin, StudentMixin {
  UserType userType = UserType.STUDENT;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 0.3,
                  color: getCourseStatusColor(
                    widget.sheet?.batchesStatus ?? '',
                  ),
                ),
              ),
              child: _buildTileContent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTileContent() {
    return InkWell(
      onTap: () {
        NavigatorService.pushNamed(AppRoutes.rnwviewcoursescreen,
            arguments: [widget.sheet?.id.toString(), widget.studentdetails]);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  _buildCourseText('${widget.number}'),
                  buildSizedboxW(8.0),
                  Flexible(
                    child: _buildCourseText(widget.sheet?.name ?? ''),
                  ),
                  buildSizedboxW(8.0),
                ],
              ),
            ),
            Row(
              children: [
                _buildCourseText(widget.sheet?.batchesStatus ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseText(String title,
      {int flex = 1, Color color = AppColors.FONT_COLOR}) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 9.0.sp,
            color: color,
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

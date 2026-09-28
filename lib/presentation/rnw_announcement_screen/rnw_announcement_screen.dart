import 'package:intl/intl.dart';
import 'package:rnw_institue/apis/repositorise/announcement_repository.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/bloc/announcement_bloc.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/model/announcement_list_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/widget/rnw_shimmer/rnw_announcement_shimmer.dart';

class RNWAnnouncementScreen extends StatefulWidget {
  final String admissionId;

  const RNWAnnouncementScreen({super.key, required this.admissionId});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final dynamic admissionID = args[1];
    return BlocProvider<AnnouncementBloc>(
        create: (context) => AnnouncementBloc(
              const AnnouncementState(),
              announcementRepository:
                  AnnouncementRepository(apiClient: ApiClient()),
            ),
        child: RNWAnnouncementScreen(admissionId: admissionID.toString()));
  }

  @override
  State<RNWAnnouncementScreen> createState() => _RNWAnnouncementScreenState();
}

class _RNWAnnouncementScreenState extends State<RNWAnnouncementScreen>
    with RouteAware {
  bool _hasMarkedAsRead = false;
  final Map<String, bool> _localAcknowledgeState = {};
  final Map<int, bool> _localReadState = {};
  final Set<int> _viewedAnnouncements = {};

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Method to fetch announcements
  void _fetchAnnouncements() {
    context
        .read<AnnouncementBloc>()
        .add(FetchAnnouncementEvent(recuringId: widget.admissionId));
  }

  void _refreshAnnouncementsIfNeeded() {
    if (_viewedAnnouncements.isNotEmpty) {
      setState(() {
        for (int announcementId in _viewedAnnouncements) {
          _localReadState[announcementId] = true;
        }
      });

      _viewedAnnouncements.clear();

      Logger.lOG(
          "Updated read state for viewed announcements without API call");
    }
  }

  void _markAllAnnouncementsAsRead(List<AnnouncementRow> announcements) {
    if (_hasMarkedAsRead || announcements.isEmpty) return;

    final List<int> announcementIds = announcements
        .where((announcement) => announcement.id != null)
        .map((announcement) => announcement.id!)
        .toList();

    if (announcementIds.isNotEmpty) {
      _hasMarkedAsRead = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RNWAppBar(
        title: Text(Lang.current.lbl_announcement),
        centerTitle: true,
        leadingWidth: 35.w,
        leading: IconButton(
          style: const ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: () => NavigatorService.goBack(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.whitecolor),
        ),
      ),
      body: BackgroundImage(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: BlocConsumer<AnnouncementBloc, AnnouncementState>(
            listener: (context, state) {
              if (state.updateAcknowledgeSuccess == true &&
                  state.updatingAnnouncementId != null) {
                setState(() {
                  _localAcknowledgeState[state.updatingAnnouncementId!] = true;
                });
              }

              if (state.updateAcknowledgeMessage != null &&
                  state.updateAcknowledgeSuccess == false &&
                  state.updatingAnnouncementId != null) {
                final announcementId = state.updatingAnnouncementId!;
                final originalState = state.announcementModel?.data?.rows
                        ?.firstWhere((row) =>
                            row.announcementId.toString() == announcementId)
                        .isAcknowledge ??
                    false;

                setState(() {
                  _localAcknowledgeState[announcementId] = originalState;
                });
              }

              if (state.markReadSuccess == true) {
                Logger.lOG("Mark read successful: ${state.markReadMessage}");
              }

              if (state.markReadSuccess == false &&
                  state.markReadMessage != null) {
                Logger.lOG("Mark read failed: ${state.markReadMessage}");
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const AnnouncementShimmer();
              } else if (state.announcementModel?.data?.rows?.isEmpty ?? true) {
                return Center(
                    child: Text(Lang.current.lbl_no_announcements_found));
              } else {
                final rows =
                    state.announcementModel!.data!.rows!.reversed.toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _markAllAnnouncementsAsRead(rows);
                });

                return RefreshIndicator(
                  onRefresh: () async {
                    _fetchAnnouncements();
                  },
                  child: ListView.separated(
                    itemCount: rows.length,
                    separatorBuilder: (context, index) => buildSizedBoxH(12.h),
                    itemBuilder: (context, index) {
                      final announcement = rows[index];
                      return _buildAnnouncementCard(announcement, state);
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(
      AnnouncementRow announcement, AnnouncementState state) {
    final int admissionId = int.tryParse(widget.admissionId) ?? 0;

    final assignDateMillis = int.tryParse(announcement.assignDate ?? '') ?? 0;
    final assignDate = DateTime.fromMillisecondsSinceEpoch(assignDateMillis);
    final date = DateFormat('MMM dd, yyyy').format(assignDate);
    final time = DateFormat('hh:mm a').format(assignDate);

    final announcementId = announcement.announcementId.toString();

    final isUpdating = state.isUpdatingAcknowledge &&
        state.updatingAnnouncementId == announcementId;

    final isRead = _getReadState(announcement);

    return GestureDetector(
      onTap: () async {
        if (announcement.announcementId != null) {
          _viewedAnnouncements.add(announcement.announcementId!);
        }

        if (!isRead && announcement.announcementId != null) {
          setState(() {
            _localReadState[announcement.announcementId!] = true;
          });

          context.read<AnnouncementBloc>().add(
                MarkReadEvent(
                  announcementIds: [announcement.announcementId!],
                  admissionId: admissionId,
                ),
              );
        }

        await NavigatorService.pushNamed(
          AppRoutes.rnwAnnouncementPreviewlist,
          arguments: announcement,
        );

        _refreshAnnouncementsIfNeeded();
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26.withOpacity(0.2)),
          color: isRead
              ? AppColors.whitecolor
              : AppColors.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(4),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left colored bar
              Container(
                width: 2.w,
                decoration: BoxDecoration(
                  color: AppColors.PRIMERY_COLOR,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              buildSizedboxW(10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.announcement?.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.BLACK,
                      ),
                    ),
                    buildSizedBoxH(10.h),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              buildSizedboxW(8.w),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  GestureDetector(
                    onTap: isUpdating
                        ? null
                        : () async {
                            final currentState =
                                _getAcknowledgeState(announcement);

                            if (currentState == true) {
                              return;
                            }

                            setState(() {
                              _localAcknowledgeState[announcementId] = true;
                            });

                            context.read<AnnouncementBloc>().add(
                                  UpdateAcknowledgeEvent(
                                    announcementId: announcementId,
                                  ),
                                );
                          },
                    child: isUpdating
                        ? const AcknowledgeButtonShimmer()
                        : Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xffe31e25).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                _getAcknowledgeState(announcement)
                                    ? Icons.thumb_up_alt
                                    : Icons.thumb_up_alt_outlined,
                                size: 16.0,
                                color: _getAcknowledgeState(announcement)
                                    ? AppColors.PRIMERY_COLOR
                                    : Colors.grey,
                              ),
                            ),
                          ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _getAcknowledgeState(AnnouncementRow announcement) {
    final announcementId = announcement.announcementId.toString();
    return _localAcknowledgeState[announcementId] ??
        (announcement.isAcknowledge ?? false);
  }

  bool _getReadState(AnnouncementRow announcement) {
    if (announcement.announcementId == null) return false;

    return _localReadState[announcement.announcementId!] ??
        (announcement.isRead ?? false);
  }

  @override
  void dispose() {
    _viewedAnnouncements.clear();
    _localReadState.clear();
    _localAcknowledgeState.clear();
    super.dispose();
  }
}

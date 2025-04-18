import 'package:flutter/material.dart';
import 'package:musicapp/models/audio_model.dart';
import 'package:musicapp/widgets/list_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicapp/providers/audio_provider.dart';

class TabBarWidget extends ConsumerStatefulWidget {
  const TabBarWidget({super.key});

  @override
  ConsumerState<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends ConsumerState<TabBarWidget>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final audioAsync = ref.watch(audioProvider);

    final size = MediaQuery.of(context).size.height;
    final height = size / 5;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 30,
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
                  ),
                  tabs: const [
                    Tab(text: "All"),
                    Tab(text: "Notifications"),
                    Tab(text: "Ringtones"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: double.maxFinite,
                height: height,
                child: audioAsync.when(
                  data: (audioList) {
                    final allAudioList = audioList;
                    final notificationList = audioList
                        .where((audio) => audio.isNotification)
                        .toList();
                    final ringtoneList = audioList
                        .where((audio) => !audio.isNotification)
                        .toList();

                    List<Widget> mapList(List<Audio> list) => list
                        .asMap()
                        .entries
                        .map((entry) => ListTileWidget(
                              title: entry.value.title,
                              author: entry.value.profile,
                              files: list,
                              objectId: entry.value.id,
                              id: entry.key,
                            ))
                        .toList();

                    return RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(audioProvider.notifier).refresh();
                      },
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          ListView(children: mapList(allAudioList)),
                          ListView(children: mapList(notificationList)),
                          ListView(children: mapList(ringtoneList)),
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, _) => Center(
                    child: Text('Error loading audios: $e'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

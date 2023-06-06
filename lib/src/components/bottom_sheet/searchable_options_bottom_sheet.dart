import 'dart:ui';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../aegis.dart';

class SkSearchableOptionsBottomSheet<T> extends HookWidget {
  const SkSearchableOptionsBottomSheet({
    super.key,
    required this.title,
    required this.searchHint,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.options,
    required this.getLabel,
    this.getImage,
    this.groupByAlphabet = false,
    this.getTag,
  });

  final String title;
  final String searchHint;
  final String emptyTitle;
  final String emptyDescription;
  final List<T> options;
  final String Function(T) getLabel;
  final String? Function(T)? getImage;
  final bool groupByAlphabet;
  final String? Function(T)? getTag;

  static const radius = Radius.circular(16);

  Future<T?> show(BuildContext context) {
    var selected = showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => this,
    );

    return selected;
  }

  @override
  Widget build(BuildContext context) {
    var filtered = useState<List<T>>(options);
    var controller = useTextEditingController();

    List<_AzData> grouped() {
      var sorted = filtered.value
          .map((f) => _AzData<T>(
                data: f,
                tag: getTag?.call(f) ?? getLabel(f)[0].toUpperCase(),
              ))
          .toList();
      SuspensionUtil.sortListBySuspensionTag(sorted);
      SuspensionUtil.setShowSuspensionStatus(sorted);
      return sorted;
    }

    void onChanged(String value) {
      value = value.toLowerCase();
      filtered.value = options
          .where((c) => getLabel(c).toLowerCase().contains(value))
          .toList();
    }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: Shadow.convertRadiusToSigma(4),
        sigmaY: Shadow.convertRadiusToSigma(4),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
          color: AegisColors.neutral0,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          maxChildSize: .93,
          initialChildSize: .93,
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              slivers: [
                _Header(
                  title: title,
                  searchLabel: searchHint,
                  controller: controller,
                  onChanged: onChanged,
                ),
                if (filtered.value.isEmpty)
                  SliverToBoxAdapter(
                    child: _Empty(
                      title: emptyTitle,
                      description: emptyDescription,
                    ),
                  )
                else if (groupByAlphabet)
                  SliverFillRemaining(
                    child: GestureDetector(
                      onTapDown: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: AzListView(
                        data: grouped(),
                        itemCount: grouped().length,
                        itemBuilder: (context, index) {
                          var f = grouped()[index];
                          return Column(
                            children: [
                              Offstage(
                                offstage: !f.isShowSuspension,
                                child: _AzGroup(tag: f.getSuspensionTag()),
                              ),
                              _OptionItem(
                                title: getLabel(f.data),
                                imageUrl: getImage?.call(f.data),
                                onPressed: () =>
                                    Navigator.of(context).pop(f.data),
                              ),
                            ],
                          );
                        },
                        indexBarOptions: IndexBarOptions(
                          needRebuild: true,
                          textStyle: AegisFont.small.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AegisColors.textHighEmphasis,
                          ),
                          indexHintAlignment: Alignment.centerRight,
                          indexHintDecoration: BoxDecoration(
                            color: AegisColors.blue300,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          indexHintWidth: 20,
                          indexHintHeight: 20,
                          indexHintTextStyle: AegisFont.small.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AegisColors.neutral0,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildListDelegate(
                      filtered.value
                          .map((f) => _OptionItem(
                                title: getLabel(f),
                                imageUrl: getImage?.call(f),
                                onPressed: () => Navigator.of(context).pop(f),
                              ))
                          .toList(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.title,
    required this.searchLabel,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String searchLabel;
  final TextEditingController controller;
  final Function(String) onChanged;

  static final double height = 64.r;
  static final double expandedHeight = 156.r;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      expandedHeight: expandedHeight,
      backgroundColor: AegisColors.neutral0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraint) {
          var top = constraint.biggest.height;
          return FlexibleSpaceBar(
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const _CloseButton(),
                    AnimatedOpacity(
                      opacity: top <= 166 ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: _Title(title: title),
                    ),
                  ],
                ),
                AnimatedOpacity(
                  opacity: top > 166 ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20).r,
                    child: _Title(title: title),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20).r,
          child: SkSearchField(
            controller: controller,
            hintText: searchLabel,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 24.sp,
      padding: EdgeInsets.zero,
      icon: const Icon(
        AegisIcons.close,
        color: AegisColors.iconHighEmphasis,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AegisFont.headlineMedium.copyWith(
        color: AegisColors.neutral500,
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key, required this.title, required this.description})
      : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            title,
            style: AegisFont.bodyLarge.copyWith(
              color: AegisColors.textHighEmphasis,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AegisFont.bodyMedium.copyWith(
              color: AegisColors.textHighEmphasis,
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    Key? key,
    required this.title,
    this.imageUrl,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String? imageUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).r,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AegisColors.borderHighEmphasis),
        ),
      ),
      child: ListTile(
        dense: true,
        leading: imageUrl == null ? null : _Image(imageUrl: imageUrl!),
        title: Text(
          title,
          style: AegisFont.bodyMedium.copyWith(
            color: AegisColors.textHighEmphasis,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8).r,
        onTap: onPressed,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.r,
      width: 56.r,
      decoration: BoxDecoration(
        border: Border.all(color: AegisColors.borderHighEmphasis),
        borderRadius: BorderRadius.circular(4).r,
      ),
      child: imageUrl.isEmpty
          ? const SizedBox()
          : Image.network(imageUrl, width: 25.r),
    );
  }
}

class _AzData<T> extends ISuspensionBean {
  final T data;
  final String tag;

  _AzData({required this.data, required this.tag});

  @override
  String getSuspensionTag() => tag;
}

class _AzGroup extends StatelessWidget {
  const _AzGroup({Key? key, required this.tag}) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8).r,
      width: double.infinity,
      color: AegisColors.backgroundGray,
      child: Text(
        tag,
        style: AegisFont.bodyMedium.copyWith(
          color: AegisColors.textHighEmphasis,
        ),
      ),
    );
  }
}

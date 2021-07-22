import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manabie_testing/model/todo.dart';
import 'package:manabie_testing/res/image/images.dart';
import 'package:manabie_testing/screen/all_todo_screen.dart';
import 'package:manabie_testing/screen/complete_todo_screen.dart';
import 'package:manabie_testing/screen/incomplete_todo_screen.dart';
import 'package:manabie_testing/store/todo_store.dart';
import 'package:manabie_testing/theme/dimens.dart';
import 'package:manabie_testing/utils/constants.dart';
import 'package:manabie_testing/widget/bottom_bar.dart';
import 'package:manabie_testing/widget/loading_containeer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _myPage = PageController();
  final TodoStore _store = TodoStore();

  @override
  void initState() {
    super.initState();
    _store.getAllTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return LoadingContainer(
        isLoading: _store.isShowLoading,
        child: Scaffold(
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _myPage,
              onPageChanged: (int position) {
                _store.jumpToOtherPage = position;
              },
              children: [
                AllTodoScreen(todoStore: _store),
                CompleteTodoScreen(
                  todoStore: _store,
                ),
                InCompleteTodoScreen(
                  todoStore: _store,
                )
              ],
            ),
            bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                elevation: 8.0,
                child: SizedBox(
                  height: Dimens.bottomBarHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        BottomBarWidget(
                          icon: Images.icAll,
                          isSelected:
                              _store.pagePosition == Constants.TAB_INDEX_ALL ||
                                  false,
                          onPressed: () {
                            _store.jumpToOtherPage = Constants.TAB_INDEX_ALL;
                            _jumpToOtherPage();
                          },
                        ),
                        BottomBarWidget(
                          icon: Images.icComplete,
                          isSelected:
                              _store.pagePosition == Constants.TAB_INDEX_DONE ||
                                  false,
                          onPressed: () {
                            _store.jumpToOtherPage = Constants.TAB_INDEX_DONE;
                            _jumpToOtherPage();
                          },
                        ),
                        BottomBarWidget(
                          icon: Images.icInComplete,
                          isSelected: _store.pagePosition ==
                                  Constants.TAB_INDEX_NOT_DONE ||
                              false,
                          onPressed: () {
                            _store.jumpToOtherPage =
                                Constants.TAB_INDEX_NOT_DONE;
                            _jumpToOtherPage();
                          },
                        ),
                      ],
                    ),
                  ),
                ))),
      );
    });
  }

  void _jumpToOtherPage() {
    _myPage.jumpToPage(_store.pagePosition);
  }
}

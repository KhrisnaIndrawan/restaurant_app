import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widgets/card_bookmark.dart';

class BookmarksPage extends StatelessWidget {
  static const String bookmarksTitle = 'Bookmarks';
  static const routeName = '/bookmark_list';

  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(bookmarksTitle),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.bookmarks.length,
              itemBuilder: (context, index) {
                return CardBookmark(bookmark: provider.bookmarks[index]);
              },
            );
          } else {
            return Center(
              child: Material(
                child: Text(provider.message),
              ),
            );
          }
        },
      ),
    );
  }
}

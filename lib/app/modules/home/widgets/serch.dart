
// import 'package:flutter/widgets.dart';

// class LanguageSearchDelegate extends SearchDelegate<String> {
//   final List<String> languageOptions;
//   final Function(String) onLanguageSelected;

//   LanguageSearchDelegate(this.languageOptions, this.onLanguageSelected);

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, '');
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final List<String> results = languageOptions
//         .where((language) => language.toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final language = results[index];
//         return ListTile(
//           title: Text(language),
//           onTap: () {
//             onLanguageSelected(language);
//             close(context, language);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final List<String> suggestions = languageOptions
//         .where((language) => language.toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final language = suggestions[index];
//         return ListTile(
//           title: Text(language),
//           onTap: () {
//             onLanguageSelected(language);
//             close(context, language);
//           },
//         );
//       },
//     );
//   }
// }

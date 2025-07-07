import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class AboutUsView extends ConsumerStatefulWidget {
  const AboutUsView({super.key});

  @override
  BottomNavigationViewState createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends ConsumerState<AboutUsView> {
  String data = '''

Welcome to **PDF Reader**, your trusted companion for reading, organizing, and managing PDF files with ease.

At **PDF Reader**, our mission is to create a seamless and powerful reading experience for students, professionals, and lifelong learners. We believe that accessing your documents should be **simple, fast, and intuitive**, empowering you to focus on what truly matters.

---

### 🚀 **Features**

✅ **Organize Books Efficiently**  
Keep your PDFs organized for quick access and a clutter-free experience.

✅ **Create Shelves**  
Group your books into custom shelves to manage your library your way.

✅ **Categorize Files**  
Assign categories to your PDFs for easier searching and sorting.

✅ **Continue Reading Instantly**  
Pick up right where you left off with our smart continue reading feature.

✅ **Track Reading Progress**  
See how much you've read and your progress in each document at a glance.

✅ **Private Folder Protection**  
Secure your confidential documents in a protected folder for privacy.

---

### 💡 **Our Vision**

We aim to build an app that not only helps you read documents but also **enhances your productivity** through smart features and elegant design.

Thank you for choosing **PDF Reader**. We are committed to delivering the best reading experience for you.

---

_If you have any suggestions or feedback, please reach out to us. Your input drives our continuous improvement._

---

''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: primaryColor,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return MarkdownWidget(
      data: data,
      padding: const EdgeInsets.all(10),
    );
  }
}

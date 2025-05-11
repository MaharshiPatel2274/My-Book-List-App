# 📚 My Book List App – SwiftUI MVVM Application

Developed as part of **CSE 335 - Lab 4** at Arizona State University (Spring 2025, Section #23965), this iOS application manages a dynamic list of books using the **MVVM** architecture and SwiftUI UI components such as `navigationBar`, `ToolbarItem`, and `AlertView`.

🔗 Visit my portfolio: [maharshi-patel.com](https://maharshi-patel.com)

## 📱 Overview

This project builds upon the PersonInfo app example discussed in class. It demonstrates:

- Use of `ToolbarItem`, `NavigationBar`, and `.alert` modals
- Managing a structured dataset of books
- Applying MVVM architecture to ensure separation of concerns
- Interactive book management with live edit and search

## 🧱 Architecture

- **Model**: `Book` struct with title, author, genre, and price
- **ViewModel**: Manages list operations (add, delete, search, edit)
- **View**: SwiftUI views with toolbars and alert prompts

## 🎯 Functionalities

- **Add Books**  
  Prompt user for title, author, genre, and price  
  Accessible via `ToolbarItem` button

- **Delete Books**  
  Remove book by title  
  Accessible via `ToolbarItem` button

- **Search Books**  
  Search by title or genre  
  Results shown in an alert with full book details

- **Edit Books**  
  After search, allow users to update book info and save changes

- **Navigate Records**  
  Users can browse book entries using **Next** and **Previous** buttons  
  UI gracefully handles end/start of list conditions

## 🖥️ UI Components

- `NavigationBar` and `ToolbarItem` for app control
- `.alert` modifier for in-app prompts and notifications
- Clean layout modeled after PersonInfo app discussed in lecture  

## 📦 How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/MaharshiPatel2274/Book-List-App
   ```

2. Open in the latest stable version of **Xcode**

3. Build and run on iOS simulator or device (iOS 15+)


**Author:** Maharshi Niraj Patel  
[Portfolio](https://maharshi-patel.com) • [GitHub](https://github.com/MaharshiPatel2274)

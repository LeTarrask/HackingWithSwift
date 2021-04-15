### Project #16: Hot Prospects
Build an app for conferences with tabs, context menus, and more.
1- Techniques:
[] - Tab bars
[] - Context menus
[] - sharing custom data with the environment
[] - sending custom notifications
[] - .interpolation(.none) - to avoid blur in small images over expanded.
[] - .contextMenu, that creates a menu when users long press a view.
[] - Local Notifications
[] - Package import
[] - QR Code generation

2- Step-by-step:
Created a simple fetchrequest with result and network error enum project that's on the folder. Then implemented a .contextMenu. Then locally generated UserNotifications. Created a tabview. Created an environment object to hold codable class, an enum filtertype to filter the contacts in different views. Then we generate a QR code from simple data with Swift. Here I used .interpolation(.none) to make the QR Code not pixelated. Added TwoStraws code scanner package. This allows to scan the QR Code. Then we handle the result, turning it into name and email, and creating a Prospect in our Prospects array. Then we use a contextMenu to change whether the contact has been contacted or not (can be used in a ToDo list, for example.) Added possibility of notification in our context menu, scheduled with iOS notification center.

3- Challenges:
Add an icon to the “Everyone” screen showing whether a prospect was contacted or not. Use JSON and the documents directory for saving and loading our user data. Use an action sheet to customize the way users are sorted in each screen – by name or by
most recent.

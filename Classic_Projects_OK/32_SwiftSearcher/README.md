### Project #32: SwiftSearcher
Add your app's content to iOS Spotlight and take advantage of Safari integration.
1- Techniques:
[] - UITableViewCells
[] - NSAttributedString
[] - SafariServices
[] - SFSafariViewController (a safari view mode which we can't control via code)
[] - tableView.isEditing and .allowsSelectionDuringEditing
[] - tableView(_:commit:forRowAt:)
[] - UITableViewCell.EditingStyle
[] - CoreSpotlight
[] - MobileCoreServices
[] - CoreSearchableItem

2- Step-by-step:
Loaded an array with Hacking with Swift projects, show it in a tableview, customize the view, allow user to choose one, and open an url that has the project. Storing favorites in UserDefaults. Then we do a lot of tableView customization. Now we go to something completely different: using Core Spotlight, to show the apps features in iOS/MacOS Spotlight. CoreSearchableItem its an object that stores information about an item for Spotlight, such as titles, description images, picture info, etc.
I did a quick hack to make the final step work, because AppDelegate is different from when tutorial was made, not sure if it's perfectly working and should be tested more.

3- Challenges:
Make it more reusable by using a viewmodel instead of an array of strings; format the stored data differently, change dynamic type size, to make the app more customizable. These challenges are interesting if we want to apply this technique into a project. Maybe for Dualogue.

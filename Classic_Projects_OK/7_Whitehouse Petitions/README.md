### Project #7: Whitehouse Petitions
Make an app to parse Whitehouse petitions using JSON and a tab bar.
1- Techniques:
[] - JSON
[] - Codable
[] - TabViewController, which is deprecated in SwiftUI
[] - Turning a few strings into html to show in a WebView
[] - Some AppDelegate shenaningans for TabView (it probably is not working anymore in new XCode)

2- Step-by-step:
We simply create another tableview, and populate it with structs that are codable. It's pretty similar to other tutorials. Apparently there's something not working with the tabview in the appdelegate, which I should try to debug, but since it's something that should not be used from now on, I'm moving on.

3- Challenges:
The challenges are exercises: adding another alert that should come from an UIBarButtomItem (stuff I've done a few times, I'll leave to improve in a next time); Allow to filter petitions (stuff that can be simply done with Codable and Combine easier than with UIKit), and customizing the HTML that shows the data.

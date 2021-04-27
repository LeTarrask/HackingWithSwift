### Project #4: Easy Browser
Embed Web Kit and learn about delegation, KVO, classes and UIToolbar.
1- Techniques:
[] - WebView
[] - KVO (key value observation, observing a value and changing it, something that's probable better solved with Combine now.)

2- Step-by-step:
We create a WebView (I'm pretty sure there's a simpler SwiftUI way to code it), and use a UIKit ProgressView to show the loading progress of the page.

3- Challenges:
If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked (using UIAlertController); making two new toolbar items with the titles Back and Forward (did it and created a couple of selectors and @objc functions); try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front (it wasn't particularly hard, but a lot of steps that I had to get from other code). These projects all sound like more training and remembering, which is good for me now, but drag a little bit.

### Project #14: Bucket List
Embed maps and make network calls in this life goals app
1- Techniques:
[] - Codable
[] - URLSession
[] - Embed Maps with MapKit
[] - iOS storage
[] - Coordinators
[] - Adding conformance to Comparable for custom types
[] - File manager class to store stuff in app directory
[] - Switching view states with enums
[] - Touch ID and Face ID
[] - Querying Wikipedia for data using GPS location.
[] - Enum loading state
[] - Implement Comparable
[] - import LocalAuthentication to use FaceID

2- Step-by-step:
Created a specific project just with the embeded mapview for swiftui and all the properties, coordinator, and helpers added to the project, so I can reuse in the future.
After that, we do implement codable and a loading state to query from wikipedia and get data from nearby places, and then store all the info in a JSON file encrypted in memory. We also use FaceID or TouchID to secure the app's data.

3- Challenges:
Our + button is rather hard to tap. Try moving all its modifiers to the image inside the button (the answer is that only the + was the actionable view, and with all the modifiers inside the button, all of them are now clickable); Having a complex if condition in the middle of ContentView isn’t easy to read – can you rewrite it so that the MapView, Circle, and Button are part of their own view? (instead of putting MapView, Circle and Button in another view, I put the LocalAuthentication code in a view that's presented before, and if the @State value is changed, presents the ContentView. :) ); Add code to show those errors in an alert.

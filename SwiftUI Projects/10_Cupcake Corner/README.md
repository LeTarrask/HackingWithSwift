### Project #10: Cupcake Corner
Build an app that sends and receives JSON from the internet
1- Techniques:
[] - Making a class compatible with codable by adding a required init and a CodingKeys enum for its value.
[] - Sending and receiving Codable data with URLSession and SwiftUI
[] - .disabled(-condition-) to hide a section in case something is not present

2- Step-by-step:
Start creating the screens, uses a single Class to hold all the data, that's passed around the views, and has all the data validation methods inside it. Complicated part is when we have to add Codable to the class. After that, did a url request to a mockup server, sending the order encoded in JSON and decoded the response as well.

3- Challenges:
Validate user input so it doesn't have empty spaces (did this by adding: .trimmingCharacters(in: .whitespacesAndNewlines) to the current checks), added an error message in case the response data is not what we're expecting, apologizing for the inconvencience, the third task is a complete refactor of the project, so I'll postpone it. (see if you can convert our data model from a class to a struct,
then create an ObservableObject class wrapper around it that gets passed around. This will result in your class having one @Published property, which is the data struct inside it, and should make supporting Codable on the struct much easier.)

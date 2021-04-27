### Project #13: Instafilter
Learn to link SwiftUI, UIKit, and Core Image in one app
1- Techniques:
[] - Custom bindings
[] - CIFilters
[] - Wrapping a UIViewController in a SwiftUI View!
[] - ActionSheets
[] - Reutilizable ImageSaver class, with error handling

2- Step-by-step:
Creating the first view, and using a if to show there's a lack of image. Creating a UIImagePickerController to select an image. We end up with a reusable ImagePicker. Note for the future. Basic image filtering using Core Image. Modified the code to allow for customization of the CI filter value in the view. Created an ImageSaver class, that can also be reutilized. It also has error handling.

3- Challenges:
Making the Save button show an error if there was no image in the image view; make the Change Filter button change its title to show the name of the currently selected
filter; experiment with having more than one slider, to control each of the input keys you care about (POSTPONED). For example, you might have one for radius and one for intensity

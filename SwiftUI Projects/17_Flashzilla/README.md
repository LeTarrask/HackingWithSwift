### Project #17: Flashzilla
Use gestures and haptics to build a learning app.
1- Techniques:
[] - gestures, haptics, timers
[] - .onTapGesture(count: 2) - for double taps
[] - .onLongPressGesture - for long press
[] - .onLongPressGesture(minimumDuration: 2) - minimum time of long press
[] - all the gesture structs: DragGesture, LongPressGesture, MagnificationGesture, RotationGesture, and TapGesture
[] - they all have special modifiers, such as onEnded() and sometimes onChanged(), so we can add actions during and after.
[] - simultaneousGesture (when we want to use gestures in child and view)
[] - UINotificationFeedbackGenerator
[] - Haptics kinds: .success, .erro, .warning
[] - to specify a tappable area: .contentShape(Rectangle())
[] - when you import SwiftUI we also implicitly import Combine
[] - Timer can be user as a Combine Publisher, so .onReceive(timer) { time in } - can be user to trigger actions
[] - timer.upstream.connect().cancel() - stops a timer
[] - timers have tolerance
[] - UIApplication.willResignActiveNotification - when app goes to background, can be used to pause, save data, etc. For example: .onReceive(NotificationCenter.default.publisher(for:
UIApplication.willResignActiveNotification)) { _ in
 print("Moving to the background!") }
[] - Other notifications: willEnterForegroundNotification - when app comes back, userDidTakeScreenshotNotification - when user takes screenshot, .significantTimeChangeNotification - when user changes clock or daylight savings time, .keyboardDidShowNotification - when keyboard comes to screen
[] - usability properties: @Environment(\.accessibilityDifferentiateWithoutColor) var
differentiateWithoutColor
[] - @Environment(\.accessibilityReduceMotion) var reduceMotion - reduces the uses of animation
[] - @Environment(\.accessibilityReduceTransparency) var
reduceTransparency - reduces the use of transparency

2- Step-by-step:
It's one of the largest projects, but it's very interesting. The possibility of creating a stack of cards with shades, movement and all was great. It is all full of accessibility elements, which area also nice.

3- Challenges:
Make something interesting for when the timer runs out (added an alert - not interesting, but I'm tired);

### Project #25: Selfie Share
Make a multipeer photo sharing app in just 150 lines of code.
1- Techniques:
[] - Review of CollectionView like project 10 (we basically redo project 10)
[] - implement ImagePicker
[] - MCSession
[] - Connection betweet 2 apple device
[] - extension to ViewController (I did it, wasn't in the project)
[] - MCSessionDelegate and it's 6 necessary methods

2- Step-by-step:
We cloned project 10, and then implemented the MCSession features so the image is automagically shared with other apple devices that run the same apps and are connected with us.

3- Challenges:
Show an alert when a user has disconnected from our multipeer network; Try sending text messages across the network (Didn't); Add a button that shows an alert controller listing the names of all devices currently connected to the session – use the connectedPeers property (Didn't).

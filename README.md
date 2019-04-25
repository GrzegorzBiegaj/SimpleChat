# Simple Chat - demo project

Created by Grzegorz Biegaj (12  - 19 June)

## Project description

Simple Shop is just an iOS demo app presenting clean code and application architecture.
Application allowing to send and receive messages to / from a web socket server.
App uses websocket echo server provided by Kaazing. All sent messages are immediately sent back.

### How it works:
- App automatically connects to the socket server
- Socket server sent back immediately all the messages 
- All me messages (text and video) are shown on chat view. Sent messages are shown on the right side and received on the left side
- Sender and receiver are indicated by avatar icon with the first character
- User can send text messages by writing in text box. After pressing send button message is sent to socket server.
- User can also send video messages by selecting it from the Photos App
- All the videos from the chat list can by played by pressing on them

NOTE: How to update Carthage dependecies:
1. Install brew: brew update
2. Install carthage: brew install carthage
3. Update carthage dependecies in project folder: carthage update --platform iOS

## Architecture

### Modified MVC
Due of usage storyboards introduction of pure MVVM is not so easy, because view is integrated with ViewControllers. Instead of it View Controller is separated by ViewModel and Controller

### Storyboards
For that simple app storyboards are good solution. Storyboards are split to possible small scenes accordingly to the ViewControllers

### Unit tests
Most of the possible unit tests exists

### Dependency injection
Because of usage unit tests it was necessary to introduce dependecy injection to separate components. See ViewModels

### Dependencies
Carthage is used as a dependency manager. Advantage in comparison to Cocoapods is to don't introduce additional .xcworkspace file. The project has a minimal number of dependencies

* [SwiftWebSocket](https://github.com/tidwall/SwiftWebSocket) - Socket server. SDK

### Programming tools
Xcode 10.2.1, swift 5.0

# InstaBosta
InstaBosta is a simple iOS application, it retrieves users (and select random user), albums and photos from free API [jsonplaceholder.typicode.com] and display it for the user, and allow the user to view album details and explore photos inside this album, User can also search in photos of the album. 
User can view photo in full screen mode, zoom it and share it.

Using [jsonplaceholder.typicode.com](https://jsonplaceholder.typicode.com)


## Used In The APP
- SWIFT
- Moya-based Network Layer 
- MVVM Architecture Pattern as a Presentation Layer
- RxSwift, RxCocoa For Data Binding
- Coordinator Pattern For Handling Navigation
- Kingfisher For Images Downloading and Caching
- XIB Files
- Adobe XD For Designing The UI

## TODO:-

- [ ] Code Refactoring
- [ ] Use Repository Pattern
- [ ] Dark Mode Support
- [ ] Unit Tests
- [ ] UI Tests
- [ ] Enhance UI/UX

## Screenshots

| Launch Screen | Profile     | PhotosList     | Photo Full Screen     |
| :-------- | :------- | :-------     | :-------     |
| <img src="/Screenshots/Launch.png" width="200" height="400">        | <img src="/Screenshots/Profile.png" width="200" height="400">       | <img src="/Screenshots/PhotosList.png" width="200" height="400">       | <img src="/Screenshots/FullScreen.png" width="200" height="400">       |

| Photo Full Screen (Zoom) | Photo Full Screen (Share)     | Search     | Loading     |
| :-------- | :------- | :-------     | :-------     |
| <img src="/Screenshots/FullScreen.Zoom.png" width="200" height="400">        | <img src="/Screenshots/FullScreen.Share.png" width="200" height="400">       | <img src="/Screenshots/Search.png" width="200" height="400">       | <img src="/Screenshots/Loading.png" width="200" height="400">       |


## App Structure:
* Common
   * Application
      * Core
      * Coordinator
   * Configuration
   * Resources
   * Extensions
      * UI
      * ExternalComponents
   
* Externals
   * Networking

* Scenes
   * Profile
      * Model
      * View
      * ViewModel
      * Coordinator
      * Interactor
   * PhotosList
      * Model
      * View
      * ViewModel
      * Coordinator
      * Interactor
   
## Authors:
Created by 
- Taha Mahmoud [LinkedIn](https://www.linkedin.com/in/engtahamahmoud/)

Please don't hesitate to ask any clarifying questions about the project if you have any.

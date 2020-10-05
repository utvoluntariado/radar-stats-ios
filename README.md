# Radar STATS – iOS
iOS app to visualize statistics provided by the [Radar STATS](https://github.com/Radar-STATS/Radar-STATS) project about Spain's `Radar COVID` app Exposure Notification service.

# About this project
This project has been created with the premise of providing the population with simple and quick information about the performance of `Radar COVID`, the Spanish application to contain the Exposure Notification service.

## Introductory Q&A
### Why not using SwiftUI?
The idea is to create a quick project to display relevant statistical information. The first 100% operational beta passed by TestFlight was set up in just 9 days, working part-time. Opting for SwiftUI is always a great idea at the moment, but in this specific case we intend to handle backward compatibility with iOS 12 if necessary.
However, the architecture allows us to move to SwiftUI in the future without prejudice.

### UI Test?
We know that most of the application is interface, and we should have some minimal tests ready to check it. However, we have been able to add unit tests to test the logic layer.
Later we will introduce UI tests. We're sorry for the inconvenience, but time is limited.

### No comments?
Yes it is. We think that the way to write better and better code is precisely to write it more and more clearly. The use and abuse of comments are a source of bad habits and endless class files that do not allow a clear vision.

Our motto is: if you don't know what it does, it is because it is not well written. Refactor it.

# Project architecture
The architecture of the `Radar STATS iOS` project is based on many of the well-known standard architectures: VIPER, MVVM, MVC, etc. The best has been chosen from each of them, to create a strong and testable architecture, which allows rapid and agile scaled development.

This architecture has been designed by Jorge J. Ramos and is in production on multiple iOS projects.
As always, it is constantly evolving and suggestions are always welcome.

With the premise of using the fewer third-party dependencies the better, this architecture only supports Swift Package Manager as a package manager. Other managers like CocoaPods or Carthage are not welcome on this occasion.
Thus, this project only depends on three external elements:
- [Swinject](https://github.com/Swinject/Swinject) - to manage dependency injection
- [PromiseKit](https://github.com/mxcl/PromiseKit) - to manage promises as response pattern
- [Charts](https://github.com/danielgindi/Charts) - to manage chart plotting

With this in mind, we can briefly describe each of the layers of this architecture.

## Infrastructure
The infrastructure layer contains the pillars of the application: from the `AppDelegate` to the support files such as `Info.plist`. This layer will contain system or launch *coordinators*, dependency injection with their *containers*, or local *services* such as the network connection observer.

## Business
The business layer will basically contain two elements
- Business models
- Interactors (use cases)

This business layer will allow us to know the basic rules of the application with little documentation. Both use cases and business models have to be kept as clean and self-defined as possible.

## Network
The network layer contains a standard definition of the API or APIs used in the application, as well as an HTTP client that handles the requests and returns the relevant results.
No more no less.

## Data
The data layer brings together two key elements of the application:
- Models outside the purely business: view, DTOs, etc.
- The repositories, classified by business groups, which will return the information requested by the interactors.

## Presentation
The presentation layer contains the entire interface, and is arranged by modules. Each module can contain:
- A **builder**: in charge of initializing the entire module
- A **router**: in charge of navigating from that module to other modules of the app
- A **presenter**: in charge of handling the transformation logic or data request for the view
- A **view controller**: responsible for drawing the requested information on the screen

Each module is self-contained, and from its builder, it must be accessible from any other. This makes changes or certain complex navigation cycles easy to follow.

Inside each module you can find a folder called `UI Components`, which will contain the custom interface elements, specific to that module.

Likewise, the presentation layer contains common elements, transversal to all the modules that can be found in the `Common` folder.

## Resources
La carpeta Resources contiene todos los recursos gráficos y/o externos al código como por ejemplo: assets de imágenes, assets de color, storyboards, fuentes y otros.

# What we already have on the radar
- [ ] Translate to co-official languages
- [ ] Write a better localization system
- [ ] Export reports as PDF or some oher imprimable format
- [ ] Full landscape mode for individual charts
- [ ] Add a Q&A section, with basic documentation on the use and display of the information
- [ ] Better iPad interface
- [ ] macOS app (Catalyst is already active, however)
- [ ] UI Tests

These are the most important tasks that we have pending for the version beyond the MVP. We will work on them. However you can see the progress directly on [the project board](https://github.com/Radar-STATS/Radar-STATS-iOS/projects/1).

# Special thanks
To all those who participate in the test groups, contributing ideas that have greatly improved the app.

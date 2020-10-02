# Radar STATS – iOS
iOS app to visualize statistics provided by the [Radar STATS](https://github.com/Radar-STATS/Radar-STATS) project about Spain's "Radar COVID" app Exposure Notification service.

# About the project
This project has been created with the premise of providing the population with simple and quick information about the performance of Radar COVID, the Spanish application to contain the Exposure Notification service.

## Introductory Q&A
### Why not using SwiftUI?
The idea is to create a quick project to display relevant statistical information. The first 100% operational beta passed by TestFlight was set up in just 9 days, working part-time. Opting for SwiftUI is always a great idea at the moment, but in this specific case we intend to handle backward compatibility with iOS 12 if necessary.
However, the architecture allows us to move to SwiftUI in the future without prejudice.

### Where's the CI?
As we said, the idea of this project has been to quickly get an MVP. Since we are a very small number of people at the moment, and time resources are very limited, we have preferred to get rid of certain parts of a normal development in this first phase.
These essential elements will be included in more advanced phases of the project.

### No comments?
Yes it is. We think that the way to write better and better code is precisely to write it more and more clearly. The use and abuse of comments are a source of bad habits and endless class files that do not allow a clear vision.

Our motto is: if you don't know what it does, it is because it is not well written. Refactor it.

# Project architecture
The architecture of the Radar STATS project is based on many of the well-known standard architectures: VIPER, MVVM, MVC, etc. The best has been chosen from each of them, to create a strong and testable architecture, which allows rapid and agile scaled development.

This architecture has been designed by [Jorge J. Ramos](https://github.com/jorgej-ramos) and is in production on multiple iOS projects.
As always, it is constantly evolving and suggestions are always welcome.

With the premise of using the fewer third-party dependencies the better, this architecture only supports Swift Package Manager as a package manager. Other managers like CocoaPods or Carthage are not welcome on this occasion.
Thus, this project only depends on three external elements:
- [Swinject](https://github.com/Swinject/Swinject) - to manage dependency injection
- [PromiseKit](https://github.com/mxcl/PromiseKit) - to manage promises as response pattern
- [Charts](https://github.com/danielgindi/Charts) - to manage chart plotting

With this in mind, we can go on to explain the layers that make up the Radar STATS architecture.
## Infrastructure
The infrastructure layer contains the pillars of the application: from the AppDelegate to the support files such as Info.plist. This layer will contain system or launch coordinators, dependency injection with their containers, or local services such as the network connection observer.

## Business
The business layer will basically contain two elements
- Business models
- Interactors (use cases)

This business layer will allow us to know the basic rules of the application with little documentation. Both use cases and business models have to be kept as clean and self-defined as possible.

## Network
The network layer contains a standard definition of the API or APIs used in the application, as well as an HTTP client that handles the requests and returns the relevant results.
No more no less.

## Data
## Presentation

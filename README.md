# LocationExplorer
LocationExplorer is an iOS application that allows users to search articles in wikipedia app based on locations. This is done by deeplink to wikipedia App.
The app is built using Swift and SwiftUI, and it follows VIP architecture.

## App architecture
This project uses the VIP (View-Interactor-Presenter) architecture pattern. The VIP architecture helps in separating concerns and making the code more modular and testable.

```View```: Responsible for displaying the data and handling user interactions.

```Interactor```: Contains the business logic and handles data fetching/manipulation.

```Presenter```: Prepares data for the view and handles presentation logic.

## Modules
#### 1. Network Layer

The Network module is designed to handle all network-related operations in a structured and extendable manner. It includes components for making API requests, handling responses, and managing errors. The network module is created in such a way that it can be extended to use any networking framework.

#### Components
```APIManager```: The APIManager class is responsible for performing network requests. It uses a Dispatcher to execute the requests and a DecodableMapper to decode the responses.

```Dispatcher```: The Dispatcher protocol defines a method for executing network requests. The URLSessionDispatcher class is an implementation of this protocol using URLSession.

```Router```: The Router protocol defines the structure of an API request, including the path, method, headers, and body. It also includes an extension for creating URLRequest objects.

```BackendType```: The BackendType enum defines different backend environments, such as production and mock.

```NetworkError```: The NetworkError enum defines various network-related errors.

```DecodableMapper```: The DecodableMapper class is responsible for decoding JSON data into Swift objects.

#### 2. DesignSystem
The DesignSystem module provides a centralized way to manage the app's design elements, such as colors, fonts, icons, and spacing. This ensures consistency across the app and makes it easier to update the design.

##### By using the Network and DesignSystem modules, the app maintains a clean and modular architecture, making it easier to manage and extend.

## Code Testability
The LocationExplorer project is designed with testability in mind, ensuring that each component can be independently tested. This is achieved through the use of protocols, dependency injection, and modular architecture.

##### Key Points
```Protocols and Dependency Injection```: By defining protocols for key components (e.g., APIManagerProtocol, LocationsPresenterProtocol), the project allows for easy mocking and stubbing in tests. Dependency injection is used to inject these dependencies into classes, making it straightforward to replace them with mock implementations during testing.

```Modular Architecture```: The VIP (View-Interactor-Presenter) architecture separates concerns, making it easier to test each component in isolation. For example, you can test the Interactor without involving the View or Presenter.

```Mocking and Stubbing```: Mock classes are used to simulate the behavior of real components. This allows you to test how a component interacts with its dependencies without relying on actual implementations.

```Unit Tests```: The project includes unit tests for various components, such as Interactors, Presenters, and utility functions. These tests ensure that each component behaves as expected in isolation.

By following these practices, the LocationExplorer project ensures high testability, making it easier to maintain and extend the codebase while ensuring reliability and correctness.

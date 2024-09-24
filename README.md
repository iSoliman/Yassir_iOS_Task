iOS Task - README

Instructions for Building and Running the Application

Xcode Version: The project was built using Xcode 15.3.
iOS Deployment Target: The minimum iOS version required to run the application is iOS 14.
Steps to Build and Run:
* Open the project in Xcode.
* Select the appropriate simulator or a physical device with iOS 14 or higher.
* Click the Run button or use the shortcut `Command + R` to build and run the app.

Assumptions and Decisions

During the implementation, a few assumptions were made due to a lack of clarity in the provided documentation. These assumptions are as follows:

- Character Cell Styles: Based on the design provided, there were three different background themes for the character cells. Since the documentation did not specify how to choose between these themes, the following assumptions were made:
  - Pink background: Used for characters with a `Dead` status.
  - Blue background: Used for characters with an `Alive` status.
  - Rounded border background: Used for characters whose status is `Unknown`.

These assumptions were made to ensure consistency with the design elements provided.

Challenges Encountered and Solutions

Testing Asynchronous Code
One of the challenges I encountered was testing the asynchronous code in the `CharacterListViewModel.requestCharacters` function. Initially, the function was implemented like this:

```swift
Task {
    guard fetcher.canLoadNextPage else { return }
    do {
        let characters = try await fetcher.fetchCharacters()
        await fetchedNewCharacters(characters: characters)
    } catch {
        if filterHandler.hasNoCharacters {
            errorMessage = error.localizedDescription
        }
    }
}
```

Problem:
Testing this function was problematic because the test code used a `sleep` call to wait for the `Task` to finish. Relying on a sleep duration (e.g., waiting for 1 second) to ensure the Task is completed can lead to inefficiencies, especially in larger projects. This approach could slow down the entire test suite if used frequently.

Solution:
To address this, I implemented an AsyncScheduler that allows for efficient testing of asynchronous code without relying on sleep. This improved the test's performance and eliminated the need for arbitrary waiting times, making the tests more deterministic and efficient.

For more information, I referred to [this article](https://medium.com/@gustavokumasawa_58795/unit-testing-async-await-code-inside-task-in-swift-df2663e190d3), which outlines best practices for unit testing asynchronous code.

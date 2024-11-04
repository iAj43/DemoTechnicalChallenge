# GitHub Repositories Viewer

## Project Overview

This iOS App allows users to browse a list of repositories from the "square" organization on GitHub. It's built using Swift and UIKit, following the MVVM (Model-View-ViewModel) design pattern. The app takes advantage of Combine and async/await for smooth data handling and caching images.

## Architecture

The app is structured using the MVVM design pattern, which helps keep the code organized and makes it easier to test. Here’s how it works:

- **Model**: This part defines how the data for repositories looks.
- **ViewModel**: This is where the app's logic lives. It uses async/await to fetch data and Combine to keep the user interface updated.
- **View**: This is the UITableView that shows the list of repositories to users.

## Libraries Used

I didn’t use any external libraries for this project. Everything is built with Swift and UIKit, which keeps the app lightweight.

## Image Caching

The app has a simple image caching system. This means that once an image is downloaded, it gets stored locally. This helps the app load images faster and uses less data when users scroll through the list.

## Requirements
- iOS 13 or later

## Run
To run the project, clone the repo and run

## Setup Instructions

To get the app running, follow these steps:

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Open the project in Xcode.
3. Build and run it on a simulator or your device.

## Testing

You can find unit tests in the `Tests` folder of the project. Use Xcode’s testing tools to run them. Just make sure you have an internet connection to pull data from GitHub.

## Future Improvements

Here are some ideas for future updates:

- Add more features to improve user experience, like a pull-to-refresh option.
- Enhance error handling to give clearer feedback during network issues.
- Optimize image caching and loading for even better performance.

## Notes

- The app shows loading indicators and error messages to keep users informed if something goes wrong while fetching data.
- The code includes comments to explain key parts and decisions.
- Users can search for repositories by name, making it easier to find what they're looking for.

## Screenshots
![Simulator Screenshot - iPhone 16 - 2024-11-05 at 00 14 14-portrait](https://github.com/user-attachments/assets/d4bb119a-5a94-4602-96bc-bd41b7c7470f)
![Simulator Screenshot - iPhone 16 - 2024-11-05 at 00 14 33-portrait](https://github.com/user-attachments/assets/a2c72439-e6da-41c5-963a-ddda40a3c530)
![Simulator Screenshot - iPhone 16 - 2024-11-05 at 00 15 04-portrait](https://github.com/user-attachments/assets/5f672a66-0897-482a-9f54-090e8330ef61)

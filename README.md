# ArtGallery iOS App

The ArtGallery iOS app is an application developed using Swift, Storyboard, and Core Data. It provides users with a gallery of paintings, allowing them to browse and manage the collection. The app features a `TableViewController` as the starting page, a `NavigationController` for navigation, and incorporates `UIImagePickerController` for uploading images. Users can create new painting entities with image, name, artist, and year properties.

## Features

- View paintings in a table view format
- Add new paintings to the collection
- Upload painting images using `UIImagePickerController`
- Delete paintings from the collection

## Screenshots

![App Screenshots](/ArtGallery/Assets.xcassets/ss4.imageset/ss4.png)
![App Screenshots](/ArtGallery/Assets.xcassets/ss2.imageset/ss2.png)
![App Screenshots](/ArtGallery/Assets.xcassets/ss1.imageset/ss1.png)
![App Screenshots](/ArtGallery/Assets.xcassets/ss3.imageset/ss3.png)

## Prerequisites

- Xcode 14.3.1+
- iOS 16.4.1+
- Swift 5.0+

## Installation

1. Clone the repository from GitHub:

```bash
git clone https://github.com/yvzfth/iOSArtGallery.git
```

2. Open the project in Xcode.

3. Build and run the project on the iOS Simulator or a connected device.

## Usage

1. On the starting page, you will see a table view displaying existing paintings in the collection.

2. To add a new painting, tap the "Add" button located in the navigation bar's top-left corner. This will open the "Add Painting" screen.

3. On the "Add Painting" screen, fill in the required fields such as name, artist, year, and select an image for the painting using the image picker. Once done, tap the "Save" button.

4. Upon tapping the "Save" button, a notification will be posted using `NotificationCenter`, which will trigger a refresh of the table view on the starting page.

5. To view the details of a specific painting, tap on its corresponding cell in the table view. This will open the "Details" screen.

6. On the "Details" screen, you can view and edit the painting's properties. To update the details, modify the fields and tap the "Save" button.

7. To delete a painting, swipe left on its cell in the table view and tap the "Delete" button.

## Architecture

The app follows the Model-View-Controller (MVC) architectural pattern:

- **Models:** The `Painting` entity represents a painting and its properties such as image, name, artist, and year. Core Data is used to manage the persistence and retrieval of these entities.

- **Views:** The user interface is created using Storyboard, consisting of table view cells to display the paintings, and screens for adding and viewing painting details.

- **Controllers:** The `ViewController` handles the table view displaying the paintings. It manages the navigation between screens and interacts with Core Data to fetch and update the painting entities. The `DetailsViewController` is responsible for displaying and editing the details of a selected painting.

## Contributing

Contributions to the ArtGallery app are welcome! If you find any issues or have suggestions for improvements, please create a pull request or open an issue on the GitHub repository.

## License

The ArtGallery app is open source and released under the [MIT License](https://github.com/yvzfth/iOSArtGallery/blob/main/LICENSE).

## Contact

For any inquiries or questions regarding the ArtGallery app, please contact the project maintainer at yvzfth@yandex.com

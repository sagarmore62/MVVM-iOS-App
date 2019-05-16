# MVVM-iOS-App
The demo app with MVVM architecture for Movies listing

## Note:
Code is compiled on Xcode 10.1 with Swift 4.2 language.

## Architecture :
- Each module is devided into three parts :
1. Model : Contains model objects
2. View : Contains xibs and controller
3. View Model : Contains view model(which has business logic) & Repository(handles network call)
- For services, Resources, Utility created seperated folder.

## Functionality :
- Movie Search & Favourites uses same UIViewController as UI is almost same. isFavourite flag in controller differenciates the screen type.
- Both screens are added in TabBarController as a child view controllers.
- In Movie search screen, on page load popular movies get displayed via theMoviedb service and that get stored in one array.
- On searching for movies through text field, new filtered array of movies maintained to save search result.
- On 6th last movie in existing movies array, next page for movies api gets hit if exist.

## Favourites :
- For simplicity favourite movies are stored in-memory(through singleton).
- Favourite movies stored through app session only.
- On each movie cell, there is favourite button on top right for add it to favourite list.

## Image Caching :
- For image caching, getImageWith() method is used which defined in UIImageView Extension.
- Downloaded images are stored in NSCache, and retrieved from same if exist.
- On low memory warning from iPhone OS, NSCache automatically removes the data from it. 

## TO DO :
- There is scope to enhance the app by storing the favourites object in DB instead of Singletone.
- Searching functionality can be improved, throttling or debounce the text change event.

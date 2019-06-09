# GiraffeCompanion

This is a giraffe rental application. It is generic enough that without much effort it could be abstracted into a broader rental application.

This uses a mock for the api client, except when it comes to some images, so that they can be shown to be dynamically loading.

I did a few tests with some declarations for additional tests, but I'd also augment everything with snapshot tests.

Other things I'd add if I had the time:

* Transaction screens for actually renting the item
* Currency converter (e.g. Candian dollars to USD to leaves or whatever)
* More tests
* Smoother loading of images
* Smoother loading of screens
* Pagination
* Actual back end server to implement a more robust API
* Prettier layouts
* More robust implementation of MVVM (data binding and whatnot)
* Better error handling
* Splash screen
* Rating system
* Customer reviews

In order to measure customer engagement, I'd augment the app with Fabric, which shows these kinds of data metrics.

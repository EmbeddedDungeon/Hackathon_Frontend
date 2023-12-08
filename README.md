# atlas_of_biodiversity

Atlas of Biodiversity MMM

## Getting Started

To run our project simply copy the repository and open the project folder as a project in android studio.

## Class descriptions

- AddCampaignScreen  is a class designed for creating new campaigns. It contains a form for entering campaign information (name, description, start date and time) and sending this information to the server for saving.
- AddFicheScreen is a class for creating new animal records. It manages a form that allows you to select a date, time, location on a map, upload images and send data to the server via HTTP POST requests in JSON format. Includes methods for image manipulation and data management, as well as a visual interface representation for user interaction with the application.
- AuthenticationScreen is a class for represents the authentication screen. It contains a form for entering a username and password, which is then used to attempt authentication through Firebase. If the data is correct, it logs in and redirects the user to a screen with a list of campaigns (ListOfCampaignsScreen). If logon errors occur, an error message is displayed on the same screen.
- CampaignDetailsScreen  is a class that displays campaign details retrieved from the server via HTTP requests. It contains logic for loading campaign details and a list of groups. It allows you to view and manage animal groups and communes, and add new groups and communes to the campaign. It includes an interface with a campaign description, a list of groups and communes, and a button to navigate to a map.
- CompassService This class represents a service for working with a compass. It uses the flutter_compass package to get compass direction data. The class has methods to start and stop reading compass data (startReading and stopReading, respectively), and a getCompassAngle method that returns the current compass direction angle.
- DownloadImage This class is a tool for downloading images from a remote server. It uses the http package to send GET requests to a URL that is based on the specified base URL. The fetchImageByNumber method performs a request to fetch an image based on the specified number and filename, using request parameters and headers.
- FamilyDetailsScreen This class displays information about an animal family. It retrieves the campaign, group and animal name data and then loads the relevant family details from the API. Once the data is retrieved, it displays a list of fiches (descriptions) of the animals of that family in a list view.
- FicheScreen FicheScreen This class displays information about a particular animal fiche. It gets the id of the fiche, downloads data from the server and displays description, date, coordinates, images and comments. User can add new comments through the interface.
- firebase_options is a class that provides default FirebaseOptions settings for different platforms. It defines a currentPlatform method that returns platform-specific Firebase settings.
- GetListPhotosID is a class representing the parameters of a photo. It contains fields for ficheId, id and fileName, and a factory method fromJson that allows you to create instances of the class from JSON data. Its fetchData method performs a query to the server to retrieve a list of photos by the specified ficheId. It returns a list of PhotDTOparam objects based on the retrieved JSON data.
- GroupDetailsScreen is a state class that displays information about the details of a particular animal group. It retrieves the campaign and group IDs, then loads the group data from the API. Once the data is retrieved, it displays a list of animals within that group. When you click on an animal, it opens the family screen of that animal.
- ImageUploader is a class designed for uploading images to the server. It contains uploadImages method, which accepts a list of image files and asynchronously uploads them to the specified server API.
- ListOfCampaignsScreen  is a class that displays a list of campaigns. It initialises the _campaigns list and on startup calls the _fetchCampaigns() method to load campaign data.
- LocationPickerScreen  is a class that allows the user to select a location on the map. When the widget is initialised, it gets the user's current location and displays a map centered at those coordinates. The user can select a new location on the map by clicking on it and the widget displays the selected location. When the user saves the selected location, the widget returns those coordinates.
- MapScreen MapScreen is a class that displays a map with markers. When initialised, it retrieves the user's current location and coordinate data from the API to display the corresponding markers on the map. The widget also displays a marker representing the user's position and, when clicked, shows information about the user's coordinates.
- SendEmailToServer is a class contains a method to send a POST request to a server with a specified API address. It uses the http library to execute requests.
- UserGPS is a class that provides methods to get the current location of a device using the geolocator package.

- CampaignDto is a data model class representing a campaign object with two fields: campagneId (campaign ID) and campagneName (campaign name). The class has a CampaignDto constructor that accepts the mandatory parameters campagneId and campagneName. There is also a factory method fromJson that converts data from JSON format into a CampaignDto object.
- CampaignPostDto  is a data model class for sending campaign data to the server.
- EachCampaignDto is a class represents data about each campaign, including identifier, name, description, list of groups (groupes) and list of communes (communes).
- EachFamilyDto This class presents information about each animal family within the campaign.
- EachGroupDto This class presents information about each group of animals in the campaign.
- FicheDto This class represents information about a card (fishe) within the campaign.
- FichePostDto  is a class representing the information needed to create a new card (fiche) in the system.
- GlobalVariables This file contains several managers and a GlobalVariables variable, which is a collection of values common to the entire application.
- MapFichesDto this Class represents an object with coordinate information (ficheId, coordX, coordY). It has a factory method fromJson, which creates an instance of the class from JSON data, and a method printDetails, which prints the coordinate information to the console.

## Key Methods:
getCurrentLocation: Returns the coordinates of the user's current location.
sendPostRequest: Function for sending POST requests to the server. Found in the classes SendEmailToServer and AuthenticationScreen.
_getUserMarker: Function that displays a map of the user with markers on it.
_takeUserGPSCoord: Function that moves the map to the user and automatically captures their coordinates.
_handleMapTap: Function that handles user taps on the screen to capture new coordinate values for indicating a location.
_fetchCampaigns(): Function to load campaigns when initializing the widget.
uploadImages: Function to send a request to the server to download all photos for the selected card.
_fetchFicheDetails: Function that sends a request to retrieve information about a card and its photos using the loadImage method.
DownloadImage: Function that sends a request with image names and the ID of the card they belong to.
startReading from CompassService: Function that reads hardware compass readings.
_fetchGroupList: Function that reads the list of groups for a specific company.
signInWithFirebase: Function to log into an account and send a request to Firebase.
_saveFiche: Function that sends data to be saved on the server.
_saveCampaign: Function to create a new campaign and send it to the server. 
## Dependencies Used:

flutter_map: 
latlong2:
url_launcher: 
geolocator: 
sensors: 
flutter_compass: 
tcp_socket_connection:

## Features:

This project is a functional interface that allows users to create their own campaigns for animal search and fauna information collection. The application features a user-friendly interface and is compatible with all Android devices. To ensure the security of user accounts, we utilized the Firebase extension. 
# Covid Trace App


Licence details and info about project will add later 
 


## User Guide

#### How to Setup

Clone the repository.

`git clone https://github.com/scorelab/Labellab.git`


#### How to Use (Mobile)

In a new terminal navigate to `mobile-app` directory.

<br><br>
The application needs `google-services.json` file issued from Firebase to connect the backend. To obtain this file,

1. Sign in to https://console.firebase.google.com/.
2. Click **Add Project** and necessary information about the project.
3. Agree to the terms and click **Create Project**.
4. After creating the project, click **Add Firebase to your android app**.
5. Go to project location and open `android/app/src/main/AndroidManifest.xml`. Copy the package name(**com.example.slcovid_tracker**) and paste in the package name field
6. Get the **SHA1 fingerprint** by following the instructions ( https://developers.google.com/android/guides/client-auth ) and paste it in the SHA1 fingerprint field.
7. Click next and download the `google-services.json`.
8. Paste the file in location `android/app/` folder.

Build the Flutter application,

`flutter build apk`

> **NOTE**: Use 'ios' instead of 'apk' to build for iOS.

or run the Flutter application.

`flutter run`

> **NOTE**: A device with USB debugging enabled or virtual device is required.
<br/>

#### How to Use (Web)

Run `npm install` in `web-app` folder.

```
 cd web-app/
 npm install
```

First you need to create a `.env` file in  `web-app` folder following the template provided in the file `src/config/config.example`<br/> <br/>

1. Sign in to https://console.firebase.google.com/.
2. Click **Add Project** and necessary information about the project.
3. Agree to the terms and click **Create Project**.
4. After creating the project, click **Add Firebase to your web app**.
5. Add app nick name and click register app.
6. Copy the firebase configuration.
8. Paste the configuration `web-app/.env` file.

You should fill in these values in their relevent fields in the `.env` file.

To run the project:  
   `$ npm start`

> **NOTE**: Before starting the server create a file named `.env` same as `.env.example` and add your **Firebase Configurations**  in the file.

Visit [localhost:3000](http://localhost:3000) to browse.


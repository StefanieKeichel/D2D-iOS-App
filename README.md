<img src="https://img.shields.io/badge/vulnerabilities-10-red" alt= "10 vulnerabilities"/>
<p align="center">
<a href="https://github.com/badges/shields/graphs/contributors" alt="Contributors">
    <img src="https://img.shields.io/github/contributors/badges/shields" /></a>
</p>

# D2D-iOS-App

### **Short Descritption**

The mobile application connects one car driver to another car driver inside a network and allows communication of automated safety and manual, non-safety-related messages between them.

### **Motivation**

Communication amongst car drivers has remained limited, anonymous and one-sided over the past 130 years. Research has found that, when sitting in cars, drivers see other motorists as machines rather than social actors. This results in aggressive and antisocial driving behavior (Baumeister & Leary, 1995; Ratan & Tsai, 2014)

Within the framework of a study, a car driver admitted that instead of honking the horn and getting angry, he would have shown more tolerance if it had been possible to nuance his protest (Sung, Chung, Kim, & You, 2019; Wang, Terken, Hu, & Rauterberg, 2020).

Our Goal:

In order to make the road safer and more sociable, we will make it our first goal to build a working prototype that allows drivers to communicate with each other on the road. Our vision is then to have a platform to develop solutions for supporting, informing and warning the drivers or pedestrians in the allday traffic and to give them more possibilities for social interaction between each other.

The Vision:

Compatibility with the 802.11p DSRC.
Autonomous driving vehicles will require a V2X network in order to ensure the car’s safe operation. If we succeed in making the smartphone app’s communication channel compati- ble with the growing V2X network, car drivers who do not own an autonomous vehicle yet, can still become part of and profit from this kind of safety network.

### **Design Pattern**

In order to prevent merge conflicts, prevent double work and prevent stepping on each others feet, we implemented the model–view–controller design pattern. Therefore, we created three main folders, that would follow this logic: Models, Views and Controllers.

All user interfaces are build in the storyboard files. Like building blocks, every storyboard file basically contains one view controller. All files are stored in the folder Views. This enables us to work on individual storyboards both independently and simultaneously. 

### **Features**

- Welcome page and the option to Login or Sign Up:

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 20 51" src="https://user-images.githubusercontent.com/58078457/163983863-abc2eee0-caec-4d08-b0a9-83a4f54f1c28.png">

- Login:

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 21 00" src="https://user-images.githubusercontent.com/58078457/163983977-2e2a2c0f-dd7c-4366-b126-dbb9f1ea4d62.png">


- Sign Up:

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 21 05" src="https://user-images.githubusercontent.com/58078457/163984005-63d2b1c4-5521-4ade-8c3d-84ae507c803b.png">


- Visual feedback in the sign up process if both passwords match: 

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 22 11" src="https://user-images.githubusercontent.com/58078457/163984083-d57aa327-c26b-4851-8907-6fe2184ed4cc.png">


- Visual feedback in the sign up process if only one passwords matches:

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 22 06" src="https://user-images.githubusercontent.com/58078457/163984129-e850dfa0-bf35-4b23-9167-5b6a7f1d98a0.png">


- Implementation of Google Maps, location tracking, geofencing and receiving warning messages:

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 22 44" src="https://user-images.githubusercontent.com/58078457/163984464-54974609-6cd1-4cc5-b829-c9434fc970d1.png">

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 28 04" src="https://user-images.githubusercontent.com/58078457/163984644-a7608054-2c82-4ccb-8908-44435700986d.png">

<img width="454" alt="Bildschirmfoto 2022-04-19 um 13 00 06" src="https://user-images.githubusercontent.com/58078457/163990086-56103c04-a011-44b2-bfd2-b95ca873f736.png">

<img width="454" alt="Bildschirmfoto 2022-04-19 um 13 00 23" src="https://user-images.githubusercontent.com/58078457/163990109-422c854f-b975-42c9-a1ac-b11268f12c05.png">

- Voice Assistance:

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 23 06" src="https://user-images.githubusercontent.com/58078457/163984784-baf01a98-95f5-4841-9306-dfd2d496e4c7.png">

<img width="454" alt="Bildschirmfoto 2022-04-19 um 12 23 18" src="https://user-images.githubusercontent.com/58078457/163985243-cecbadf5-6da3-478e-89dd-a28aa40c6fab.png">


- Chat messaging and multipeer connectivity:

<img width="503" alt="Bildschirmfoto 2022-05-14 um 22 21 29" src="https://user-images.githubusercontent.com/58078457/168447174-4b3c7fdd-e4f2-4ae5-83e9-afb167cbc144.png">

<img width="503" alt="Bildschirmfoto 2022-05-14 um 22 21 37" src="https://user-images.githubusercontent.com/58078457/168447304-b439dabe-8e8b-412a-a238-a679b27d03a0.png">

<img width="503" alt="Bildschirmfoto 2022-05-14 um 22 21 48" src="https://user-images.githubusercontent.com/58078457/168447308-fe91f3cc-0476-45d3-8c65-1b4be4d8a4e9.png">

<img width="503" alt="Bildschirmfoto 2022-05-14 um 22 21 55" src="https://user-images.githubusercontent.com/58078457/168447186-47c6bb74-d74b-4a8b-9ce7-16b2c703db0d.png">

### **Code Examples**

- Visual feedback if the password meets the requirements (changing background color of UITextField):

<img width="949" alt="Bildschirmfoto 2021-11-22 um 13 56 04" src="https://user-images.githubusercontent.com/58078457/142865689-d2c8c331-a084-4b19-9d22-5b780d15546b.png">

- Password strength check:

<img width="578" alt="Bildschirmfoto 2021-11-22 um 14 05 54" src="https://user-images.githubusercontent.com/58078457/142866880-8e82a090-73e8-4d1c-b16f-8dcecf671e8a.png">


- Implementation of the Location Manager class that retrievs location information in addition to handling all events that get triggered by location changes:

<img width="582" alt="Bildschirmfoto 2021-11-22 um 14 02 26" src="https://user-images.githubusercontent.com/58078457/142866476-27fe4508-9d74-491e-aa6e-6cd753a7a170.png">

- Passing variables from one ViewController to the next using this function:

<img width="559" alt="Bildschirmfoto 2021-11-22 um 14 10 57" src="https://user-images.githubusercontent.com/58078457/142867594-e8e9f873-a665-4849-99d6-2b36dd043e9f.png">



### **Setting up the development environment**

- Install Xcode
- Execute *pod install*

### **Credits**

Ahmed Eldably

- Connecting to Firebase
- Writing testing routines
- Authorization and authentication
- Cryptographically secure pseudorandom number generator
- Firebase Security


David Korn

- Setting up Firebase
- Connecting to Firebase

Stefanie Keichel

- Implementation of SignUp-Security (checking password strength, visual feedback, hashing password, encrypting messages, security certificate)
- Implementation of Google Maps and ensuring maximum tracking accuracy
- Implementation of sound feedback to the driver in case of upcoming traffic warnings
- Implementation of all storyboards and setting up the infrastructure of those
- Implementation of getting microphone access and the functionality of the voice assistance that transfers spoken text into the chat 
- Implementation of multipeer connectivity


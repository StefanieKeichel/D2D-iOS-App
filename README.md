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

<img width="461" alt="Bildschirmfoto 2021-11-22 um 13 22 34" src="https://user-images.githubusercontent.com/58078457/142861156-a6467e88-30dd-42f1-92fa-7e0f1e046153.png">

- Login:

<img width="463" alt="Bildschirmfoto 2021-11-22 um 13 22 22" src="https://user-images.githubusercontent.com/58078457/142861171-8c79acbd-e5a5-42de-bdbd-3509cf4794f9.png">

- Sign Up:

<img width="461" alt="Bildschirmfoto 2021-11-22 um 13 22 44" src="https://user-images.githubusercontent.com/58078457/142861186-bded8a7e-28d2-4e6c-8987-7de4fb441a8c.png">

- Visual feedback if the password meets the requirements:

<img width="480" alt="Bildschirmfoto 2021-11-22 um 13 24 27" src="https://user-images.githubusercontent.com/58078457/142861413-25fa4d3d-2a4e-48ad-a72b-b82efb8dc4cb.png">

- Visual feedback if one passwords matches:

<img width="480" alt="Bildschirmfoto 2021-11-22 um 13 24 44" src="https://user-images.githubusercontent.com/58078457/142861416-d71ff322-9453-4650-9345-750a55b97f6e.png">

- Visual feedback if both passwords match:

<img width="480" alt="Bildschirmfoto 2021-11-22 um 13 24 49" src="https://user-images.githubusercontent.com/58078457/142861420-d459a1c1-3fc6-44a0-82e4-1a9ab713a3e6.png">

- Implementation of Google Maps and location tracking:

<img width="480" alt="Bildschirmfoto 2021-11-22 um 13 49 39" src="https://user-images.githubusercontent.com/58078457/142864698-665e2a5a-def5-4c6b-a9d8-571967eeb3e5.png">

- Chat messaging:

<img width="480" alt="Bildschirmfoto 2021-11-22 um 13 30 04" src="https://user-images.githubusercontent.com/58078457/142864804-dd23135a-14ff-4828-8694-7031a7796e68.png">


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
- execute *pod install*

### **Credits**

Ahmed Eldably

- Implementation of the chat messaging
- Implementation of dynamic welcome screen
- Connecting to Firebase
- Writing testing routines

David Korn

- Setting up Firebase
- Connecting to Firebase

Stefanie Keichel

- Implementation of SignUp-Security (checking password strength, visual feedback, passing variables between view controllers)
- Implementation of Google Maps and ensuring maximum tracking accuracy
- Implementation of all storyboards and setting up the infrastructure of those

# home_eyes

Explanation and functionalities

Our smart door lock system addresses the need for enhanced security and convenience in controlling access to buildings. By integrating a Raspberry Pi 5, RFID card reader, Raspberry Pi camera, solenoid lock, relay, and touchscreen display, we have developed a robust and intelligent solution. The system leverages Python for hardware functionalities and Flutter alongside AWS for the graphical user interfaces, creating applications for both the Raspberry Pi and iPhone.

Functionality and Problem Solved:

The core problem our system solves is providing secure and effortless access control. Traditional locks and keys can be lost, duplicated, or forgotten, posing significant security risks and inconveniences. Our smart door lock system eliminates these issues by using biometric facial recognition and RFID technology.

How It Works:

1.	Continuous Monitoring: The Raspberry Pi camera continuously captures images, while the RFID reader scans for cards.
2.	Database Matching: The system checks for a match between the detected faces or cards and the data stored in the cloud database.
3.	Unlock Mechanism: If a match is found, the solenoid lock is activated and unlocked for 3 seconds.
4.	Remote Control: Users can lock or unlock the solenoid lock directly from the mobile or Raspberry Pi applications.
5.	User Management: New faces or RFID cards can be added via the mobile app, enhancing the system's flexibility and ease of use.
6.	Live Streaming: The camera feed is live-streamed to the Raspberry Pi application, providing real-time monitoring.
7.	Activity Logging: All unlock events are recorded and displayed on the iPhone app, ensuring transparency and allowing users to track access history.

By integrating these technologies, our system offers a seamless and secure way to manage access, ensuring only authorized individuals can enter. This not only heightens security but also adds a level of convenience that traditional lock systems cannot match.


Cloud Architecture
	When it comes to the cloud architecture, there are a few things that need mentioning. Both phone and desktop app have their own instance as an AWS Amplify app. Connected to the same User Pool from AWS Cognito, the apps communicate to the cloud via an API Gateaway.
 
 

![image](https://github.com/anisiaap/home_eyes/assets/93073444/f4a08be7-3210-46ba-a860-665fe729ef70)

	First of all, to better understand the logic behind the project, we need to see what are the Use Cases of our app.

 
Use Case Diagram of the project










Also, the logic behind each page is explained bellow.
     

![image](https://github.com/anisiaap/home_eyes/assets/93073444/75f2bdda-1684-4c8e-aefe-3e2017c92b14)

Hardware System Architecture

 


Circuit View (Fritzing)


 
Schematic View (Fritzing)
![image](https://github.com/anisiaap/home_eyes/assets/93073444/01f60dcd-eb89-4792-8af0-3db1897c6b4b)






![Screenshot 2024-06-05 at 22 30 55](https://github.com/anisiaap/home_eyes/assets/93073444/6b8f35e9-60e4-45d2-8956-baf03e257f0d)
![Screenshot 2024-06-05 at 22 30 50](https://github.com/anisiaap/home_eyes/assets/93073444/91a28d15-f59f-48a0-abd6-57bc4567bbf0)
![Screenshot 2024-06-05 at 22 30 45](https://github.com/anisiaap/home_eyes/assets/93073444/c2190bce-d1db-4956-8250-1cb3b82b7bf1)
![Screenshot 2024-06-05 at 22 31 15](https://github.com/anisiaap/home_eyes/assets/93073444/9052a1d9-43fb-4077-8ed9-e88a34a8d59b)
![Screenshot 2024-06-05 at 22 31 11](https://github.com/anisiaap/home_eyes/assets/93073444/49fb3982-e13b-442c-ba3e-beb5714917c2)
![Screenshot 2024-06-05 at 22 31 05](https://github.com/anisiaap/home_eyes/assets/93073444/93c459db-3753-4164-bffe-7c0e8bd9a66c)
![Screenshot 2024-06-05 at 22 31 00](https://github.com/anisiaap/home_eyes/assets/93073444/363f5093-d1a4-4aef-a24c-03a10cea651f)

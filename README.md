# Home Eyes

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
 
 
![image](https://github.com/anisiaap/home_eyes/assets/93073444/f1b6e251-02e0-4e20-8bbd-a81c5273ca30)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/0a632b37-49f4-4702-a611-4539a67fcdfd)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/d3d1f4b0-0528-4629-b4e4-b02dfacbb581)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/9a86b2eb-6068-4e53-ad44-31f26ebbbbfb)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/15e120c1-c559-4564-b2b4-b279db06fca7)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/b5b67d6a-fb86-405d-9f6e-6cb1d71980eb)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/858aecb7-3180-4167-9793-2a8aca2a1aa3)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/36900e22-293d-4b1c-94df-44599a7f2fa6)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/4f2051d6-b1eb-4663-9697-37c2b5ce9e5e)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/206948d9-6af4-4168-937b-6808455ffcaf)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/95df5349-398d-435f-b1ea-3d8e6291080e)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/7373a2be-c11a-4af4-9df0-bbefec7d0f87)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/47a65539-e63f-4fff-ba66-3e233cf63cd6)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/5fa0c6df-fd44-494a-aae3-3fdb330dabcb)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/d57a5114-fa03-4bf8-bf5c-6b1ab513d6aa)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/a87793d9-cfa8-45e7-90f3-d1c51d243c3a)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/b44b2758-a024-43a9-9d95-692303936344)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/21c53b7c-e0bf-4885-8ff2-706e17a1c29b)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/d2a30b49-d4d3-4e62-b8ac-0a0a45ee3266)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/03410639-e897-4423-b3f4-64391c6d8216)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/a06684bd-de1d-496c-b595-342435895d91)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/fbe2b889-9be4-46a8-b950-179d913201da)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/9b67982e-d7b2-4e34-81dc-45a1bf14b359)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/b8965559-feea-4ee0-b913-1e16246ff73a)

![image](https://github.com/anisiaap/home_eyes/assets/93073444/367d2b70-671e-47ca-a6a1-dab5a2970b98)




     


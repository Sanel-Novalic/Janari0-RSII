# Janari0-RSII

# Setup API and database
navigate to where docker-compose.yml is located and run command:
```
docker compose up --build
```

# Setup Desktop app
Start the desktop application with this command:
```
flutter run -d "windows" --dart-define=baseUrl=http://localhost:7158/
```

All test users have the same password: test123

Test users:

admin@gmail.com
mobile@gmail.com (user that has the food)
mobile2@gmail.com (user that buys the food)


# Setup Android device 

If you want to run mobile application on your phone, connect you phone to you pc and run flutter command by passing your PC ip address (ipconfig). 
Change define=baseurl in launch.json to your computer's ip address
for example:
```
"configurations": [
        {
            "name": "janari0_mobile_conf",
            "request": "launch",
            "type": "dart",
            "args":[
                "--dart-define", "baseUrl=http://<your-ip-address>:7158/"
            ]
        },
```
By default flutter app is configured to work with emulator and docker api services.

For nearby products to be displayed, you need to adjust the location of your Android emulator to Mostar, somewhere within 5 kilometers of the center of Mostar.

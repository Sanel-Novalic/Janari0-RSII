# Janari0-RSII

Start the Docker with the "docker-compose up --build" command. To test the API, open "https://localhost:7158/swagger/index.html".

All test users have the same password: test123

Test users:

admin@gmail.com

mobile@gmail.com (user with the food, seller)

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
                "--dart-define", "baseUrl=https://192.168.50.152:7158/"
            ]
        },
```
By default flutter app is configured to work with emulator and docker api services.



# Setup API and database
navigate to where docker-compose.yml is located and run command:
```
docker compose up --build
```

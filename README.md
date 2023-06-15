# Janari0-RSII

Start the Docker with the "docker-compose up --build" command. To test the API, open "https://localhost:7158/swagger/index.html".

All test users have the same password: test123

Test users:

admin@gmail.com

mobile@gmail.com (user with the food, seller)

mobile2@gmail.com (user that buys the food)

If you want to run mobile application on your phone, connect you phone to you pc and run flutter command by passing your PC ip address (ipconfig). 
By default flutter app is configured to work with emulator and docker api services.

# Emulator ip address will be 10.0.2.2
# flutter run  
# Or 
# Android device 
# flutter run --dart-define=baseUrl=<yourIpAddress>
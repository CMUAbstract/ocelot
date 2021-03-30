This benchmark is a tire pressure monitoring application that we wrote.
It samples from a temperature and pressure sensor to generate adjusted pressure readings, as 
well as an accelerometer, to tell if the vehicle is moving. If a pressure reading is below a threshold, 
the program will re-sample the pressure and accelerometer, to confirm that the tire is burst while the 
vehicle is moving. 
The Ocelot annotation will enforce that the initial pressure sample is fresh; that the x, y, z of the 
accelerometer is always consistent; and that the re-sampling of pressure and the accelerometer is 
fresh and consistent with each-other. 
This benchmark is a greenhouse monitoring application, originally from [TICS](https://github.com/tudssl/tics).
It monitors temperature and humidity, sending out radio packets if the average values cross certain thresholds. 
The Ocelot annotation will enforce that the temperature and humidity sensor initialization and 
sampling are consistent with each other.
% file to connect an arduino to matlab 

clc
clear
close all
a=arduino('com4','uno','Libraries', 'I2C')
scanI2CBus(a)
Mpusensor = mpu9250(a);

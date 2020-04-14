%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Colin Miller
%
% Class: AAE450
%
% HW/Project: Earth, Sun, Mars, Moon, Phobos Constants
%
% Description: List of constants and values for all bodies
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hrs2sec = 3600;
G = 6.672e-20;
AU2km = 149597870.700;
day2sec = 86400;

JD_Epoch = 2459031;

Sun.GM = 132712440041.93938;

Earth.GM = 398600.435436;
Earth.Mass = 5.97219e24;
Earth.Side = 23.9344695944*hrs2sec;
Earth.SolDay = 86400.002;
Earth.Rad = 6378.137;
Earth.Ecc = 1.710682208701169E-02;
Earth.Inc = 2.642680661566349E-03;
Earth.RAAN = 2.087350834533156E+02;
Earth.W = 2.529166872722952E+02;
Earth.SMA = 9.995877999395377E-01*AU2km;
Earth.TA = 1.772242275121407E+02;

Mars.GM = 42828.375214;
Mars.Mass = 6.4171e23;
Mars.Side = 24.622962*hrs2sec;
Mars.SolDay = 88775.24415;
Mars.Rad = 3396.19;
Mars.Ecc = 9.344873214478552E-02;
Mars.Inc = 1.847889552258653E+00;
Mars.RAAN = 4.949733591992741E+01;
Mars.SMA = 1.523775407269588E+00*AU2km;
Mars.TA = 3.385855883225225E+02;
Mars.W = 2.865985045167337E+02;

Moon.GM = 4902.800066;
Moon.Mass = 7.349e22;
Moon.Side = 0.0000026617*day2sec;
Moon.SolDay = 29.5306;
Moon.Rad = 1738.0;
Moon.Ecc = 3.356282846458077E-02;
Moon.Inc = 5.275443393774057E+00;
Moon.RAAN = 8.884382424362816E+01;
Moon.W = 1.232391468121919E+02;
Moon.TA = 5.363017614601906E+00;
Moon.SMA = 2.521000673455007E-03*AU2km;

Phobos.Mass = 1.08e16;
Phobos.GM = Phobos.Mass*G;
Phobos.Side = 0.319*day2sec;
Phobos.Rad = 11.1;
Phobos.Ecc = 1.532772402889028E-02;
Phobos.Inc = 2.643564282109559E+01;
Phobos.RAAN = 8.519570747281885E+01;
Phobos.W = 2.545690641607898E+00;
Phobos.TA = 6.367446188549656E+01;
Phobos.SMA = 6.269554505637552E-05*AU2km;

Deimos.Mass = 1.8e15;
Deimos.GM = Deimos.Mass*G;
Deimos.Side = 1.263*day2sec;
Deimos.Rad = 6.0;
Deimos.Ecc = 1.877423045427352E-04;
Deimos.Inc = 2.489896507548753E+01;
Deimos.RAAN = 7.923229439372973E+01;
Deimos.W = 3.569273502893651E+02;
Deimos.TA = 1.462207663739140E+02;
Deimos.SMA = 1.568165794889536E-04*AU2km;




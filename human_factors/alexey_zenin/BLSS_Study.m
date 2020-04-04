%Bioregenerative Life Support System Updated
%CO2 reduction, Oxygen production
%Required: 0.84 kg O2/day, 1 kg CO2/day
%Chlorella pyrenoidosa study
CO2 = 1; %kg/day-person
O2 = 0.84; %kg/day-person
%Given:
O2_CP = 1.21; %O2 production by Chlorella pyrenoidosa ml/min
CO2_CP = 1.09; %CO2 reduction by Chlorella pyrenoidosa ml/min
%Photosynthetic quotient (PQ = CO2/O2) of Chlorella pyrenoidosa
PQ = CO2_CP/O2_CP 
%Daily needs O2 to CO2 ratio
DN = O2/CO2
%Required Chlorella pyrenoidosa per person
%18 L of algal cultivator is 8 m^2 of exposed area is 20% of needs per human
CP = 40; %m^2 to satisfy human's needs in oxygen with recycled CO2
%Cycler BLSS's specific calculations
Crew = 35; %People on board
%Area required m^2
S = CP*Crew; %m^2
Volume = 7 * 4.5 * 2 %m^3
Area = 7 * 4.5 * Crew %m^2 to have required Algae exposion area
%Algae biomass concentration = 0.25 kg/m3
M = 0.25; %kg/m^3
M = 90; %kg total mass with water per human
Mass = 90 * Crew %kg
%Power chosen is 6 kW Xenon Lamps
Power = 6 * 20 * Crew %Power Requirements for Algae
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH')
%Higher plants study
Volume = 7 * 5 * 2; %m^3 per person's plants needs
Area = 7 * 5 * Crew*2 %m^2 per person's plants needs
Volume = Volume * Crew*2 %m^3 per crew
%PHYTOFY
Area_PH = 0.21; %m^2
Mass_PH = 8.9; %kg
Power_PH = 100; %W
%Total Values PHYTOFY
Units = Area/Area_PH %units needed for BLSS
Mass_PH = (Units/2) * Mass_PH %kg
Power = (Units/2) * Power_PH*1e-6 %MW
%Total estimates (Same water requirements assumption)
%Crops chosen with approximate areas based on Harvest Index Percentages [m^2]
Wheat = 13.2
Chufa = 2.87
Pea = 1.3
Carrot = 0.4
Radish = 0.3
Beets = 0.3
Kohlrabi = 0.34
Onion = 0.2
Dill = 0.03 %Since it grows everywhere in between of the other plants
Tomatoes = 0.4
Cucumbers = 0.14
Potatoes = 2.4
disp('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH')
%All of the mass comes from the water that is initially required for plants
%Per module (35 Crew members)
Mass_water = 330000/2 %Initial water in kg
Power %MW
Structure = 57220/2 %Assumption
Mass_total = (Mass_water + Mass_PH + Structure)*1e-3 %Mg
Area %m^2
Volume %m^3
disp('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH')
%Finals
Mass_PHY = 8.9; %kg
Area_left = (31.67*30) - (15*10)
Area_right = (36.67*30) - (3.14*2.5^2)
Volume_left_personal = Area_left*2
Volume_right_personal = Area_right*2
Volume_left_under = Area_left*0.5
Volume_right_under = Area_right*0.5
Volume_left_total = Area_left*2.5
Volume_right_total = Area_right*2.5
Volume_total_cycler = (Volume_left_total*2)+(Volume_right_total*2)
Area_total = Area_left+Area_right
Area_total_cycler = (Area_left+Area_right)*2
Units_PH_left = Area_left*2
Units_PH_right = Area_right*2
Units_PH_cycler = Area_total_cycler*2
Power = Units_PH_cycler*150
Power_left = Units_PH_left*150
Power_unit = Units_PH_cycler*75
Mass_PH_cycler = Mass_PHY*Units_PH_cycler*1e-3
Mass_PH_left = Mass_PHY*Units_PH_left*1e-3
Mass_PH_right = Mass_PHY*Units_PH_right*1e-3
Volume_water_cycler = 330 %m^3
Structurals_inner = 28.6*2+37 %3D graphene
Total_mass = Structurals_inner+Mass_PH_cycler+330

Wheat = 13.2*70
Chufa = 2.87*70
Pea = 1.3*70
Carrot = 0.4*70
Radish = 0.3*70
Beets = 0.3*70
Kohlrabi = 0.34*70
Onion = 0.2*70
Dill = 0.03*70 %Since it grows everywhere in between of the other plants
Tomatoes = 0.4*70
Cucumbers = 0.14*70
Potatoes = 2.4*70
total_crops_cycler = Wheat+Chufa+Pea+Carrot+Radish+Beets+Kohlrabi+Onion+Dill+Tomatoes+Cucumbers+Potatoes
crops_1_habitat = (total_crops_cycler/2)
crops_percent = (crops_1_habitat/Area_total)*100
crops_percent = (total_crops_cycler/Area_total_cycler)*100




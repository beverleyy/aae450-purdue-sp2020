data = csvread('ReportFile1.txt');
MJD = data(:,1);
SC1_Long = data(:,2);
SC2_Long = data(:,3);
SC3_Long = data(:,4);
plot(MJD, SC1_Long);
hold on
plot(MJD, SC2_Long);
plot(MJD, SC3_Long);
legend('SC1', 'SC2', 'SC3');
for ii = 2:length(MJD)
    diffSC2 = SC2_Long(ii)-SC2_Long(ii-1);
    diffSC3 = SC3_Long(ii)-SC3_Long(ii-1);
    if abs(diffSC2)>1
        SC2_Jump(ii)=1;
    else
        SC2_Jump(ii)=0;
    end
    if abs(diffSC3)>1
        SC3_Jump(ii)=1;
    else
        SC3_Jump(ii)=0;
    end    
end
MJD_SC2_Jump = MJD(find(SC2_Jump>0));
MJD_SC3_Jump = MJD(find(SC3_Jump>0));
Period_SC2 = MJD_SC2_Jump(3)-MJD_SC2_Jump(1)
Period_SC3 = MJD_SC3_Jump(3)-MJD_SC3_Jump(1)

PosSC2 = find(SC2_Jump>0);
PosSC3 = find(SC3_Jump>0);

SC2_Long(PosSC2(1):(PosSC2(2)-1)) = SC2_Long(PosSC2(1):(PosSC2(2)-1))-360;
SC2_Long(PosSC2(3):(PosSC2(4)-1)) = SC2_Long(PosSC2(3):(PosSC2(4)-1))-360;
SC2_Long(PosSC2(5):end) = SC2_Long(PosSC2(5):end)-360;

SC3_Long(PosSC3(1):(PosSC3(2)-1)) = SC3_Long(PosSC3(1):(PosSC3(2)-1))+360;
SC3_Long(PosSC3(3):(PosSC3(4)-1)) = SC3_Long(PosSC3(3):(PosSC3(4)-1))+360;

time = MJD-MJD(1);
figure
plot(time-time(1), SC1_Long);
hold on
plot(time-time(1), SC2_Long);
plot(time-time(1), SC3_Long);

mean_long_SC1 = mean(SC1_Long)
mean_long_SC2 = mean(SC2_Long(PosSC2(1):PosSC2(3)))
mean_long_SC3 = mean(SC3_Long(PosSC3(1):PosSC3(3)))

title('Mars Longitude Of Areostationary Satellites Over Time');
xlabel('Time (Days)');
ylabel('Longitude (Degrees)');
legend('S/C_1 at -17', 'S/C_2 at -137', 'S/C_3 at 103');

SC1_Long(1)
SC2_Long(1)
SC3_Long(1)

for ii = 2:length(MJD)
    diffSC1 = SC1_Long(ii)-SC1_Long(ii-1);
    diffSC2 = SC2_Long(ii)-SC2_Long(ii-1);
    diffSC3 = SC3_Long(ii)-SC3_Long(ii-1);
    firstderivSC1(ii) = diffSC1/(MJD(ii)-MJD(ii-1));
    firstderivSC2(ii) = diffSC2/(MJD(ii)-MJD(ii-1));
    firstderivSC3(ii) = diffSC3/(MJD(ii)-MJD(ii-1));
end
max(firstderivSC1)
max(firstderivSC2)
max(firstderivSC3)


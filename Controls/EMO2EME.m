function output = EMO2EME(input, E)

EMO2EME = [1,0,0;0,cosd(E),sind(E);0,-sind(E),cosd(E)];
x1 = [];
for count = 1:length(input(:,1))
    converted = EMO2EME*input(count,:)';
    x1 = [x1, converted];
end
output = x1;
function output = Planetradiation(A, T, Rp, c, rps)

E = 5.67*10^(-8) * T^4;
output = A.*E.*Rp.^2./(c.*rps.^2*149597871);
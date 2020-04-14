function vecdot = EoMs(v,vec)
k = 0;
w1 = vec(1);
w2 = vec(2);
w3 = vec(3);
e1 = vec(4);
e2 = vec(5);
e3 = vec(6);
e4 = vec(7);


par(1) = 2*pi*(-0.75*w2*w3+(k-1)*w3+4.5*(e2*e3+e1*e4)*(1-2*(e1^2)-2*(e2^2)));
par(2) = 0;
par(3) = 2*pi*(0.75*w1*w2-(k-1)*w1-9*(e3*e1-e2*e4)*(e2*e3+e1*e4));
par(4) = pi*(w1*e4-(w2-k)*e3+w3*e2);
par(5) = pi*(w1*e3+(w2-k-2)*e4-w3*e1);
par(6) = pi*(-w1*e2+(w2-k)*e1+w3*e4);
par(7) = pi*(-w1*e1-(w2-k-2)*e2-w3*e3);
vecdot = [par(1),par(2),par(3),par(4),par(5),par(6),par(7)]';
end
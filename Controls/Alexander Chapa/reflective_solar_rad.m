function sun_rad = reflective_solar_rad(A,a,Rp,f,c,ppos,cpos)
pdist = (ppos(:,1).^2+ppos(:,2).^2+ppos(:,3).^2).^(0.5);
sun_rad = 2.*A.*a.*Rp.^2.*f./(3.*c.*(ppos).^2.*(cpos).^2);
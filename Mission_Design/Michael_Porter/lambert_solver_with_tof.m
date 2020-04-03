function [a_solved, type, P_chosen, TA_deg] = lambert_solver_with_tof(TOF, r1_vec, r2_vec, mu)
% TA should be inputed in degrees
% TOF is in seconds
%r1 and r2 are in km
%mu is gravitational value in km^3/s^2 of the central body
% Code developed by Michael Porter

% solve for semi-major and semi-latus rectum with above values
    
    %break r1 and r2 into magnitudes
    r1 = norm(r1_vec); 
    r2 = norm(r2_vec);
    TA_deg = acosd( dot(r1_vec,r2_vec) / (r1 * r2) );
    TA = TA_deg * pi /180;

    c = sqrt(r1^2 + r2^2 - 2 * r1 * r2 * cos(TA));

    s = 0.5 * (r1 + r2 + c);

    amin = s/2;
    alpha_min = pi;
    beta_min = 2 * asin( sqrt( (s-c) / (2 * amin) ) );

    % need to determine if type
    % use TA to get 1 or 2, then use TOF compared to TOF_par to get elliptic or
    % par
    % if elliptic, need final comparison to TOF_min to get A or B
    if (TA < pi)
        % type 1 case, determine if elliptical or hyperbolic -- need TOF_par
        TOF_par = (1/3) * sqrt(2 / mu) * ( s^(3/2) - ( s-c )^ (3/2) );
        TOF_min = (1/sqrt(mu)) * amin^(3/2) * (alpha_min - sin(alpha_min) - beta_min + sin(beta_min));

        if (TOF > TOF_par)
            % elliptical case, need to determine if A or B using TOF_min
            if (TOF_min < TOF)
                % 1B elliptical
                type = '1B';
            else
                % 1A elliptical
                type = '1A';
            end   
        elseif (TOF < TOF_par)
            %hyperbolic case
            type = '1H'; 

        else
            %parabolic case
        end
    elseif (TA > pi)
        % type 2 case, determine if elliptical or hyperbolic -- need TOF_par
        TOF_par = (1/3) * sqrt(2 / mu) * ( s^(3/2) + ( s-c )^ (3/2) );
        TOF_min = (1/sqrt(mu)) * amin^(3/2) * (alpha_min - sin(alpha_min) + beta_min - sin(beta_min));

        if (TOF > TOF_par)
            % elliptical case, need to determine if A or B using TOF_min
            if (TOF_min < TOF)
                % 1B elliptical
                type = '2B';
            else
                % 1A elliptical
                type = '2A';
            end   
        elseif (TOF < TOF_par)
            %hyperbolic case
            type = '2H'; 

        else
            %parabolic case
        end
    else
        %hohmann
    end

    % now need to evaluate the different angles for each case -- use a switch
    % case structure to do so

    if (strcmp(type, '1A'))
        alpha = @(a) 2 * asin(sqrt(s / (2*a) ) );
        beta = @(a) 2* asin( sqrt( (s-c) / (2*a) ));
        lambert_tof = @(a) (1/sqrt(mu)) * a^(3/2) * (alpha(a) - sin(alpha(a)) - beta(a) + sin(beta(a)));
    elseif (strcmp(type, '1B'))
        alpha = @(a) 2*pi - 2 * asin(sqrt(s / (2*a) ) );
        beta = @(a) 2* asin( sqrt( (s-c) / (2*a) ));
        lambert_tof = @(a) (1/sqrt(mu)) * a^(3/2) * (alpha(a) - sin(alpha(a)) - beta(a) + sin(beta(a)));        
    elseif (strcmp(type, '1H'))
        alpha = @(a) 2 * asinh(sqrt(s / (2*abs(a)) ) );
        beta = @(a) 2* asinh( sqrt( (s-c) / (2*abs(a)) ));
        lambert_tof = @(a) (1/sqrt(mu)) * a^(3/2) * (-alpha(a) + sinh(alpha(a)) + beta(a) - sinh(beta(a)));

        %remember that amin is 0 for the hyperbolic case so change that
        amin = 0;
    elseif (strcmp(type, '2A'))
        alpha = @(a) 2 * asin(sqrt(s / (2*a) ) );
        beta = @(a) -2* asin( sqrt( (s-c) / (2*a) ));
        lambert_tof = @(a) (1/sqrt(mu)) * a^(3/2) * (alpha(a) - sin(alpha(a)) - beta(a) + sin(beta(a)));
    elseif (strcmp(type, '2B'))
        alpha = @(a) 2*pi - 2 * asin(sqrt(s / (2*a) ) );
        beta = @(a) -2* asin( sqrt( (s-c) / (2*a) ));
        lambert_tof = @(a) (1/sqrt(mu)) * a^(3/2) * (alpha(a) - sin(alpha(a)) - beta(a) + sin(beta(a)));        
    elseif (strcmp(type, '2H'))
        alpha = @(a) 2 * asinh(sqrt(s / (2*abs(a)) ) );
        beta = @(a) -2* asinh( sqrt( (s-c) / (2*abs(a)) ));
        lambert_tof = @(a) (1/sqrt(mu)) * a^(3/2) * (-alpha(a) + sinh(alpha(a)) + beta(a) - sinh(beta(a)));

        %remember that amin is 0 for the hyperbolic case so change that
        amin = 0;
    else
        fprintf('\nError: Type not recognized or programmed\n', 2)
    end
    
    %use an iterative solver to calculate a, will use fminbnd here
    
    a_solved = fminbnd(@(a) (lambert_tof(a) - TOF)^2, amin, c*10^5);
    
    %now need to calculate P, then hand calculations will be done for rest
    %of orbital parameters needed
    
    % first find the p roots for hyperbolic or elliptical
    
    if (strcmp(type(2), 'H'))
        a_solved = - a_solved;
        P1 = 4 * abs(a_solved) * (s-r1) * (s-r2) * (sinh( (alpha(a_solved) + beta(a_solved)) / 2))^2 / (c^2);
        P2 = 4 * abs(a_solved) * (s-r1) * (s-r2) * (sinh( (alpha(a_solved) - beta(a_solved)) / 2))^2 / (c^2);
    else
        P1 = 4 * a_solved * (s-r1) * (s-r2) * (sin( (alpha(a_solved) + beta(a_solved)) / 2))^2 / (c^2);
        P2 = 4 * a_solved * (s-r1) * (s-r2) * (sin( (alpha(a_solved) - beta(a_solved)) / 2))^2 / (c^2);
    end
    
    
    if (strcmp(type, '2B') || strcmp(type, '1A') || strcmp(type, '1H'))
        %choose the larger P value for these types
        P_chosen = max([P1, P2]);
    else
        %choose the smaller P values for these types
        P_chosen = min([P1, P2]);
    
    



end

function [energy_per_kg_mango, air_per_kg_mango] = ...
    idealDrying(UIaxes, m_hum_in, m_hum_out, s_air_t, s_air_hum, ...
    t_in, t_out)
%IDEALDRYING calculates an ideal convective dryer (e.g. ideal ATESTA)
%   
%   inputs:
%   m_hum_in:   humidity of raw-mango (in percent)
%   m_hum_out:  humidity of dry-mango (in percent)
%   s_air_hum:  humidity of air at the coldest point (in percent)
%   t_in:       air temperature entering the oven (burner temperature) in
%               degree Celsius
%   t_in:       air temperature leaving the oven (chimney temperature) in
%               degree Celsius
%   UIaxes:     GUI-Axes File to plot psychrometric chart
%   
%   outputs:
%   energy_per_kg_mango:    amount of energy used by ideal convective
%                           dryer
%   air_per_kg_mango:       amount of air used, to transport the needed
%                           energy (can be used to calculate a fan)

%% check User Input
if t_in <= t_out
    logFileGenerator('Wrong User Input in idealConvective');
    msgbox('Temperature_in must be higher than temperature_out!');
    energy_per_kg_mango = 0; 
    air_per_kg_mango    = 0;
    return
elseif m_hum_in <= m_hum_out
    logFileGenerator('Wrong User Input in idealConvective');
    msgbox('Humidity_in must be higher than Humidity_out!');
    energy_per_kg_mango = 0; 
    air_per_kg_mango    = 0;
    return
end

%% Calculation
%calculations are based on temperature in (Tdb), relative humidity of
%the air in % (phi) and absolut humidity of the air in kg/kg (w)
addpath('psychrometric');

% intitial situation
[Tdb, w, ~, h, ~, ~, ~] = Psychrometricsnew('Tdb', s_air_t, 'phi', s_air_hum);
processdata = [Tdb, w, h];

% heating up the air
[Tdb, w, ~, h, ~, ~, ~] = Psychrometricsnew('Tdb', t_in, 'w', w);
processdata = [processdata; Tdb, w, h];

% intake of water
[Tdb, w, ~, h, ~, ~, ~] = Psychrometricsnew('Tdb', t_out, 'h', h);
processdata = [processdata; Tdb, w, h];

clear('Tdb', 'w', 'h'); %a little bit of garbage handling

% numeric calculations
enthalpy_air_difference = processdata(2,3) - processdata(1,3);
delta_air_water_content = processdata(3,2) - processdata(2,2);
delta_m_hum = (m_hum_in-m_hum_out)/100;

energy_per_kg_mango = ...
    (delta_m_hum/delta_air_water_content)*enthalpy_air_difference;

% air used to transport exactly that amount of heat
air_per_kg_mango = ...
    ((1-processdata(3,2))/delta_air_water_content)*delta_m_hum;

%% generating Plot
%hold('on');
plot(UIaxes, processdata(:,1), processdata(:,2)*1000, '-r+');
end
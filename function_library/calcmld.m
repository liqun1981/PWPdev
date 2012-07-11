function [zmld] = calcmld(dens,z,dens_off)

% density offset threshold (kg/m3)
%dens_off = 0.125;

t = size(dens,2);
zmld = zeros(t,1);
for i = 1:t
    dens0 = dens(1,i);
    ml = find(dens(:,i) -dens0 > dens_off,1,'first');
    try
        zmld(i) = z(ml);
    catch
        zmld(i) = z(end);
    end
end
    
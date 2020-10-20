function [img, E_eV, x_m, y_m] = import_srw_me(filepath)
% IMPORT_SRW_ME Import SRW data from Sirepo (multi-electron)
%   [img, E_eV, x_m, y_m] = import_srw_me(filename)

% awojdyla@lbl.gov, October 2020

% determine number of lines
fid = fopen(filepath);
n_l = 0;
tline = fgetl(fid);
while ischar(tline)
    tline = fgetl(fid);
    n_l = n_l+1;
end
fclose(fid);

% read through data
fid = fopen(filepath);
i0 = 1;
n_f = 9; % number of fields
field = zeros(1,n_f);
data = zeros(1,n_l-n_f-1);
for i_l = 1:n_l
    line = fgetl(fid);
    %fprintf(line)
    %fprintf('\n')
    if (i_l-i0)>=1 && (i_l-i0)<=n_f
        line_split = strsplit(line, '#');
        field(i_l-1) = str2double(line_split{2});
    elseif (i_l-i0)>(n_f+1)
        data(i_l-n_f-i0) = str2double(line);
    end
end
fclose(fid);

E_eV = linspace(field(1), field(2), field(3));
x_m =  linspace(field(4), field(5), field(6));
y_m =  linspace(field(7), field(8), field(9));

img = squeeze(reshape(data(1:(end-1)), length(E_eV), length(x_m), length(y_m))).';
end
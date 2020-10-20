%% Testing imports from Sirepo

folder = '/Users/awojdyla/github/sirepo-utils/data/sample_data/';

%% single electron simulations

filename = 'sirepo_se ALS-U MAESTRO-U (nanoARPES) 350eV (K=2.7, G202a).dat';
filepath = [folder,filename];
[flux_fil_2d_ph_s_01bw, E_eV, x_m, y_m] = Gen4.import_srw(filepath);
%data units are intensity [ph/s/.1%bw/mm^2] (not efficiency in it)

% calculate the total flux
dx_mm = (x_m(2)-x_m(1))*1e3;
dy_mm = (y_m(2)-y_m(1))*1e3;
bw_01pcbw = 1/23000*1000;
flux_ph_s = sum(sum(flux_fil_2d_ph_s_01bw*dx_mm)*dy_mm*bw_01pcbw);

%%
imagesc(x_m*1e6, y_m*1e6, flux_fil_2d_ph_s_01bw)
xlabel('horizontal position [\mum]')
ylabel('vertical position [\mum]')
title({'MAESTRO XS221, 60 eV (se) [ph/s/mm^2]',sprintf('SRW, total = %1.1e ph/s @23,0000RP', flux_ph_s)})
axis image
colorbar

xlim([-25 25])
set(gca,'xTick',[-25:5:25])

ylim([-25 25])
set(gca,'yTick',[-25:5:25])







%% multi-electron simulations

filename = 'sirepo_me ALS-U MAESTRO-U (nanoARPES) 350eV (K=1.0, G202a).dat';
filepath = [folder,filename];
[flux_2d_ph_s_01bw, E_eV, x_m, y_m] = Gen4.import_srw_me(filepath);

% calculate the total flux
dx_mm = (x_m(2)-x_m(1))*1e3;
dy_mm = (y_m(2)-y_m(1))*1e3;
bw_01pcbw = 1;
flux_ph_s = sum(sum(flux_2d_ph_s_01bw*dx_mm)*dy_mm*bw_01pcbw);

%%
imagesc(x_m*1e6, y_m*1e6, flux_2d_ph_s_01bw)
xlabel('horizontal position [\mum]')
ylabel('vertical position [\mum]')
%title({'MAESTRO-U XS221, K=1.05, part. coh.',sprintf('350eV, G202a, tot= %1.1e ph/s/0.1BW', flux_ph_s)})
title({'MAESTRO-U XS221','K=1.05, partially coherent'})
axis image

h = colorbar;
ylabel(h, 'spectral flux density [ph/s/mm^2/0.1%BW]')

xlim([-25 25])
set(gca,'xTick',[-20:10:20])

ylim([-25 25])
set(gca,'yTick',[-20:10:20])

data_proj_x = squeeze(sum(flux_2d_ph_s_01bw,1));
data_proj_y = squeeze(sum(flux_2d_ph_s_01bw,2));

%[fwhm_x_px, xl_px, xr_px] = MIP.fwhm(data_proj_x);
%[fwhm_y_px, yl_px, yr_px] = MIP.fwhm(data_proj_y);
fwhm_x_m = fwhm_x_px*(dx_mm*1e-3);
fwhm_y_m = fwhm_y_px*(dy_mm*1e-3);

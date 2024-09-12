% function [out_ANFIS]=output_NET_fun();
clear all
close all
clc

out_Hx_=csvread("Hx_.txt");
out_Hy_=csvread("Hy_.txt");
out_Hz_=csvread("Hz_.txt");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% x component
fisx = readfis('ANFIS_Bx_negl_sys_triang_11');   % max abs error  -2.311 uT

n_xy=size(out_Hx_);
for nx=1:1:n_xy(1,1) 
    for ny=1:1:n_xy(1,2)
        out_fis_Bx(nx,ny)=evalfis(fisx,[nx ny]); 
        out_e_Bx(nx,ny)=out_Hx_(nx,ny)-out_fis_Bx(nx,ny); 
        if abs(out_e_Bx(nx,ny))==Inf
           out_e_Bx(nx,ny)=0;
        end
    end
end

% y component
fisy = readfis('ANFIS_By_negl_sys_triang_11');   % 
n_xy=size(out_Hy_);
for nx=1:1:n_xy(1,1) 
    for ny=1:1:n_xy(1,2)
        out_fis_By(nx,ny)=evalfis(fisy,[nx ny]); 
        out_e_By(nx,ny)=out_Hy_(nx,ny)-out_fis_By(nx,ny); 
        if abs(out_e_By(nx,ny))==Inf
           out_e_By(nx,ny)=0;
        end
    end
end

% z component
fisz = readfis('ANFIS_Bz_negl_sys_triang_11');   %   
n_xy=size(out_Hz_);
for nx=1:1:n_xy(1,1) 
    for ny=1:1:n_xy(1,2)
        out_fis_Bz(nx,ny)=evalfis(fisz,[nx ny]); 
        out_e_Bz(nx,ny)=out_Hz_(nx,ny)-out_fis_Bz(nx,ny); 
        if abs(out_e_Bz(nx,ny))==Inf
           out_e_Bz(nx,ny)=0;
        end
    end
end

% Removing of Inf from out_Hxyz_
for nx=1:1:n_xy(1,1)
    for ny=1:1:n_xy(1,2)
        if abs(out_Hx_(nx,ny))==Inf
            out_Hx_(nx,ny)=0;
        end
        if abs(out_Hy_(nx,ny))==Inf
            out_Hy_(nx,ny)=0;
        end
        if abs(out_Hz_(nx,ny))==Inf
            out_Hz_(nx,ny)=0;
        end
    end
end






ANFIS_xyz_MAE_bef=(sum(sum(abs(out_Hx_(:,:))))/(41*41-15*15)+sum(sum(abs(out_Hy_(:,:))))/(41*41-15*15)+sum(sum(abs(out_Hz_(:,:))))/(41*41-15*15))/3;
ANFIS_xyz_MAE=(sum(sum(abs(out_e_Bx(:,:))))/(41*41-15*15)+sum(sum(abs(out_e_By(:,:))))/(41*41-15*15)+sum(sum(abs(out_e_Bz(:,:))))/(41*41-15*15))/3;

[M1,I1]=max(abs(out_Hx_)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
ANFIS_x_max_abs_err_bef=abs(out_Hx_(I1(1,I),I));
ANFIS_x_max_abs_err_elem_n_bef=[I1(1,I),I];
ANFIS_x_MAE_bef=sum(sum(abs(out_Hx_(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_e_Bx)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
ANFIS_x_max_abs_err=abs(out_e_Bx(I1(1,I),I));
ANFIS_x_max_abs_err_elem_n=[I1(1,I),I];
ANFIS_x_MAE=sum(sum(abs(out_e_Bx(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_Hy_)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
ANFIS_y_max_abs_err_bef=abs(out_Hy_(I1(1,I),I));
ANFIS_y_max_abs_err_elem_n_bef=[I1(1,I),I];
ANFIS_y_MAE_bef=sum(sum(abs(out_Hy_(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_e_By)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
ANFIS_y_max_abs_err=abs(out_e_By(I1(1,I),I));
ANFIS_y_max_abs_err_elem_n=[I1(1,I),I];
ANFIS_y_MAE=sum(sum(abs(out_e_By(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_Hz_)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
ANFIS_z_max_abs_err_bef=abs(out_Hz_(I1(1,I),I));
ANFIS_z_max_abs_err_elem_n_bef=[I1(1,I),I];
ANFIS_z_MAE_bef=sum(sum(abs(out_Hz_(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_e_Bz)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
ANFIS_z_max_abs_err=abs(out_e_Bz(I1(1,I),I));
ANFIS_z_max_abs_err_elem_n=[I1(1,I),I];
ANFIS_z_MAE=sum(sum(abs(out_e_Bz(:,:))))/(41*41-15*15);

out_ANFIS_11=[ ANFIS_x_max_abs_err_bef; ANFIS_x_MAE_bef; ANFIS_x_max_abs_err; ANFIS_x_MAE;  
             ANFIS_y_max_abs_err_bef; ANFIS_y_MAE_bef; ANFIS_y_max_abs_err; ANFIS_y_MAE;
             ANFIS_z_max_abs_err_bef; ANFIS_z_MAE_bef; ANFIS_z_max_abs_err; ANFIS_z_MAE;
             ANFIS_xyz_MAE_bef; ANFIS_xyz_MAE;];
 
csvwrite("Results_ANFIS_11.txt",out_ANFIS_11);
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3D print, 3D heat map and 2D heat map

myfontname='times'; % set(gca,'fontname','times')  % Set it to times
my_myfontsize_label=10;
my_x_label='points';
my_y_label='trajectories';
my_z_label='uT';

% 3D heat map X
z=out_e_Bx;
fig_eBx=figure
surf(z.');
colorbar;
title('ANFIS 11 error B^x')
xlabel(my_x_label);
ylabel(my_y_label);
zlabel(my_z_label);
xlabel(my_x_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
ylabel(my_y_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
zlabel(my_z_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
%     xlim(my_xlim); %     zlim(my_zlim); %     xticks(my_xticks); %     yticks(my_yticks); %     zticks(my_zticks);
name_figure="eBx_heat_ANFIS_11.png";
saveas(fig_eBx,name_figure{1,1},'png');

% 3D heat map X
z=out_e_By;
fig_eBy=figure
surf(z.');
colorbar;
title('ANFIS 11 error B^y')
xlabel(my_x_label);
ylabel(my_y_label);
zlabel(my_z_label);
xlabel(my_x_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
ylabel(my_y_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
zlabel(my_z_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
%     xlim(my_xlim); %     zlim(my_zlim); %     xticks(my_xticks); %     yticks(my_yticks); %     zticks(my_zticks);
name_figure="eBy_heat_ANFIS_11.png";
saveas(fig_eBy,name_figure{1,1},'png');

% 3D heat map X
z=out_e_Bz;
fig_eBz=figure
surf(z.');
colorbar;
title('ANFIS 11 error B^z')
xlabel(my_x_label);
ylabel(my_y_label);
zlabel(my_z_label);
xlabel(my_x_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
ylabel(my_y_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
zlabel(my_z_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
%     xlim(my_xlim); %     zlim(my_zlim); %     xticks(my_xticks); %     yticks(my_yticks); %     zticks(my_zticks);
name_figure="eBz_heat_ANFIS_11.png";
saveas(fig_eBz,name_figure{1,1},'png');

% end
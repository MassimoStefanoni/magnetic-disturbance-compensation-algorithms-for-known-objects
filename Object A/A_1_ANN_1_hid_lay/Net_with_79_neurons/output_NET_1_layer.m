clear all
close all
clc

out_Hx_=csvread("Hx_.txt");
out_Hy_=csvread("Hy_.txt");
out_Hz_=csvread("Hz_.txt");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load netA_79; %
net=netA_79;

% Input creation
n_xy=size(out_Hx_);

for i=1:n_xy(1,1)
    for j=1:n_xy(1,1)        
        a=(21-i);
        b=(21-j);
        dist(i,j)=sqrt(a^2+b^2);
        if ((a>0)&&(b>0))
            ang(i,j)=atan(b/a)*57.2958;
        elseif ((a<0)&&(b>0))
            ang(i,j)=atan(b/a)*57.2958+180;
        elseif ((a<0)&&(b<0))
            ang(i,j)=atan(b/a)*57.2958-180;
        elseif ((a>0)&&(b<0))
            ang(i,j)=atan(b/a)*57.2958;
        elseif ((a==0)&&(b<0))
            ang(i,j)=-90;
        elseif ((a==0)&&(b>0))
            ang(i,j)=90;
        elseif ((a>0)&&(b==0))
            ang(i,j)=0;
        elseif ((a<0)&&(b==0))
            ang(i,j)=180;
        end
    end
end

% ANN simulation
for nx=1:1:n_xy(1,1)
    for ny=1:1:n_xy(1,2)
        out_net=sim(net,[dist(nx,ny);ang(nx,ny)]);
        out_net_Bx(nx,ny)=out_net(1,1);
        out_net_By(nx,ny)=out_net(2,1);
        out_net_Bz(nx,ny)=out_net(3,1);
        
        out_e_Bx(nx,ny)=out_Hx_(nx,ny)-out_net_Bx(nx,ny);
        if abs(out_e_Bx(nx,ny))==Inf
            out_e_Bx(nx,ny)=0;
        end
        
        out_e_By(nx,ny)=out_Hy_(nx,ny)-out_net_By(nx,ny);
        if abs(out_e_By(nx,ny))==Inf
            out_e_By(nx,ny)=0;
        end
        
        out_e_Bz(nx,ny)=out_Hz_(nx,ny)-out_net_Bz(nx,ny);
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

net_xyz_MAE_bef=(sum(sum(abs(out_Hx_(:,:))))/(41*41-15*15)+sum(sum(abs(out_Hy_(:,:))))/(41*41-15*15)+sum(sum(abs(out_Hz_(:,:))))/(41*41-15*15))/3;
net_xyz_MAE=(sum(sum(abs(out_e_Bx(:,:))))/(41*41-15*15)+sum(sum(abs(out_e_By(:,:))))/(41*41-15*15)+sum(sum(abs(out_e_Bz(:,:))))/(41*41-15*15))/3;

[M1,I1]=max(abs(out_Hx_)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
net_x_max_abs_err_bef=abs(out_Hx_(I1(1,I),I));
net_x_max_abs_err_elem_n_bef=[I1(1,I),I];
net_x_MAE_bef=sum(sum(abs(out_Hx_(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_e_Bx)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
net_x_max_abs_err=abs(out_e_Bx(I1(1,I),I));
net_x_max_abs_err_elem_n=[I1(1,I),I];
net_x_MAE=sum(sum(abs(out_e_Bx(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_Hy_)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
net_y_max_abs_err_bef=abs(out_Hy_(I1(1,I),I));
net_y_max_abs_err_elem_n_bef=[I1(1,I),I];
net_y_MAE_bef=sum(sum(abs(out_Hy_(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_e_By)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
net_y_max_abs_err=abs(out_e_By(I1(1,I),I));
net_y_max_abs_err_elem_n=[I1(1,I),I];
net_y_MAE=sum(sum(abs(out_e_By(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_Hz_)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
net_z_max_abs_err_bef=abs(out_Hz_(I1(1,I),I));
net_z_max_abs_err_elem_n_bef=[I1(1,I),I];
net_z_MAE_bef=sum(sum(abs(out_Hz_(:,:))))/(41*41-15*15);

[M1,I1]=max(abs(out_e_Bz)); % Provide the maximum in each column and put it in M1. In I1 the row where there is the maximum.
[M,I]=max(M1);
net_z_max_abs_err=abs(out_e_Bz(I1(1,I),I));
net_z_max_abs_err_elem_n=[I1(1,I),I];
net_z_MAE=sum(sum(abs(out_e_Bz(:,:))))/(41*41-15*15);

out_net=[ net_x_max_abs_err_bef; net_x_MAE_bef; net_x_max_abs_err; net_x_MAE;  
          net_y_max_abs_err_bef; net_y_MAE_bef; net_y_max_abs_err; net_y_MAE;
          net_z_max_abs_err_bef; net_z_MAE_bef; net_z_max_abs_err; net_z_MAE;
          net_xyz_MAE_bef; net_xyz_MAE;];

csvwrite("Results_NET_1_layer.txt",out_net);
         
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
title('NET error B^x')
xlabel(my_x_label);
ylabel(my_y_label);
zlabel(my_z_label);
xlabel(my_x_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
ylabel(my_y_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
zlabel(my_z_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
%     xlim(my_xlim); %     zlim(my_zlim); %     xticks(my_xticks); %     yticks(my_yticks); %     zticks(my_zticks);
name_figure="eBx_heat_NET.png";
saveas(fig_eBx,name_figure{1,1},'png');

% 3D heat map X
z=out_e_By;
fig_eBy=figure
surf(z.');
colorbar;
title('NET error B^y')
xlabel(my_x_label);
ylabel(my_y_label);
zlabel(my_z_label);
xlabel(my_x_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
ylabel(my_y_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
zlabel(my_z_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
%     xlim(my_xlim); %     zlim(my_zlim); %     xticks(my_xticks); %     yticks(my_yticks); %     zticks(my_zticks);
name_figure="eBy_heat_NET.png";
saveas(fig_eBy,name_figure{1,1},'png');

% 3D heat map X
z=out_e_Bz;
fig_eBz=figure
surf(z.');
colorbar;
title('NET error B^z')
xlabel(my_x_label);
ylabel(my_y_label);
zlabel(my_z_label);
xlabel(my_x_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
ylabel(my_y_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
zlabel(my_z_label,'Fontsize', my_myfontsize_label,'fontweight','bold');
%     xlim(my_xlim); %     zlim(my_zlim); %     xticks(my_xticks); %     yticks(my_yticks); %     zticks(my_zticks);
name_figure="eBz_heat_NET.png";
saveas(fig_eBz,name_figure{1,1},'png');
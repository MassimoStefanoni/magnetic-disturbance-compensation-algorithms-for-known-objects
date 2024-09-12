% function [  ] = trainNeglectNN(  )
clear all

MAX_HNN_NUM=100;

INPUTS=csvread('INPUTS.csv');
TARGETS=csvread('TARGETS.csv');

ORIG_DIFFS=abs(TARGETS);

RESULTS=[];

for i=1:MAX_HNN_NUM

    net = fitnet([i i]);
%     net = feedforwardnet(i);

    %net.trainFcn = 'trainscg';
    net.trainFcn = 'trainlm';
    net.trainParam.epochs=3000;
    net.trainParam.max_fail=15;
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'tansig';
    net.layers{3}.transferFcn = 'purelin';
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 30/100;
    %net.efficiency.memoryReduction=2;

    net = configure(net,INPUTS',TARGETS');
    %view(net)
    net = train(net,INPUTS',TARGETS');
    %Classification
    outs=[];
    outs=net(INPUTS')';
    DIFFERENCES=[];
    diff=0;
    for j=1:size(INPUTS,1)
        for k=1:3
            diff=diff+abs(outs(j,k)-TARGETS(j,k));
            DIFFERENCES(j,k)=abs(outs(j,k)-TARGETS(j,k));
        end
    end
    RESULTS(i,1)=(mean(ORIG_DIFFS(:,1))+mean(ORIG_DIFFS(:,2))+mean(ORIG_DIFFS(:,3)))/3;
    RESULTS(i,2)=diff/size(INPUTS,1)/3;
    %X AXIS
    RESULTS(i,3)=max(ORIG_DIFFS(:,1));
    RESULTS(i,4)=max(DIFFERENCES(:,1));
    RESULTS(i,5)=mean(ORIG_DIFFS(:,1));
    RESULTS(i,6)=mean(DIFFERENCES(:,1));
    %Y AXIS
    RESULTS(i,7)=max(ORIG_DIFFS(:,2));
    RESULTS(i,8)=max(DIFFERENCES(:,2));
    RESULTS(i,9)=mean(ORIG_DIFFS(:,2));
    RESULTS(i,10)=mean(DIFFERENCES(:,2));
    %Z AXIS
    RESULTS(i,11)=max(ORIG_DIFFS(:,3));
    RESULTS(i,12)=max(DIFFERENCES(:,3));
    RESULTS(i,13)=mean(ORIG_DIFFS(:,3));
    RESULTS(i,14)=mean(DIFFERENCES(:,3));
    
    cd OUTPUT
    filename=strcat('OUTPUT_2_layers',int2str(i),'.csv');
    csvwrite(filename,outs);
    cd ..
    
end
csvwrite('RESULTS_2_layers.csv',RESULTS);

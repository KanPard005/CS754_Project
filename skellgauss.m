clear;
clc;

img = imread('trial.png');
patchsize = 200;

get_plots(img(1:patchsize, 1:patchsize, 1));
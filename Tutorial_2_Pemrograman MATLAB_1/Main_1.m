% input dan output

clear
clc

% input

x_angka = input('masukkan angka: ');

% output

str_format = sprintf('angka yang anda input adalah %d',x_angka);
disp(str_format);

file = fopen('data.txt','a'); % mode ada read, write, append
fprintf(file,'\nangka yang anda input adalah %d ',x_angka);
fclose(file);







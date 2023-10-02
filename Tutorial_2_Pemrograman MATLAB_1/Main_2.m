% Percabangan
clear
clc
% input user
x_string = input('siapa nama anda? ', 's');

if strcmp(x_string,'ikal')
    disp(sprintf('hallo %s',x_string));
else
    disp('siape lu!');
end
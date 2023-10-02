% ini adalah komentar yang tidak akan dieksekusi

clear % membersihkan history
clc % membersihkan command window

% import pustaka elvis dan variable power supplies
import elvis.VarPowSupply;

% membuat objek baru dari variable power supplies
vps = VarPowSupply;

% ubah tegangan positif menjadi 5 volt
vps.Vpos = 5;
vps.Vneg = -3;

% sudah selesai dan delete objek vps
% delete(vps); <-- lakukan ini di command window, jika diaktifkan disini
% akan berubah menjadi 0 volt
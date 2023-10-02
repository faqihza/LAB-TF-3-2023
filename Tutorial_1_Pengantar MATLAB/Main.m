clear
clc

%% section 1
% ini adalah komentar
a = 10;

%% section 2

vector_a = [1,2,3,4,5];
vector_b = [6 7 8 9 10];

hasil_jumlah = vector_a + vector_b;
hasil_kali = vector_a * vector_b';
hasil_kali_elemen = vector_a.*vector_b;

%% section 3

matrix_m = [1,2,3;4,5,6;7,8,-9]
matrix_n = [-9 8 7;6 5 4;3 2 1]
matrix_o = [1 2 3;
            4 5 6;
            7 8 9]

inv_m = inv(matrix_m)
det_n = det(matrix_n)

hasil_kali_matrix = matrix_m*matrix_o

[veceig_o,eig_o] = eig(matrix_o)












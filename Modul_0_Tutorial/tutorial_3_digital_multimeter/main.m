clear % membersihkan history
clc % membersihkan command window

import elvis.Multimeter;

% membuat objek DMM (digital multimeter) multimeter
digital_multimeter = Multimeter('resistance');

% menampilkan DMM range
disp(digital_multimeter.RangeValStrings);

% ubah range pengukuran (sesuaikan dengan resistor yang akan diukur)
digital_multimeter.Range = '1kohm';

% rekam data

data_resistansi = digital_multimeter.readData;

% tampilkan data
str_to_print = sprintf('%0.2f Ohm',data_resistansi);
disp(str_to_print);
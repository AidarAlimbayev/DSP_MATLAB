script
clc
disp('% �� �20. ������������� ������� ����������� ��������� � ���������� ����������')
disp('%')
disp('%')
disp('% ������� �������� ������');
DATA=0;
while DATA==0
Nb = input('Nb = ');  % ����� �������
A1 = input('A1 = ');  % ��������� ���������� �������� �������� �������
A2 = input('A2 = ');
f1 = input('f1 = ');  % ������� (��) ���������� �������� �������� �������
f2 = input('f2 = ');
Nd = input('Nd = ');        % ������ �������� �������
Fs_d = input('Fs_d = ');    % ������� ������������� �������� �������
M = input('M = ');          % ����������� ���������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('% ��� ������ �������� Nd, Fs_d � M ������� <ENTER>')
pause
disp('%')
disp(['	N = Nd = ',num2str(Nd),'      Fs = Fs_d = ',num2str(Fs_d)])
disp('%')
disp(['      	M = ',num2str(M)])
N = Nd;           % ������ �������� �������
Fs = Fs_d;        % ������� ������������� �������� �������
n = 0:(N-1);      % ���������� ������������� ����� �������� �������
x = A1*sin((2*pi*f1/Fs).*n)+A2*sin((2*pi*f2/Fs).*n);% ������� ������
y = filter(Hd,x);               % �������� ������
nd_start = ceil(length(y)/2+1); % ������ ��������������� ������
yd = y(nd_start:end);           % �������� ������ � �������������� ������
nd = nd_start:(nd_start+length(yd)-1);  % ���������� ������������� ����� ��� ��������������� ������
disp('%')
disp('% ��� ������ �������� �������� � ��������� �������� ������� <ENTER>')
pause
figure('Name','Input and Output Signals in Polyphase Structure Decimation System','NumberTitle', 'off')
subplot(3,1,1), stem(n,x), grid, xlabel('n')
title(strcat(['Input Signal x(n)      N = ',num2str(N)]))
subplot(3,1,2), stem(0:length(y)-1,y), grid
title(strcat(['M = ',num2str(M),'  Output Signal y(n)   length(y) = ',num2str(length(y))]))
subplot(3,1,3), stem(nd,yd), grid, xlabel('n')
title(strcat(['Output Signal y(n)   Starting point n = ',num2str(nd_start),'   length(y) = ',num2str(length(yd))]))
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� � ��� ���-������� ������� <ENTER>')
pause
X = fft(x);                % ��� �������� �������
MODX = (2/N)*abs(X);       % ����������� ������ �������� �������
MODX(1) = (1/N)*abs(X(1));
Yd = fft(yd);              % ��� ��������� ������� � �������������� ������
MODYd = (2/length(Yd))*abs(Yd);    % ����������� ������ ��������� �������
MODYd(1) = (1/length(Yd))*abs(Yd(1));
k = 0:(N-1);           % ���������� ������������� ������� �������� �������
kd = 0:(length(Yd)-1); % ���������� ������������� ������� ��������� �������
f = 0:Fs/1000:Fs;                   % ����� ������ ��� ��� ���-�������
hd = Hd.Numerator;                  % �� ���-�������
MAG = abs(freqz(hd,1,f,Fs));        % ��� ���-�������
figure('Name','Amplitude Spectrums and Magnitude Response in Polyphase Structure Decimation System','NumberTitle', 'off')
subplot(2,1,1), stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 Fs])
title(strcat('Amplitude Spectrum x(n) and FIR Magnitude Response'))
hold on, plot(f,MAG,'r','Linewidth',2)
subplot(2,1,2),stem(kd*((Fs/M)/length(Yd)),MODYd,'MarkerSize',3, 'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 Fs])
title(strcat(['M = ',num2str(M),'   Amplitude Spectrum y(n)']))
disp('%')
disp('%')
disp('% ������������� ������� ����������� ��������� � ���������� ���������� ���������')



























































































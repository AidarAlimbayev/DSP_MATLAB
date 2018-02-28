script
clc
disp('% �� �20. ������������� ������� ����������� ����������������� � ���������� ����������')
disp('% ��� ��������� ������� �������������')
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
Nrd = input('Nrd = ');        % ������ �������� �������
Fs_rd = input('Fs_rd = ');    % ������� ������������� �������� �������
L = input('L = ');            % ����������� ������������
M = input('M = ');            % ����������� ���������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('%')
disp('% ��� ������ �������� Nrd, Fs_rd � L/M ������� <ENTER>')
pause
disp('%')
disp(['      N = Nrd = ',num2str(Nrd),'      Fs = Fs_rd = ',num2str(Fs_rd)])
disp('%')
disp(['      	L/M = ',num2str(L),'/',num2str(M)])
pause
N = Nrd;           % ������ �������� �������
Fs = Fs_rd;        % ������� ������������� �������� �������
n = 0:(N-1);       % ���������� ������������� ����� �������� �������
x = A1*sin((2*pi*f1/Fs).*n)+A2*sin((2*pi*f2/Fs).*n);% ������� ������
y = L*filter(Hrd,x);       % �������� ������, ���������� �� ����������� ������������
nrd_start = ceil(length(y)/2+1); % ������ ��������������� ������
yrd = y(nrd_start:end);          % �������� ������ � �������������� ������
nrd = nrd_start:(nrd_start+length(yrd)-1);  % ���������� ������������� ����� ��� ��������������� ������
disp('%')
disp('% ��� ������ �������� �������� � ��������� �������� ������� <ENTER>')
figure('Name','Input and Output Signals in Polyphase Structure Resampling System','NumberTitle', 'off')
subplot(3,1,1), stem(n,x), grid, xlabel('n')
title(strcat(['Input Signal x(n)      N = ',num2str(N)]))
subplot(3,1,2), stem(0:length(y)-1,y), grid
title(strcat(['L = ',num2str(L),' M = ',num2str(M),'  Output Signal y(n)   length(y) = ',num2str(length(y))]))
subplot(3,1,3), stem(nrd,yrd), grid, xlabel('n')
title(strcat(['Output Signal y(n)   Starting point n = ',num2str(nrd_start),'   length(y) = ',num2str(length(yrd))]))
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� � ��� ���-������� ������� <ENTER>')
pause
X = fft(x);                % ��� �������� �������
MODX = (2/N)*abs(X);       % ����������� ������ �������� �������
MODX(1) = (1/N)*abs(X(1));
Yrd = fft(yrd);            % ��� ��������� ������� � �������������� ������
MODYrd = (2/length(Yrd))*abs(Yrd);    % ����������� ������ ��������� �������
MODYrd(1) = (1/length(Yrd))*abs(Yrd(1));
k = 0:(N-1);           % ���������� ������������� ������� �������� �������
krd = 0:(length(Yrd)-1); % ���������� ������������� ������� ��������� �������
f = 0:Fs/1000:Fs;                   % ����� ������ ��� ��� ���-�������
h = Hrd.Numerator;                  % �� ���-�������
MAG = abs(freqz(h,1,f,Fs));         % ��� ���-�������
figure('Name','Amplitude Spectrums and Magnitude Response in Polyphase Structure Resampling System','NumberTitle', 'off')
subplot(2,1,1), stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 Fs])
title(strcat('Amplitude Spectrum x(n) and FIR Magnitude Response'))
hold on, plot(f,MAG,'r','Linewidth',2)
subplot(2,1,2)
stem(krd*(Fs*(L/M)/length(Yrd)),MODYrd,'MarkerSize',3, 'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 Fs])
title(strcat(['L/M = ',num2str(L),'/',num2str(M),'  Amplitude Spectrum y(n)']))
disp('%')
disp('%')
disp('% ������������� ������� ����������� ����������������� � ���������� ���������� ���������')

































































































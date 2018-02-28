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
Nri = input('Nri = ');        % ������ �������� �������
Fs_ri = input('Fs_ri = ');    % ������� ������������� �������� �������
L = input('L = ');            % ����������� ������������
M = input('M = ');            % ����������� ���������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('%')
disp('% ��� ������ �������� Nri, Fs_ri � L/M ������� <ENTER>')
pause
disp('%')
disp(['      N = Nri = ',num2str(Nri),'      Fs = Fs_ri = ',num2str(Fs_ri)])
disp('%')
disp(['      	L/M = ',num2str(L),'/',num2str(M)])
N = Nri;           % ������ �������� �������
Fs = Fs_ri;        % ������� ������������� �������� �������
n = 0:(N-1);       % ���������� ������������� ����� �������� �������
x = A1*sin((2*pi*f1/Fs).*n)+A2*sin((2*pi*f2/Fs).*n); % ������� ������
y = L*filter(Hri,x);             % �������� ������, ���������� �� ����������� ������������
nri_start = ceil(length(y)/2+1); % ������ ��������������� ������
yri = y(nri_start:end);          % �������� ������ � �������������� ������
nri = nri_start:(nri_start+length(yri)-1);  % ���������� ������������� ����� ��� ��������������� ������
disp('%')
disp('% ��� ������ �������� �������� � ��������� �������� ������� <ENTER>')
pause
figure('Name','Input and Output Signals in Polyphase Structure Resampling System','NumberTitle', 'off')
subplot(3,1,1), stem(n,x), grid, xlabel('n')
title(strcat(['Input Signal x(n)      N = ',num2str(N)]))
subplot(3,1,2), stem(0:length(y)-1,y), grid
title(strcat(['L = ',num2str(L),' M = ',num2str(M),'  Output Signal y(n)   length(y) = ',num2str(length(y))]))
subplot(3,1,3), stem(nri,yri), grid, xlabel('n')
title(strcat(['Output Signal y(n)   Starting point n = ',num2str(nri_start),'   length(y) = ',num2str(length(yri))]))
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� � ��� ���-������� ������� <ENTER>')
pause
X = fft(x);               % ��� �������� �������
MODX = (2/N)*abs(X);      % ����������� ������ �������� �������
MODX(1) = (1/N)*abs(X(1));
Yri = fft(yri);           % ��� ��������� ������� � �������������� ������
MODYri = (2/length(Yri))*abs(Yri);    % ����������� ������ ��������� �������
MODYri(1) = (1/length(Yri))*abs(Yri(1));
k = 0:(N-1);           % ���������� ������������� ������� �������� �������
kri = 0:(length(Yri)-1); % ���������� ������������� ������� ��������� �������
f = 0:(Fs*(L/M))/1000:Fs*(L/M);        % ����� ������ ��� ��� ���-�������
h = Hri.Numerator;                     % �� ���-�������
MAG = abs(freqz(h,1,f,Fs*(L/M)));      % ��� ���-�������
figure('Name','Amplitude Spectrums and Magnitude Response in Polyphase Structure Resampling System','NumberTitle', 'off')
subplot(2,1,1), stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 (L/M)*Fs])
title(strcat(['Amplitude Spectrum x(n)   N = ',num2str(N)]))
subplot(2,1,2)
stem(kri*(Fs*(L/M)/length(Yri)),MODYri,'MarkerSize',3, 'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 (L/M)*Fs])
title(strcat(['L/M = ',num2str(L),'/',num2str(M),'  Amplitude Spectrum y(n) and FIR Magnitude Response']))
hold on, plot(f,MAG,'r','Linewidth',2)
disp('%')
disp('%')
disp('% ������������� ������� ����������� ����������������� � ���������� ���������� ���������')





























































































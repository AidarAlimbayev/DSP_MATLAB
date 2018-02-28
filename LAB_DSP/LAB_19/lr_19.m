script
clc
clear
disp('% �� �19. ��������������� ������� ���')
disp('%')
disp('%')
disp('% ������� �������� ������');
DATA=0;
while DATA==0
Nb = input('Nb = ');   % ����� �������
A1 = input('A1 = ');   % ��������� ���������� �������� �������� �������
A2 = input('A2 = ');
f1 = input('f1 = ');   % ������� (��) ���������� �������� �������� �������
f2 = input('f2 = ');
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA=input('--> ');
end
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.1. ������������� ������� ����������� ������������')
disp('%')
disp('%')
disp('% ������� �������� ������');
DATA=0;
while DATA==0
Ni = input('Ni = ');        % ������ �������� �������
Fs_i = input('Fs_i = ');    % ������� ������������� �������� �������
L = input('L = ');          % ������ ������������� ������������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('% ��� ������ �������� Ni, Fs_i � L ������� <ENTER>')
pause
disp('%')
disp(['      N = Ni = ',num2str(Ni),'      Fs = Fs_i = ',num2str(Fs_i)])
disp('%')
disp(['      L = [',num2str(L) ']'])
disp('%')
disp('% ��� ������ �������� �������� � �������� �������� ������� <ENTER>')
pause
N = Ni;           % ������ �������� �������
Fs = Fs_i;        % ������� ������������� �������� �������
n = 0:(N-1);      % ���������� ������������� ����� �������� �������
x = A1*sin((2*pi*f1/Fs).*n)+A2*sin((2*pi*f2/Fs).*n);% ������� ������
figure('Name','Input and Output Signals in Interpolation System','NumberTitle', 'off')
subplot(4,1,1), stem(n,x), grid, xlabel('n')
title(strcat(['Input Signal x(n)   N = ',num2str(N)]))
for i = 1:length(L)                % ������� ������� L
[y{i},h{i}] = interp(x,L(i));      % �������� ������ � �� ���-������� (cell array)
subplot(4,1,i+1), stem(0:length(y{i})-1,y{i}), grid, xlabel('n')
title(strcat(['L = ',num2str(L(i)),'   Output Signal y(n)   length(y) = ',num2str(length(y{i}))]))
end
disp('%')
disp('%')
disp('% ��� ������ �������� ���������� ������������� ���-�������� ������� <ENTER>')
pause
figure('Name','Impulse Responses FIR in Interpolation System','NumberTitle', 'off')
for i = 1:length(L)                 % ������� ������� L
subplot(3,1,i), stem(0:length(h{i})-1,   h{i},'MarkerSize',3,'Linewidth',2), grid, xlabel('n')
title(strcat(['L = ',num2str(L(i)),'   Impulse Response h(n)   length(h) = ',num2str(length(h{i}))]))
end
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.2. ���������� ����������� �������� �������� � ��� ���-��������')
disp('% ������� ����������� ������������')
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� � ��� ���-��������')
disp('% � "�����" ����� ������ ������� <ENTER>')
pause
X = fft(x);                    % ��� �������� �������
MODX = (2/N)*abs(X);           % ����������� ������ �������� �������
MODX(1) = (1/N)*abs(X(1));
k = 0:N-1;       % ���������� ������������� ������� �������� �������
figure('Name','Amplitude Spectrums and Magnitude Responses ("new" frequencies)','NumberTitle', 'off')
subplot(4,1,1), stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), title(strcat(['Amplitude Spectrum x(n)   N = ',num2str(N)]))
f = 0:Fs/1000:Fs;    % ����� ������ ��� ��� ���-������� � "�����" �����
for i = 1:length(L)          % ������� ������� L
Y{i} = fft(y{i});            % ��� ��������� �������(cell array)
Y_D = Y{i};                  % ��� ��������� �������(double)
MODY_D = (2/length(Y_D))*abs(Y_D); % ����������� ������ ��������� �������(double) 
MODY_D(1) = (1/length(Y_D))*abs(Y_D(1));
MODY{i} = MODY_D;  % ����������� ������ ��������� �������(cell array)
MAG = abs(freqz(h{i},1,f,Fs));   % ��� ���-�������
k_out = 0:length(Y{i})-1;        % ���������� ������������� ������� ��������� �������
subplot(4,1,i+1), stem(k_out*(Fs/length(Y{i})),MODY{i},'MarkerSize',3,'Linewidth',2)
grid, xlabel('f � (Hz) ("new" frequencies)')
title(strcat(['L = ',num2str(L(i)),'   Amplitude Spectrum y(n) and FIR Magnitude Response']))
hold on, plot(f,MAG,'r','Linewidth',2)
end
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� � ��� ���-��������')
disp('% � "������" ����� ������ ������� <ENTER>')
pause
figure('Name','Amplitude Spectrums and Magnitude Responses ("old" frequencies)','NumberTitle', 'off')
subplot(4,1,1), stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 max(L)*Fs])
title(strcat(['Amplitude Spectrum x(n)    N=',num2str(N)]))
for i = 1:length(L)                   % ������� ������� L
f = 0:(Fs*L(i))/1000:(Fs*L(i));       % ����� ������ ��� ��� ���-������� � "������" �����
MAG = abs(freqz(h{i},1,f,(Fs*L(i)))); % ��� ���-�������
k_out = 0:length(Y{i})-1;             % ���������� ������������� ������� ��������� �������
subplot(4,1,i+1),stem(k_out*(Fs*L(i)/length(Y{i})),MODY{i},'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz) ("old" frequencies)'), xlim([0 max(L)*Fs])
title(strcat(['L = ',num2str(L(i)),'   Amplitude Spectrum y(n) and FIR Magnitude Response']))
hold on, plot(f,MAG,'r','Linewidth',2)
end
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.3. ������������� ������� ����������� ���������')
disp('%')
disp('%')
disp('% ������� �������� ������');
DATA=0;
while DATA==0
Nd = input('Nd = ');        % ������ �������� �������
Fs_d = input('Fs_d = ');    % ������� ������������� �������� �������
M = input('M = ');          % ������ ������������� ���������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('% ��� ������ �������� Nd, Fs_d � M ������� <ENTER>')
pause
disp('%')
disp(['      	N = Nd = ',num2str(Nd),'      Fs = Fs_d = ',num2str(Fs_d)])
disp('%')
disp(['      	M = [',num2str(M) ']'])
disp('%')
disp('% ��� ������ �������� �������� � �������� �������� ������� <ENTER>')
pause
N = Nd;            % ������ �������� �������
Fs = Fs_d;         % ������� ������������� �������� �������
n = 0:(N-1);       % ���������� ������������� ����� �������� �������
x = A1*sin((2*pi*f1/Fs).*n)+A2*sin((2*pi*f2/Fs).*n);% ������� ������
figure('Name','Input and Output Signals in Decimation System','NumberTitle', 'off')
subplot(4,1,1), stem(n,x), grid, xlabel('n')
title(strcat(['Input Signal x(n)      N = ',num2str(N)]))
for i = 1:length(M)              % ������� ������� M
y{i} = decimate(x,M(i),'fir');   % �������� ������(cell array)
subplot(4,1,i+1), stem(0:length(y{i})-1,y{i}), grid, xlabel('n')
title(strcat(['M = ',num2str(M(i)),'   Output Signal y(n)   length(y) = ',num2str(length(y{i}))]))
end
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.4. ���������� ����������� �������� ��������')
disp('% ������� ����������� ���������')
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� ������� <ENTER>')
pause
X = fft(x);                     % ��� �������� �������
MODX = (2/N)*abs(X);            % ����������� ������ �������� �������
MODX(1) = (1/N)*abs(X(1));
k = 0:N-1;         % ���������� ������������� ������� �������� �������
figure('Name','Amplitude Spectrums in Decimation System','NumberTitle', 'off')
subplot(4,1,1), stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'),title(strcat(['Amplitude Spectrum x(n)   N = ',num2str(N)])), xlim([0 Fs])
for i = 1:length(M)                   % ������� ������� M 
Y{i} = fft(y{i});                     % ��� ��������� �������
Y_D = Y{i};                           % ��� ��������� �������(double)
MODY_D = (2/length(Y_D))*abs(Y_D);    % ����������� ������ ��������� �������(double)
MODY_D(1) = (1/length(Y_D))*abs(Y_D(1));
MODY{i} = MODY_D; % ����������� ������ ��������� �������(cell array)
k_out = 0:length(Y{i})-1;             % ���������� ������������� ������� ��������� �������
subplot(4,1,i+1),stem(k_out*(Fs/M(i)/length(Y{i})),MODY{i},'MarkerSize',3, 'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 Fs])
title(strcat(['M = ',num2str(M(i)),'   Amplitude Spectrum y(n)']))
end
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.5. ������������� ������� ����������� �����������������')
disp('%')
disp('%')
disp('% ������� �������� ������');
DATA=0;
while DATA==0
Nr = input('Nr = ');        % ������ �������� �������
Fs_r = input('Fs_r = ');    % ������� ������������� �������� �������
L = input('L = ');          % ����������� ������������
M = input('M = ');          % ����������� ���������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('% ��� ������ �������� Nr, Fs_r � L/M ������� <ENTER>')
pause
disp('%')
disp(['      N = Nr = ',num2str(Nr),'      Fs = Fs_r = ',num2str(Fs_r)])
disp('%')
disp(['      	L/M = ',num2str(L),'/',num2str(M)])
disp('%')
disp('% ��� ������ �������� �������� � �������� �������� ������� <ENTER>')
pause
N = Nr;              % ������ �������� �������
Fs = Fs_r;           % ������� ������������� �������� �������
n = 0:(N-1);         % ���������� ������������� ����� �������� �������
x = A1*sin((2*pi*f1/Fs).*n)+A2*sin((2*pi*f2/Fs).*n);  % ������� ������
figure('Name','Input and Output Signals in Resampling System','NumberTitle', 'off')
subplot(2,1,1), stem(n,x), grid, xlabel('n')
title(strcat(['Input Signal x(n)      N = ',num2str(N)]))
[y h] = resample(x,L,M);            % �������� ������ � �� ���-�������
subplot(2,1,2), stem(0:length(y)-1,y), grid, xlabel('n')
title(strcat(['L/M = ',num2str(L),'/',num2str(M),'  Output Signal y(n)   length(y) = ',num2str(length(y))]))
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.6. ���������� ����������� �������� �������� � ��� ���-�������')
disp('% ������� ����������� �����������������')
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� � ��� ���-������� ������� <ENTER>')
pause
figure('Name','Amplitude Spectrums and Magnitude Responses in Resampling System','NumberTitle', 'off')
X = fft(x);                     % ��� �������� �������
MODX = (2/N)*abs(X);            % ����������� ������ �������� �������
MODX(1) = (1/N)*abs(X(1));
k = 0:N-1;            % ���������� ������������� ������� �������� �������
subplot(2,1,1),stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), title(strcat(['Amplitude Spectrum x(n)   N = ',num2str(N)])), xlim([0 (L/M)*Fs])
Y = fft(y);                         % ��� ��������� �������
MODY = (2/length(Y))*abs(Y);        % ����������� ������ ��������� �������
MODY(1) = (1/length(Y))*abs(Y(1));
k_out = 0:length(Y)-1;              % ���������� ������������� ������� ��������� �������
f = 0:Fs*(L/M)/1000:(Fs*(L/M));     % ����� ������ ��� ��� ���-�������
MAG = abs(freqz(h,1,f,(Fs*(L/M)))); % ��� ���-�������
subplot(2,1,2), stem(k_out*(Fs*(L/M)/length(Y)),MODY,'MarkerSize',3, 'Linewidth',2)
grid, xlabel('f (Hz)')
title(strcat(['L/M = ',num2str(L),'/',num2str(M),'  Amplitude Spectrum y(n) and FIR Magnitude Response']))
hold on, plot(f,MAG,'r','Linewidth',2), xlim([0 (L/M)*Fs])
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.7. ������������� ������� ����������� ������������ � ���������� ����������')
disp('%')
disp('%')
disp('% ������� �������� ������');
DATA=0;
while DATA==0
Nip = input('Nip = ');       % ������ �������� �������
Fs_ip = input('Fs_ip = ');   % ������� ������������� �������� �������
L = input('L = ');           % ����������� ������������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('% ��� ������ �������� Ni, Fs_ip � L ������� <ENTER>')
pause
disp('%')
disp(['      	N = Nip = ',num2str(Nip),'      Fs = Fs_ip = ',num2str(Fs_ip)])
disp('%')
disp(['      	L = ',num2str(L)])
N = Nip;                % ������ �������� �������
Fs = Fs_ip;             % ������� ������������� �������� �������
n = 0:(N-1);            % ���������� ������������� ����� �������� �������
x = A1*sin((2*pi*f1/Fs).*n)+A2*sin((2*pi*f2/Fs).*n);% ������� ������
disp('%')
disp('% ��� ������ ������� ������� Hi ������� <ENTER>')
pause
Hi = mfilt.firinterp(L)          % �������� ���������� �������� ������� ����������� ������������
y = filter(Hi,x);                % �������� ������
ni_start = ceil(length(y)/2+1);  % ������ ��������������� ������
yi = y(ni_start:end);            % �������� ������ � �������������� ������
ni = ni_start:(ni_start+length(yi)-1);  % ���������� ������������� ����� ��� ��������������� ������
disp('%')
disp('%')
disp('% ��� ������ �������� �������� � ��������� �������� ������� <ENTER>')
pause
figure('Name','Input and Output Signals in Polyphase Structure Interpolation System','NumberTitle', 'off')
subplot(3,1,1), stem(n,x), grid, xlabel('n')
title(strcat(['Input Signal x(n)      N = ',num2str(N)]))
subplot(3,1,2), stem(0:length(y)-1,y), grid
title(strcat(['L = ',num2str(L),'   Output Signal y(n)   length(y) = ',num2str(length(y))]))
subplot(3,1,3), stem(ni,yi), grid, xlabel('n')
title(strcat(['Output Signal y(n)   Starting point n = ',num2str(ni_start),'   length(y) = ',num2str(length(yi))]))
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� � ��� ���-������� ������� <ENTER>')
pause
X = fft(x);                    % ��� �������� �������
MODX = (2/N)*abs(X);           % ����������� ������ �������� �������
MODX(1) = (1/N)*abs(X(1));
Yi = fft(yi);                    % ��� ��������� �������
MODYi = (2/length(Yi))*abs(Yi);  % ����������� ������ ��������� �������
MODYi(1) = (1/length(Yi))*abs(Yi(1));
k = 0:(N-1);           % ���������� ������������� ������� �������� �������
ki = 0:(length(Yi)-1); % ���������� ������������� ������� ��������� �������
f = 0:(Fs*L)/1000:Fs*L;           % ����� ������ ��� ��� ���-�������
h = Hi.Numerator;                 % �� ���-�������
MAG = abs(freqz(h,1,f,Fs*L));     % ��� ���-�������
figure('Name','Amplitude Spectrums and Magnitude Response in Polyphase Structure Interpolation System','NumberTitle', 'off')
subplot(2,1,1), stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 L*Fs])
title(strcat(['Amplitude Spectrum x(n)   N = ',num2str(N)]))
subplot(2,1,2), stem(ki*(Fs*L/length(Yi)),MODYi,'MarkerSize',3, 'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 L*Fs])
title(strcat(['L = ',num2str(L),'   Amplitude Spectrum y(n) and FIR Magnitude Response']))
hold on, plot(f,MAG,'r','Linewidth',2)
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.8. ������������� ������� ����������� ��������� � ���������� ����������')
disp('%')
disp('%')
disp('% ������� �������� ������');
DATA=0;
while DATA==0
Ndp = input('Ndp = ');          % ������ �������� �������
Fs_dp = input('Fs_dp = ');      % ������� ������������� �������� �������
M = input('M = ');              % ����������� ���������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('% ��� ������ �������� Ndp, Fs_dp � M ������� <ENTER>')
pause
disp('%')
disp(['      	N = Ndp = ',num2str(Ndp),'      Fs = Fs_dp = ',num2str(Fs_dp)])
disp('%')
disp(['      	M = ',num2str(M)])
N = Ndp;               % ������ �������� �������
Fs = Fs_dp;            % ������� ������������� �������� �������
n = 0:(N-1);           % ���������� ������������� ����� �������� �������
x = A1*sin((2*pi*f1/Fs).*n)+A2*sin((2*pi*f2/Fs).*n);    % ������� ������
disp('%')
disp('% ��� ������ ������� ������� Hd ������� <ENTER>')
pause
Hd = mfilt.firdecim(M) % �������� ���������� �������� ������� ����������� ���������
y = filter(Hd,x);                % �������� ������
nd_start = ceil(length(y)/2+1);  % ������ ��������������� ������
yd = y(nd_start:end);            % �������� ������ � �������������� ������
nd = nd_start:(nd_start+length(yd)-1);  % ���������� ������������� ����� ��� ��������������� ������
disp('%')
disp('%')
disp('% ��� ������ �������� �������� � ��������� �������� ������� <ENTER>')
pause
figure('Name','Input and Output Signals in Polyphase Structure Decimation System','NumberTitle', 'off')
subplot(3,1,1), stem(n,x), grid, xlabel('n')
title(strcat(['Input Signal x(n)   N = ',num2str(N)]))
subplot(3,1,2), stem(0:length(y)-1,y), grid
title(strcat(['M = ',num2str(M),'  Output Signal y(n)   length(y) = ',num2str(length(y))]))
subplot(3,1,3), stem(nd,yd), grid, xlabel('n')
title(strcat(['Output Signal y(n)   Starting point n = ',num2str(nd_start),'   length(y) = ',num2str(length(yd))]))
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� � ��� ���-������� ������� <ENTER>')
pause
X = fft(x);                         % ��� �������� �������
MODX = (2/N)*abs(X);                % ����������� ������ �������� �������
MODX(1) = (1/N)*abs(X(1));
Yd = fft(yd);              % ��� ��������� ������� � �������������� ������
MODYd = (2/length(Yd))*abs(Yd);     % ����������� ������ ��������� �������
MODYd(1) = (1/length(Yd))*abs(Yd(1));
k = 0:(N-1);           % ���������� ������������� ������� �������� �������
kd = 0:(length(Yd)-1); % ���������� ������������� ������� ��������� �������
f = 0:Fs/1000:Fs;      % ����� ������ ��� ��� ��� ���-�������
hd = Hd.Numerator;     % �� ���-�������
MAG = abs(freqz(hd,1,f,Fs)); % ��� ���-�������
figure('Name','Amplitude Spectrums and Magnitude Response in Polyphase Structure Decimation System','NumberTitle', 'off')
subplot(2,1,1), stem(k*(Fs/N),MODX,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 Fs])
title(strcat('Amplitude Spectrum x(n) and FIR Magnitude Response'))
hold on, plot(f,MAG,'r','Linewidth',2)
subplot(2,1,2), stem(kd*((Fs/M)/length(Yd)),MODYd,'MarkerSize',3, 'Linewidth',2)
grid, xlabel('f (Hz)'), xlim([0 Fs])
title(strcat(['M = ',num2str(M),'   Amplitude Spectrum y(n)']))
disp('%')
disp('%')
disp('% ������ ���������')
























    


















































































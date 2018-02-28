clc
clear
disp('% �� �21. ���������� �������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
Nb = input('Nb = ');      % ����� �������
N = input('N = ');        % ����� ���-������� � ������� ��
L = input('L = ');        % ����� �������� ������� ��
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.1. ������������� ����������� ������ ����')
n = 0:(L-1);              %���������� ������������� �����
r_gauss = randn(1,L);     % ���������� ����� ���
disp('%')
disp('%')
disp('% ��������� ������ ����������� ������ ���� ����� ������������ � ���������� �������������')
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.2. ������������� ��������� �� � ���������� LMS')
x = r_gauss;                % ������� ������ ��
Px = var(x);                % ������� ������� �������� ������� ��
mu_max = 2/(N*Px);          % ������������ ��� ���������
mu = 0.5*mu_max;            % �������� ��� ���������
Hlms = adaptfilt.lms(N,mu)  % ��������� �� � ���������� LMS
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.3. ������������� ��������� �� � ���������� NLMS')
epsilon = 1e-6; % ���������, ������������ ������������ ��� ���������
Hnlms = adaptfilt.nlms(N,1,1,epsilon)    % ��������� �� � ���������� NLMS
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.4. ������������� ��������� �� � ���������� RLS')
Hrls = adaptfilt.rls(N)                 % ��������� �� � ���������� RLS
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.5. ������ ���������� �������������� ����������� ���')
disp('%')
disp('%')
disp('% 5.1. ������ ���������� �������������� ����������� ��� - ���-������� ��� (FIR)')
disp('%')
disp('%')
x = r_gauss;         % ������� ������ ����������� ���
R1 = round(N/2);     % ������� ���-������� ���
wc = 0.5;            % ������������� ������� ������� ���-������� ���
b = fir1(R1,wc);     % ������������ ���-������� ���
d = filter(b,1,x);   % �������� ������ ����������� ��� (FIR)
h = b;               % �������� ���������� �������������� ����������� ��� (FIR) ����� (R1+1)
[y_lms,e_lms] = filter(Hlms,x,d); % �������� ������ � ������ ������ �� � ���������� LMS
[y_rls,e_rls] = filter(Hrls,x,d); % �������� ������ � ������ ������ �� � ���������� RLS
h_lms = Hlms.coefficients;        % ������ ���������� �������������� ����������� ��� (FIR) - ��������� �� � ���������� LMS
h_rls = Hrls.coefficients;        % ������ ���������� �������������� ����������� ��� (FIR) - ��������� �� � ���������� RLS
disp('% ��� ������ �������� ������� ������ �� ������� <ENTER>')
pause
n = 0:length(x)-1;                % ���������� ������������� ����� ��� ������� ������ ��
figure('Name','Error signal of AF for LMS and RLS','NumberTitle', 'off')
subplot(2,1,1), plot(n,e_lms), grid, xlabel('n'), title('Error signal for LMS')
subplot(2,1,2), plot(n,e_rls), grid, xlabel('n'), title('Error signal for RLS')
n1 = 0:N-1;            % �������� ����������� �������������� ������� ��� ������ ���������� ��������������
if length(h)<N
    h = [h zeros(1,(N-length(h)))];  % �������� ���������� �������������� ����������� ��� (FIR), ����������� ������ �� ����� N
end
disp('%')
disp('%')
disp('% ��� ������ �������� �������� ���������� �������������� (FIR) � �� ������ ������� <ENTER>')
pause
figure('Name','True Impulse response FIR and its Estimates','NumberTitle', 'off')
subplot(3,1,1), stem(n1,h), grid, xlabel('n1')
title('True Impulse response FIR - h(n) with length N')
subplot(3,1,2), stem(n1,h_lms), grid, xlabel('n1')
title('LMS Impulse response FIR - h lms')
subplot(3,1,3), stem(n1,h_rls), grid, xlabel('n1')
title('RLS Impulse response FIR - h rls')
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� ����������')
disp('% �������� ���������� �������������� �� �� ������ (FIR) ������� <ENTER>')
pause
disp('%')
disp(['         norm1_lms = ',num2str((1/N)*norm(h-h_lms,1))])
disp(['         norm1_rls = ',num2str((1/N)*norm(h-h_rls,1))])
disp('%')
disp('%')
disp('% 5.2. ������ ���������� �������������� ����������� ��� - ���-������� ��� (IIR)')
disp('%')
disp('%')
R1 = round(N/2);       % ������� ���-������� ���
WDn = 0.3;             % ������������� ������� ����� ���-������� ���
[b,a] = butter(R1,WDn,'high');     % ������������ ���-������� ���
d = filter(b,a,x);     % �������� ������ ����������� ��� (IIR)
h = impz(b,a,N);       % �������� ���������� �������������� ����������� ��� (IIR) ����� N (������-�������)
[y_lms,e_lms] = filter(Hlms,x,d);  % �������� ������ � ������ ������ �� � ���������� LMS
[y_rls,e_rls] = filter(Hrls,x,d);  % �������� ������ � ������ ������ �� � ���������� RLS
h_lms = Hlms.coefficients;         % ��������� �� � ���������� LMS
h_rls = Hrls.coefficients;         % ��������� �� � ���������� RLS
disp('% ��� ������ �������� ������� ������ �� ������� <ENTER>')
pause
figure('Name','Error signal of AF for LMS and RLS','NumberTitle', 'off')
subplot(2,1,1), plot(n,e_lms), grid, xlabel('n'), title('Error signal for LMS')
subplot(2,1,2), plot(n,e_rls), grid, xlabel('n'), title('Error signal for RLS')
disp('%')
disp('%')
disp('% ��� ������ �������� �������� ���������� �������������� (IIR) � �� ������ ������� <ENTER>')
pause
figure('Name','True Impulse response IIR and its Estimates','NumberTitle', 'off')
subplot(3,1,1), stem(n1,h), grid, xlabel('n1')
title('True Impulse response IIR - h(n) with length N')
subplot(3,1,2), stem(n1,h_lms), grid, xlabel('n1')
title('LMS Impulse response IIR - h lms(n)')
subplot(3,1,3), stem(n1,h_rls), grid, xlabel('n1')
title('RLS Impulse response IIR - h rls(n)')
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� ����������')
disp('% �������� ���������� �������������� �� �� ������ (IIR) ������� <ENTER>')
disp('%')
disp(['         norm1_lms = ',num2str((1/N)*norm(h'-h_lms,1))])
disp(['         norm1_rls = ',num2str((1/N)*norm(h'-h_rls,1))])
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.6. ������� ������� �� ����')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
Fs = input('Fs = ');      % ������� ������������� (��)
A1 = input('A1 = ');      % ��������� ���������� ��������
A2 = input('A2 = ');
f1 = input('f1 = ');      % ������� (��) ���������� ��������
f2 = input('f2 = ');
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
x_noise = r_gauss;   % ������� ������ �� - ���������� ����� ���
b = fir1(R1,wc);     % ������������ ���-������� ���, ����������� ���
x_noiseNEW = filter(b,1,x_noise);   % ���������� ��� �� ������ ���-������� ���
w1 = 2*pi*f1/Fs;  w2 = 2*pi*f2/Fs;  % ������������� ������� ���������� �������� (���)
n = 0:(L-1);                        % ���������� ������������� �����
s = A1*cos(w1*n)+A2*cos(w2*n);      % �������� ������
d = s+x_noiseNEW;                   % ���������� ������ ��
[y_lms,e_lms] = filter(Hlms,x_noise,d); % �������� ������ � ������ ������ �� � ���������� LMS
[y_rls,e_rls] = filter(Hrls,x_noise,d); % �������� ������ � ������ ������ �� � ���������� RLS
disp('%')
disp('%')
disp('% ��� ������ �������� ��������� �������, ��� ���������� ����� � �����')
disp('% � ������ ��������� ������� (LMS) � (RLS) ������� <ENTER>')
pause
figure('Name','Harmonic Signal, Mixture of Signal and Noise, Estimates of Harmonic Signal (LMS and RLS)','NumberTitle', 'off')
subplot(4,1,1), plot(n,s), grid, title('Harmonic Signal - s(n)')
subplot(4,1,2), plot(n,d), grid, title('Mixture of Harmonic Signal and Noise - d(n)')
subplot(4,1,3), plot(n,e_lms), grid, title('Estimate Harmonic Signal (LMS)')
subplot(4,1,4), plot(n,e_rls), grid, xlabel('n'), title('Estimate Harmonic Signal (RLS)')
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� ��������� �������, ��� ���������� ����� � �����')
disp('% � ������ ��������� ������� (LMS) � (RLS)')
disp('% � �������������� ������ ������� <ENTER>')
pause
k = 0:(L-1);                  % ���������� ������������� �������
f = (k/L)*Fs;                 % ������� (��)
MOD_s = (2/L)*abs(fft(s));    % ����������� ������ ��������� �������
MOD_s(1) = (1/L)*abs(fft(s(1)));
MOD_d = (2/L)*abs(fft(d));    % ����������� ������ ����� ��������� ������� � �����
MOD_d(1) = (1/L)*abs(fft(d(1)));
n_start = round(0.05*L);      % ������ ��������������� ������
Ls = (L- n_start)+1;          % ����� ������ ������� � ���� � �������������� ������
e1_lms = e_lms(n_start:end);  % ������ ��������� ������� � �������������� ������ (LMS)
e1_rls = e_rls(n_start:end);  % ������ ��������� ������� � �������������� ������ (RLS)
ks = 0:(Ls-1);                % ���������� ������������� ������� ��� ��������������� ������
fs = (ks/Ls)*Fs;              % ������� (��)
MOD_lms = (2/Ls)*abs(fft(e1_lms));     % ����������� ������ ������ ��������� ������� � �������������� ������ (LMS)
MOD_lms(1) = (1/Ls)*abs(fft(e1_lms(1)));
MOD_rls = (2/Ls)*abs(fft(e1_rls));     % ����������� ������ ������ ��������� ������� � �������������� ������ (RLS)
MOD_rls(1) = (1/Ls)*abs(fft(e1_rls(1)));
figure('Name','Amplitude Spectrums of Harmonic Signal, Mixture of Signal and Noise, and Estimates of Harmonic Signal (LMS and RLS)','NumberTitle', 'off')
subplot(4,1,1), stem(f,MOD_s), grid, title('Amplitude Spectrum of Harmonic Signal')
subplot(4,1,2), stem(f,MOD_d), grid, title('Amplitude Spectrum of Harmonic Signal and Noise - d(n)')
subplot(4,1,3), stem(fs,MOD_lms), grid, title ('Amplitude Spectrum of Estimate Harmonic Signal (LMS) ')
subplot(4,1,4), stem(fs,MOD_rls), grid, xlabel('f'), title('Amplitude Spectrum of Estimate Harmonic (RLS)')
ns = 0:(Ls-1);                 % ���������� ������������� ����� ��� ��������������� ������
s1 = s(n_start:end);           % �������� ������ �� ��������� ������� ��� ��� ������
RMSE_lms = sqrt((1/Ls).*sum((s1-e1_lms).^2));     % RMSE ��� ������ ��������� ������� (LMS)
RMSE_rls = sqrt((1/Ls).*sum((s1-e1_rls).^2));     % RMSE ��� ������ ��������� ������� (RLS)
disp('%')
disp('%')
disp('% ��� ������ �������� RMSE ������� <ENTER>')
pause
disp('%')
disp(['         RMSE_lms =     ',num2str(RMSE_lms)])
disp(['         RMSE_rls =     ',num2str(RMSE_rls)])
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.7. ������������ ��������� �������������� ����������� ���')
f2 = 3*f1;                  % ���������� ������� (��) ���������
w2 = 2*pi*(3*f1)/Fs;        % ������������� ���������� ������� (���)
n = 0:(L-1);                % ���������� ������������� �����
s = A1*cos(w1*n)+A2*cos(w2*n)+3*max(A1,A2)*r_gauss; % ������� ������ ����������� ��� - ���������� ������ ��
k = 0:(L-1);                % ���������� ������������� �������
f = k*(Fs/L);               % ������� (��)
S = fft(s);                 % ��� �������� ������� ����������� ���
MODS = (2/L)*abs(S);        % ����������� ������ �������� ������� ����������� ���
MODS(1) = (1/L)*abs(S(1));
disp('%')
disp('%')
disp('% ��� ������ �������� �������� ������� ����������� ��� � ��� ������������ �������   ������� <ENTER>')
pause
figure('Name','Input Signal of Unknown LDS and its Amplitude Spectrum','NumberTitle', 'off')
subplot(2,1,1), plot(n,s), grid, xlabel('n'), title('Input Signal of Unknown LDS')
subplot(2,1,2), stem(f,MODS), grid, xlabel('f'), title('Amplitude Spectrum')
d = s;       % ���������� ������ �� - ������� ������ ����������� ���
D = floor(N/2);                % �������� �������� ��������� �������
D_zeros = zeros(1,round(N/2)); % ������������ ��������� ������� �������� ������������ ����������� �������
d_delay = [D_zeros d(1:(length(d)-length(D_zeros)))];  % ����������� ���������� ������
R2 = round(N/7);     % ������� ���-������� ���
wc = 0.5;            % ������������� ������� ������� ���-������� ���
b = fir1(R2,wc);     % ���������� �������������� ����������� ���
x = filter(b,1,d);   % �������� ������ ����������� ��� - ������� ������ ��
X = fft(x);          % ��� ��������� ������� ����������� ���
MODX = (2/L)*abs(X); % ����������� ������ ��������� ������� ����������� ���
MODX(1) = (1/L)*abs(X(1));
disp('%')
disp('%')
disp('% ��� ������ �������� ��������� ������� ����������� ��� � ��� ������������ ������� ������� <ENTER>')
pause
figure('Name','Output Signal of Unknown LDS and its Amplitude Spectrum','NumberTitle', 'off')
subplot(2,1,1), plot(n,x), grid, xlabel('n'), title('Output Signal of Unknown LDS')
subplot(2,1,2), stem(f,MODX), grid, xlabel('f'), title('Amplitude Spectrum')
Hrls = adaptfilt.rls(N);         % ��������� �� � ���������� RLS
[y_rls,e_rls] = filter(Hrls,x,d_delay);   % �������� ������ � ������ ������ �� � ���������� RLS
h_rls = Hrls.coefficients;       % ��������� �� (���������� �������������� ��� ���-�������)
h_conv = conv(h_rls,b);          % ���������� �������������� ���������� ���������� ����������� ��� � ��
n2 = 0:length(b)-1;              % ���������� ������������� ����� ��� ���������� �������������� ����������� ��� (���-������� ���)
n3 = 0:length(h_conv)-1;         % ���������� ������������� ����� ��� ������� ���������� �������������� ����������� ��� � ��
disp('%')
disp('%')
disp('% ��� ������ �������� ���������� ������������� ����������� ���, ���-������� � ������� ��')
disp('% � �� ���������� ����������  ������� <ENTER>')
pause
figure('Name','Impulse Response of AF, Unknown LDS, and Cascade Connection','NumberTitle', 'off')
subplot(3,1,1), stem(n2,b), grid, title('Impulse Response of Unknown LDS')
subplot(3,1,2), stem(n1,h_rls), grid, title('Impulse Response of AF')
subplot(3,1,3), stem(n3,h_conv), grid, xlabel('n'), title('Impulse Response of Cascade Connection')
fa = 0:Fs/500:(Fs/2);                 % ������ ������ ��� ���
MAG_US = abs(freqz(b,1,fa,Fs));       % ��� ����������� ���
MAG_AF = abs(freqz(h_rls,1,fa,Fs));   % ��� ���-������� � ������� ��
MAG = MAG_US.*MAG_AF;                 % ��� ���������� ���������� ����������� ��� � ��
disp('%')
disp('%')
disp('% ��� ������ �������� ��� ����������� ���, ���-������� � ������� ��,')
disp('% � �� ���������� ���������� ������� <ENTER>')
pause
figure('Name','Magnitude Response of Unknown LDS, AF, and Cascade Connection','NumberTitle', 'off')
subplot(3,1,1), plot(fa,MAG_US), grid, title('Magnitude Response of Unknown LDS')
subplot(3,1,2), plot(fa,MAG_AF), grid, title('Magnitude Response of AF')
subplot(3,1,3), plot(fa,MAG), grid, xlabel('f'), title('Magnitude Response of Cascade Connection')
PH_US = angle(freqz(b,1,fa,Fs));      % ��� ����������� ���
PH_AF = angle(freqz(h_rls,1,fa,Fs));  % ��� ���-������� � ������� ��
PH = PH_US+PH_AF;                     % ��� ���������� ���������� ����������� ��� � ��
disp('%')
disp('%')
disp('% ��� ������ �������� ��� ����������� ���, ���-������� � ������� ��')
disp('% � �� ���������� ���������� ������� <ENTER>')
pause
figure('Name','Phase Response of Unknown LDS, AF, and Cascade Connection','NumberTitle', 'off')
subplot(3,1,1), plot(fa,PH_US), grid, title('Phase Response of Unknown LDS')
subplot(3,1,2), plot(fa,PH_AF), grid, title('Phase Response of AF')
subplot(3,1,3), plot(fa,PH), grid, xlabel('f'), title('Phase Response of Cascade Connection')
Y = fft(y_rls);              % ��� ��������� ������� ��
MODY = (2/L)*abs(Y);         % ����������� ������ ��������� ������� ��
MODY(1) = (1/L)*abs(Y(1));
disp('%')
disp('%')
disp('% ��� ������ �������� ��������� ������� �� � ��� ������������ ������� ������� <ENTER>')
pause
figure('Name','Output Signal and Amplitude Spectrum of AF','NumberTitle', 'off')
subplot(2,1,1), plot(n,y_rls), grid, xlabel('n'), title('Output Signal of AF')
subplot(2,1,2), stem(f,MODY), grid, xlabel('f'), title('Amplitude Spectrum')
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.8. ���������� ������ ���������� ��-������ � ������ ���������� ��������� ������������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
a = input('a = ');              % ������ ���������� ��-������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
e_AR = r_gauss;                 % ������� ������ ��-������
y_AR = filter(1,a,e_AR);        % �������� ������ ��-������
x = y_AR;                       % ������������� ������ ���������� ������ ������������� �������
p = length(a)-1;                % ������� ��-������
[aYW DYW] = aryule(x,p);        % ������ ���������� ��-������ �� ������ ���-�������
d = x;                          % ���������� ������ ��
x_delay = [0 x(1:(L-1))];       % ������� ������ �� - ����������� ���������� ������
[y_rls,e_rls] = filter(Hrls,x_delay,d);  % �������� ������ � ������ ������ �� � ���������� RLS
h_rls = -Hrls.coefficients;      % ������ ������ ���������� ��������� ������������
disp('%')
disp('%')
disp('% ��� ������ �������� ������� �������� ���������� ��-������, �� ������')
disp('% � ������� ������ ���������� ��������� ������������ ������� <ENTER>')
pause
figure('Name','True AR parameters, Estimated AR parameters, and Estimated Linear Prediction parameters','NumberTitle', 'off')
YMAX = max([max(abs(a)) max(abs(aYW)) max(abs(h_rls))]); % ������������ �� ������ ������� ��������
subplot(3,1,1), stem(a(2:end)), grid, xlim([0 N-1]), ylim([-YMAX YMAX])
title('True parameters - a')
subplot(3,1,2), stem(aYW(2:end)), grid, xlim([0 N-1]), ylim([-YMAX YMAX])
title('Estimated parameters AR - aYW')
subplot(3,1,3), stem(h_rls), grid, xlim([0 N-1]), ylim([-YMAX YMAX])
title('Estimated Linear Prediction parameters - h rls')
disp('%')
disp('%')
disp('% ��� ������ �������� MAE ������� <ENTER>')
pause
a_N = [a(2:end) zeros(1,(N-length(a(2:end))))];       % ������ �������� ���������� ��-������, ����������� ������ �� ����� N
aYW_N = [aYW(2:end) zeros(1,(N-length(aYW(2:end))))]; % ������ ������ ���������� ��-������, ����������� ������ �� ����� N
MAE_AR = (1/N).*sum(abs(a_N-aYW_N));      % MAE ������ ���������� ��-������
MAE_LP = (1/N).*sum(abs(h_rls-a_N));      % MAE ������ ���������� ��������� ������������
disp('%')
disp(['         MAE_AR =     ',num2str(MAE_AR)])
disp(['         MAE_LP =     ',num2str(MAE_LP)])
disp('%')
disp('%')
disp('% ������ ���������')





























































































































script
clc
clear
disp('% �� �10. ���������� �������������� ����� (����� 2)')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
Nb = input('Nb = ');      % ����� �������
N = input('N = ');        % ����� (������) ������������������
Fs = input('Fs = ');      % ������� ������������� (��)
A1 = input('A1 = ');      % ��������� ���������� ��������
A2 = input('A2 = ');
f1 = input('f1 = ');      % ������� ���������� �������� (��)
f2 = input('f2 = ');
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
disp('% �.1. �������� ��������� ���������')
n = 0:(N-1);              % ���������� ������������� �����
k = 0:(N-1);              % ���������� ������������� �������
w1 = 2*pi*f1/Fs; w2 = 2*pi*f2/Fs;  % ������������� ������� ���������� �������� (���)
x = A1*cos(w1*n)+A2*cos(w2*n);     % ������������������(������ N)
X = fft(x);               % ��� ������������������
E1 = sum(x.^2);           % ������� ������������������, ����������� �� �� ��������
E2 = (1/N)*sum(abs(X).^2); % ������� ������������������, ����������� �� �������� ���
disp('%')
disp('%')
disp('% ��� ������ ����� (E1) � ������ (E2) ������ ��������� ��������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp(['      E1 = ',num2str(E1),'      E2 = ' num2str(E2)])
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.2. ������������ ������� ���������� ������� ��� ����� ���������� ���������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
M = input('M = ');    % ������ ������������������ M
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
n = 0:(N-1);          % ���������� ������������� ����� (������ N)
k = 0:(N-1);          % ���������� ������������� ������� (������ N)
w1 = 2*pi*f1/Fs;      % ������������� ������� (���)
x_N = A1*cos(w1*n);   % ������������������ (������ N)
X_N = fft(x_N);       % ��� ������������������ (������ N)
MOD_N = (2/N)*abs(X_N);  % ����������� ������ ������������������ (������ N)
MOD_N(1) = (1/N)*abs(X_N(1));
n1 = 0:(M-1);         % ���������� ������������� ����� (������ M)
k1 = 0:(M-1);         % ���������� ������������� ������� (������ M)
x_M = A1*cos(w1*n1);  % ������������������ (������ M)
X_M = fft(x_M);          % ��� ������������������ (������ M)
MOD_M = (2/M)*abs(X_M);  % ����������� ������ ������������������ (������ M)
MOD_M(1) = (1/M)*abs(X_M(1));
P_N = N*f1/Fs;        % ����� �������� ���������� ��������� � �������� f1 �� ������� ������������������ N
P_M = M*f1/Fs;        % ����� �������� ���������� ��������� � �������� f1 �� ������� ������������������ M
disp('%')
disp('%')
disp('% ��� ������ ����� �������� ���������� ��������� � �������� f1 ������� <ENTER>')
pause
disp('%')
disp('%')
disp(['N = ',num2str(N),'  -->  P_N = ' num2str(P_N)])
disp(['M = ',num2str(M),'  -->  P_M = ' num2str(P_M)])
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� ������� <ENTER>')
pause
figure('Name','Amplitude Spectrum','NumberTitle', 'off')
subplot(2,1,1), stem(k,MOD_N,'MarkerSize',3), grid, xlabel('k')
title(strcat(['Amplitude Spectrum of the Periodic Sequence N = ',num2str(N)]))
subplot(2,1,2), stem(k1,MOD_M,'MarkerSize',3), grid, xlabel('k')
title(strcat(['Amplitude Spectrum of the Periodic Sequence M = ',num2str(M)]))
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.3. ������������ ����������� ���������� ���������� ������� � ������� ����')
win_M  = hamming(M)';    % ���� �������� � ������-������� ����� M
xw_M = x_M.*win_M;       % ������������������, ���������� �����
XW_M = fft(xw_M);        % ��� ���������� ������������������
MODW_M =(2/M)*abs(XW_M); % ����������� ������ ���������� ������������������
MODW_M(1) =(1/M)*abs(XW_M(1));
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� �� � ����� ���������� ���� ������� <ENTER>')
pause
figure('Name','Reducing Spectrum Leakage with the help of Window Functions','NumberTitle', 'off')
subplot(2,1,1), stem(k1,MOD_M,'MarkerSize',3), grid, xlabel('k')
title(strcat(['Amplitude spectrum without windowing M = ',num2str(M)]))
subplot(2,1,2), stem(k1,MODW_M,'MarkerSize',3), grid, xlabel('k')
title(strcat(['Amplitude spectrum with Hamming Window M = ',num2str(M)]))
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.4. ������������ ������� ���������� ������� ��� ����� ���� ���������� ��������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
f1_1 = input('f1_1 = ');   % ������� ���������� �������� (��)
f2_1 = input('f2_1 = ');
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
n = 0:(N-1);               % ���������� ������������� �����
k = 0:(N-1);               % ���������� ������������� �������
w1_1 = 2*pi*f1_1/Fs; w2_1 = 2*pi*f2_1/Fs; % ������������� ������� ���������� �������� (���)
x1 = A1*cos(w1_1*n)+A2*cos(w2_1*n);  % ������������������ (������ N)
X1 = fft(x1);           % ��� ������������������ (������ N)
MOD1 = (2/N)*abs(X1);   % ����������� ������ ������������������
MOD1(1) = (1/N)*abs(X1(1));
P1_1 = N*f1_1/Fs;        % ����� �������� ���������� ��������� � �������� f1_1 �� ������� ������������������ N
P2_1 = N*f2_1/Fs;        % ����� �������� ���������� ��������� � �������� f2_1 �� ������� ������������������ N
disp('%')
disp('%')
disp('% ��� ������ ����� �������� ���������� �������� � ��������� f1_1 � f2_1 ������� <ENTER>')
pause
disp('%')
disp('%')
disp(['      f1_1 = ',num2str(f1_1),'  -->  P1_1 = ' num2str(P1_1)])
disp(['      f2_1 = ',num2str(f2_1),'  -->  P2_1 = ' num2str(P2_1)])
win_N  = hamming(N)';     % ���� �������� � ������-������� ����� N
xw1 = x1.*win_N;   % ������������������, ���������� ����� (������ N)
XW1 = fft(xw1);    % ��� ���������� ������������������ (������ N)
MODW1 =(2/N)*abs(XW1);   % ����������� ������ ������������������
MODW1(1) =(1/M)*abs(XW1(1));
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� �������� �� � ����� ���������� ���� ������� <ENTER>')
pause
figure('Name','Reducing Spectrum Leakage with the help of Window Functions','NumberTitle', 'off')
subplot(2,1,1), stem(k,MOD1,'MarkerSize',3), grid, xlabel('k')
title(strcat(['Amplitude spectrum without windowing N = ',num2str(N)]))
subplot(2,1,2), stem(k,MODW1,'MarkerSize',3), grid, xlabel('k')
title(strcat(['Amplitude spectrum with Hamming Window N = ',num2str(N)]))
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.5. ��������� ���������� ���������� �������� � ������ �������������� ���������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
f1_2 = input('f1_2 = ');        % ������� ���������� �������� (��)
f2_2 = input('f2_2 = ');
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
disp('%')
disp('%')
disp('% ��� ������ ������� ������������������ �')
disp('% ������ �������� ������� <ENTER>')
disp('%')
disp('%')
disp(['      N = ',num2str(N)])
disp(['      f1_2 = ',num2str(f1_2),'       f2_2 = ' num2str(f2_2)])
Delta_N = Fs/N;                   % ���������� �� �������
Delta_f = abs(f1_2-f2_2);         % ���������� ����� ���������
L = ceil(Fs/(Delta_f-Delta_N));   % ��������� ����� L
Delta_L = Fs/L;        % ������ ������������� �� ������� ��� ����� L
disp('%')
disp('%')
disp('% ��� ������ ���������� �� ������� Delta_N,')
disp('% ���������� ����� ��������� Delta_f,')
disp('% ����� L ������������������')
disp('% � ������� ������������� �� ������� Delta_L ������� <ENTER>')
pause
disp('%')
disp('%')
disp(['      Delta_N = ',num2str(Delta_N)])
disp(['      Delta_f = ',num2str(Delta_f)])
disp(['      L = ',num2str(L)])
disp(['      Delta_L = ',num2str(Delta_L)])
disp('%')
disp('%')
n = 0:(N-1);                              % ���������� ������������� �����
w1_2 = 2*pi*f1_2/Fs; w2_2 = 2*pi*f2_2/Fs; % ������������� �������
x2 = A1*cos(w1_2*n)+A2*cos(w2_2*n);       % �������� ������������������
X2 = fft(x2);              % ��� �������� ������������������ ����� N
MOD2 = abs(X2);            % ������ ���
X2_L = fft(x2,L);          % ��� �������� ������������������, ����������� ������ �� ����� L
MOD2_L = abs(X2_L);        % ������ ���
disp('% ��� ������ �������� N-��������� ��� � ������ ������������')
disp('% ���������, ��������������� �� L ������, ������� <ENTER>')
pause
k = 0:(N-1);          % ���������� ������������� ������� ��� ����� N
k1 = 0:(L-1);         % ���������� ������������� ������� ��� ����� L
figure('Name','Discrete Harmonic Signal with Close Frequencies','NumberTitle', 'off')
subplot(2,1,1), stem(k,MOD2), grid, xlabel('k')
title(strcat(['DFT Modulus N = ',num2str(N)]))
subplot(2,1,2), plot(k1,MOD2_L,'r','MarkerSize',3, 'Linewidth',2)
grid, hold on, stem(k1,MOD2_L,':'), xlabel('k')
title(strcat(['Spectral Density Modulus L = ',num2str(L)]))
L_2 = ceil(L/2);                     % �������� ������ ������ L/2
[MODm m]= max(MOD2_L(1:(L_2)));      % �������� MODm � ������ m ������� MOD2_L (������ ���)
k_1 = (m-1); f_1 = k_1*Delta_L;      % ���������� ������������� � ���������� (��) ������� ������� ����
K = ceil(L/N);   % ���������� �������� �� ������� ������������� Fs/N
K1 = m+K; K2 = m+2*K-1;              % ������ K1 � ������� K2 ������� ��������� ��� ������ ������� ���� ������
[MODm1 m1]= max(MOD2_L(K1:K2));      % �������� MODm1 � ������ m1 ������ ��� MOD2_L �� ��������� [K1 K2]
K3 = m-(2*K-1); K4 = m-K;            % ������ K3 � ������� K4 ������� ��������� ��� ������ ������� ���� �����
[MODm2 m2]= max(MOD2_L(K3:K4));      % �������� MODm2 � ������ m2 ������ ��� MOD2_L �� ��������� [K3 K4]
if (MODm1>MODm2)
    k_2 = (K1+m1-1)-1; f_2 = k_2*Delta_L; % ���������� ������������� � ���������� (��) ������� ������� ����, ���� �� ������ �� �������
    else
    k_2 = (K3+m2-1)-1; f_2 = k_2*Delta_L; % ���������� ������������� � ���������� (��) ������� ������� ����, ���� �� ����� �� �������
end
disp('%')
disp('%')
disp('% ��� ������ ������ �������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp(['      k_1 = ',num2str(k_1),'      f_1 = ' num2str(f_1)])
disp(['      k_2 = ',num2str(k_2),'      f_2 = ' num2str(f_2)])
disp('%')
disp('%')
disp('% ���������� ������� �������� �� �������')
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.6. ���������� �������� �������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
x3 = input('x3 = ');       % ������ ������������������
x4 = input('x4 = ');       % ������ ������������������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
y34 = ifft(fft(x3).*fft(x4));% �������� ������� �������������������
L34 = length(y34);           % ������ �������� �������
disp('%')
disp('%')
disp('% ��� ������ �������� ������������������� � �������� ������� (3 �������) ������� <ENTER>')
pause
figure('Name','Sequences x3, x4, y34','NumberTitle', 'off')
subplot(3,1,1), stem((0:3*L34-1),...
repmat(x3,1,3),'fill','Linewidth',2,'MarkerSize',3), grid
xlabel('n'), title('Periodic Sequence x3(n)')
subplot(3,1,2), stem((0:3*L34-1), repmat(x4,1,3),'fill', 'Linewidth',2,'MarkerSize',3), grid
xlabel('n'), title('Periodic Sequence x4(n)')
subplot(3,1,3), stem((0:3*L34-1), repmat(y34,1,3),'fill', 'Linewidth',2,'MarkerSize',3), grid, xlabel('n')
title('Periodic Sequence y34(n) � Convolution with FFT and IFFT')
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.7. ���������� �������� �������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
x5 = input('x5 = ');       % ������ ������������������
x6 = input('x6 = ');       % ������ ������������������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
y56_1 = conv(x5,x6);       % �������� �������,����������� � ������� ������� conv
y56_2 = fftfilt(x5,x6);    % �������� �������, ����������� � ������� ������� fftfilt
MAX = max([length(y56_1) length(y56_2)]); % ������������ ����� �������
disp('%')
disp('%')
disp('% ��� ������ �������� ������������������� � �������� ������� ������� <ENTER>')
pause
figure('Name','Sequences x5, x6, y56_1, y56_2','NumberTitle', 'off')
subplot(4,1,1)
stem((0:length(x5)-1),x5,'fill','Linewidth',2,'MarkerSize',3)
grid, xlabel('n'), title('Sequence x5(n)'), xlim([0 MAX-1])
subplot(4,1,2)
stem((0:length(x6)-1),x6,'fill','Linewidth',2,'MarkerSize',3)
grid, xlabel('n'), title('Sequence x6(n)'), xlim([0 MAX-1])
subplot(4,1,3)
stem((0:length(y56_1)-1),y56_1,'fill','Linewidth',2,'MarkerSize',3)
grid, xlabel('n'), title('Sequence y56(n) � Convolution'), xlim([0 MAX-1])
subplot(4,1,4)
stem((0:length(y56_2)-1),y56_2,'fill','Linewidth',2,'MarkerSize',3)
grid, xlabel('n'), title('Sequence y56(n) � Convolution with FFT and IFFT'), xlim([0 MAX-1])
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.8. ���������� ������� ��� �� ������� �������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
b = input('b = ');        % ������������ ��������� ������������ �������
a = input('a = ');        % ������������ ����������� ������������ �������
N1 = input('N1 = ');      % ����� ���������� ��������������
N2 = input('N2 = ');      % ����� �����������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
h = impz(b,a,N1)';       % ���������� ��������������
x7 = input_1(N2);        % �����������
y7_1 = conv(x7,h);       % �������, ����������� � ������� ������� conv
y7_2 = fftfilt(h,x7);    % �������, ����������� � ������� ������� fftfilt
L=N1+N2-1;            % ����� �������, ����������� � ������� ������� conv
disp('%')
disp('%')
disp('% ��� ������ �������� ��, ����������� � ������� ������� <ENTER>')
pause
figure('Name','Impulse Response, Input and Output Signals','NumberTitle', 'off')
subplot(4,1,1)
stem(0:length(h)-1,h,'Linewidth',2,'MarkerSize',3), grid,
xlabel('n'), title('Impulse Response  h(n)'), xlim([0 L-1])
subplot(4,1,2)
stem(0:length(x7)-1,x7,'Linewidth',2,'MarkerSize',3), grid
xlabel('n'), title('Input Signal x7(n)'), xlim([0 L-1])
subplot(4,1,3)
stem(0:length(y7_1)-1,y7_1,'Linewidth',2,'MarkerSize',3),
grid
xlabel('n'), title('Output Signal y7(n) � Convolution'), xlim([0 L-1])
subplot(4,1,4)
stem(0:length(y7_2)-1,y7_2,'Linewidth',2,'MarkerSize',3), grid
xlabel('n'), title('Output Signal y7(n) � Convolution with FFT and IFFT'), xlim([0 L-1])
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.9. ���������� ������� ��� ������� ���������� � �����������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
N3 = input('N3 = ');   % ����� �����������
disp('% ��������� ������������ ����� �������� ������')
disp('% ��� ���������� �������� ������ ������� 1')
disp('% ��� ������������ �������� ������ ������� 0 � ��������� ����')
DATA = input('--> ');
end
x8 = input_1(N3);        % �����������
y8_1 = fftfilt(h,x8);    % �������, ����������� � ������� ������� fftfilt
y8_2 = fftfilt(h,x8,N1); % �������, ����������� � ������� ������� fftfilt ������� ���������� � �����������
disp('%')
disp('%')
disp('% ��� ������ �������� ����������� � ������� ������� <ENTER>')
pause
figure('Name','Impulse Response, Input and Output Signals � Overlap-add method','NumberTitle', 'off')
subplot(4,1,1)
stem(0:length(h)-1,h,'MarkerSize',3), grid
xlabel('n'), title('Impulse Response h(n)'), xlim([0 N3-1])
subplot(4,1,2), stem(0:length(x8)-1,x8,'MarkerSize',3), grid
xlabel('n'), title('Input Signal x8(n)')
subplot(4,1,3),stem(0:length(y8_1)-1,y8_1,'MarkerSize',3), grid
xlabel('n')
title('Output Signal y8(n) � Convolution with FFT and IFFT')
subplot(4,1,4), stem(0:length(y8_2)-1,y8_2,'MarkerSize',3), grid
xlabel('n')
title('Output Signal y8(n) � Convolution with Overlap-add method')
disp('%')
disp('%')
disp('% ������ ���������')































































































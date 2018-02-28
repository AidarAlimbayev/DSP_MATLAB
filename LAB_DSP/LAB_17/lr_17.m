script
clc
clear
disp('% �� �17. ��������������� ������������ ������')
disp('%')
disp('%')
disp('% ������� �������� ������')
DATA=0;
while DATA==0
Nb = input('Nb = ');      % ����� �������
L = input('L = ');        % ����� ������������������
Fs = input('Fs = ');      % ������� ������������� (��)
a = input('a = ');        % ������ ���������� ��-������
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
disp('% �.1. ������������� ��������� ������������������ �� ������ ��-������')
n = 0:(L-1);           % ���������� ������������� �����
e = randn(1,L);        % ����������� - ���������� ����� ��� ����� L
y = filter(1,a,e);     % ������������ ��������� ������������������ ����� L
disp('%')
disp('%')
disp('% ��� ������ ������� ������������ ������������������ ������� <ENTER>')
pause
figure('Name','AR-sequence and True PSD','NumberTitle', 'off')
subplot(2,1,1), plot(n,y), grid, xlabel('n'), ylabel('y(n)')
title('AR-sequence')
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.2. ���������� �������� ��� ������������ ������������������')
disp('%')
disp('%')
disp('% ��� ������ ������� �������� ��� ������������ ������������������ ������� <ENTER>')
pause
f = 0:Fs/(L-1):Fs;          % ������ ������ (��)
H = freqz(1,a,f,Fs);        % ����������� ��������� ��������������
S = (1/Fs)*abs(H).^2;       % �������� ��� ������������ ������������������
subplot(2,1,2),plot(f,S), grid, xlabel('f (Hz)'), ylabel('S(f)')
title('True PSD')
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.3. ������ ������������ ������� ��-������ ������������� ������������������')
disp('%')
disp('%')
x = y;      % ������������� ������������������ ���������� ������ ������������
pmin = 1; pmax = 3*(length(a)-1);  % ����������� � ������������ �������� �������
p = [pmin:pmax];                   % ������ �������� ������� ��-������
for i = pmin:pmax
[aYW D] = aryule(x,p(i));          % ��������� ��-������ � ������� ������� ������ ��������� ������������
BIC(i) = L*log(D)+p(i)*log(L);     % �������� �������� ������
variance(i) = D;                   % ������� ������� ������ ��������� ������������ � ������ ��������� ����������� ������ ���� � ��-������
end
[BIC_min p_opt] = min(BIC);        % ����������� �������� �������� ������ � ����������� ������� ������
disp('% ��� ������ �������� ������������ �������� �������� ������ ��������� ������������')
disp('% � �������� �������� ������ �� ������� ������ ������� <ENTER>')
pause
figure('Name','Mean Square of the Linear Prediction Error and Bayesian Information Criterion','NumberTitle','off')
subplot(2,1,1), plot(p,variance,'Linewidth',2), grid
xlabel('p'), ylabel('D'), title('Mean Square of the Linear Prediction Error')
subplot(2,1,2), plot(p,BIC,'r','Linewidth',2), grid
xlabel('p'), ylabel('BIC')
title('Bayesian Information Criterion')
disp('%')
disp('%')
disp('% ������� �������� ������������ ������� ��-������')
DATA=0;
while DATA==0
disp('%')
p_opt = input('  p_opt = ');        % ����������� ������� ��-������
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
disp('% �.4. ���������� ������ ���������� ��-������')
disp('%')
disp('%')
[aYW DYW] = aryule(x,p_opt);     % ������ ���������� ��-������ �� ������ ���-�������
[aBURG DBURG] = arburg(x,p_opt); % ������ ���������� ��-������ �� ������ �����
[aCOV DCOV] = arcov(x,p_opt);    % ������ ���������� ��-������ �������������� �������
[aMCOV DMCOV] = armcov(x,p_opt); % ������ ���������� ��-������ ���������������� �������������� �������
D = var(e);       % ������ ��������� ����������� ������ ���� ����� L
disp('% ��� ������ �������� ���������� ��-������ � �� ������ ������� <ENTER>')
pause
disp('%')
disp(' �������� ���������');
disp(['  a =    [' num2str(a),']'])
disp('%')
disp(' ����� ���-�������');
disp('%')
disp([' aYW =   [' num2str(aYW),']']);
disp('%')
disp(' ����� �����');
disp('%')
disp([' aBURG = [' num2str(aBURG),']']);
disp('%')
disp(' �������������� �����');
disp('%')
disp([' aCOV =  [' num2str(aCOV),']']);
disp('%')
disp(' ���������������� �������������� �����');
disp('%')
disp([' aMCOV = [' num2str(aMCOV) ,']']);
disp('%')
disp('%')
disp('% ��� ������ �������� �������� ������ ��������� ������������ ������� <ENTER>')
pause
disp('%')
disp([' ����� ���-�������:                       DYW = ' num2str(DYW)]);
disp('%')
disp([' ����� �����:                             DBURG = ' num2str(DBURG)]);
disp('%')
disp([' �������������� �����:                    DCOV = ' num2str(DCOV)]);
disp('%')
disp([' ���������������� �������������� �����:   DMCOV = ' num2str(DMCOV)]);
disp('%')
disp('%')
disp('% ��� ������ ������ ��������� ����������� ������ ���� ������� <ENTER>')
pause
disp('%')
disp([' ������ ��������� ����������� ������ ����: D = ' num2str(D)]);
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.5. �������� ������������ ���-�������')
disp('%')
disp('%')
disp('% ��� ������ ���� ����� � ������� ������� <ENTER>')
pause
figure('Name','Z-plane zero-pole plots','NumberTitle','off')
subplot(2,2,1), zplane(1,aYW), title ('Yule-Walker method'), grid
xlabel('Re'), ylabel('jIm')
subplot(2,2,2), zplane(1,aBURG), title ('Burg method'), grid
xlabel('Re'), ylabel('jIm')
subplot(2,2,3), zplane(1,aCOV), title ('Covariance method'),grid
xlabel('Re'), ylabel('jIm')
subplot(2,2,4), zplane(1,aMCOV),title ('Modified Covariance method')
xlabel('Re'), ylabel('jIm'), grid
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.6. ���������� ������ ���')
disp('%')
disp('%')
disp('% ��� ������ �������� ������ ��� ������� <ENTER>')
pause
[SYW,f] = pyulear(x,p_opt,L,Fs,'twosided');  % ������ ��� �� ������ ���-�������
[SBURG,f] =  pburg(x,p_opt,L,Fs,'twosided'); % ������ ��� �� ������ �����
[SCOV,f] =  pcov(x,p_opt,L,Fs,'twosided');   % ������ ��� �������������� �������
[SMCOV,f] =  pmcov(x,p_opt,L,Fs,'twosided'); % ������ ��� ���������������� �������������� �������
figure('Name','PSD Estimates','NumberTitle', 'off')
subplot(4,1,1), plot(f,SYW,'Linewidth',2), grid
xlabel('f (Hz)'), ylabel('SYW(f)'), title(' PSD estimate using Yule-Walker method')
subplot(4,1,2), plot(f,SBURG,'Linewidth',2), grid
xlabel('f (Hz)'), ylabel('SBURG(f)'), title('PSD estimate using Burg method')
subplot(4,1,3), plot(f,SCOV,'Linewidth',2), grid
xlabel('f (Hz)'), ylabel('SCOV(f)'), title('PSD estimate using Covariance method')
subplot(4,1,4), plot(f,SMCOV,'Linewidth',2), grid
xlabel('f (Hz)'), ylabel('SMCOV(f)')
title('PSD estimate using Modified Covariance method')
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.7. ��������� ������ ��� C �������� ���')
disp('%')
disp('%')
disp('% ��� ������ �������� ������ ��� � �������� ��� ������� <ENTER>')
pause
figure('Name','True PSD and Different PSD Estimates', 'NumberTitle','off')
plot(f,S,'Linewidth',2), xlabel('f (Hz)'), ylabel('S(f)'), grid
hold on
plot(f,SYW,'m','Linewidth',2), grid
plot(f,SBURG,'r','Linewidth',2), grid
plot(f,SCOV,'k','Linewidth',2), grid
plot(f,SMCOV,'g','Linewidth',2), grid
legend('True PSD','PSD estimate Yule-Walker method', 'PSD estimate Burg method', 'PSD estimate Covariance method', 'PSD estimate Modified Covariance method', 0);
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.8. ���������� �������� RMSE')
RMSE_YW = sqrt((1/L).*sum((S'-SYW).^2));     % RMSE ��� ������ ��� �� ������ ���-�������
RMSE_BURG = sqrt((1/L).*sum((S'-SBURG).^2)); % RMSE ��� ������ ��� �� ������ �����
RMSE_COV = sqrt((1/L).*sum((S'-SCOV).^2));   % RMSE ��� ������ ��� �������������� �������
RMSE_MCOV = sqrt((1/L).*sum((S'-SMCOV).^2)); % RMSE ��� ������ ��� ���������������� �������������� �������
disp('%')
disp('%')
disp('% ��� ������ �������� RMSE ������ ��� ������� <ENTER>')
pause
disp('%')
disp([' ����� ���-�������:                     RMSE = ' num2str(RMSE_YW )]);
disp('%')
disp([' ����� �����:                           RMSE = ' num2str(RMSE_BURG )]);
disp('%')
disp([' �������������� �����:                  RMSE = ' num2str(RMSE_COV)]);
disp('%')
disp([' ���������������� �������������� �����: RMSE = ' num2str(RMSE_MCOV)]);
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.9. ������������ ������� ������� ��-������ �� ������ ���')
disp('%')
disp('%')
disp('% ��� ������ �������� �������� ��� � ������ ��� �� ������ ���-������� ������� <ENTER>')
pause
p_low = round(p_opt/2);                   % ���������� ������� ��-������
p_high = 3*p_opt;                         % ���������� ������� ��-������
[SYW_low,f] = pyulear(x,p_low,L,Fs,'twosided');   % ������ ��� �� ������ ���-������� � ���������� �������� ������
[SYW_high,f] = pyulear(x,p_high,L,Fs,'twosided'); % ������ ��� �� ������ ���-������� � ���������� �������� ������
figure('Name','Different AR Model Orders for Yule-Walker Method', 'NumberTitle','off')
plot(f,S,'Linewidth',2),  xlabel('f (Hz)'), grid, hold on
plot(f,SYW_low,'r','Linewidth',2), grid
plot(f,SYW_high,'k','Linewidth',2), grid
legend(['True PSD: p opt = ' num2str(p_opt)], ['PSD estimate Yule-Walker method: p = ' num2str(p_low)], ['PSD estimate Yule-Walker method: p = ' num2str(p_high)], 0);
title('PSD estimates using Yule-Walker method for different model orders')
disp('%')
disp('%')
disp('% �.10. ������������ ������� ����� ������������������ �� ������ ���')
disp('%')
disp('%')
disp('% ��� ������ �������� �������� ��� � ������ ��� �� ������ ���-������� ������� <ENTER>')
pause
e1 = randn(1,100*L);           % ����������� - ���������� ����� ��� ����� 100*L
y1 = filter(1,a,e1);           % ������������ ��������� ������������������ ����� 100*L
x1 = y1;                       % ������������� ������������������ ���������� ������ ������������
[SYW_1,f] = pyulear (x,p_opt,L,Fs,'twosided');   % ������ ��� �� ������ ���-������� ��� ������������������� ����� L
[SYW_2,f] = pyulear (x1,p_opt,L,Fs,'twosided');  % ������ ��� �� ������ ���-������� ��� ������������������� ����� 100*L
figure('Name','Different Sequence Lengths for Yule-Walker Method', 'NumberTitle','off')
plot(f,S,'Linewidth',2), xlabel('f (Hz)'), grid, hold on
plot(f,SYW_1,'r','Linewidth',2), grid
plot(f,SYW_2,'k','Linewidth',2), grid
legend(['True PSD: L = ' num2str(L)], [' PSD estimate Yule-Walker method: L = ' num2str(L)], [' PSD estimate Yule-Walker method: L = ' num2str(100*L)], 0);
title('PSD estimates using Yule-Walker method for different lengths')
disp('%')
disp('%')
disp('% ������ ���������')























































































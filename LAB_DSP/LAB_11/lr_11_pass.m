script
clc
clear
disp('% �� �11. ������ ���-������� �� ������� ����')
disp('%')
disp('%')
disp('% �.1. ���� ���������� � ��� ��')
disp('%')
disp('%')
disp('% ������� ����� ������� � ���������� � ���')
DATA=0;
while DATA==0;
Nb = input('Nb = ');       % ����� �������
Fs = input('Fs = ');       % ������� ������������� (��)
fk1 = input('fk1 = ');     % ��������� ������� ��1 (��)
ft1 = input('ft1 = ');     % ��������� ������� ��1 (��)
ft2 = input('ft2 = ');     % ��������� ������� ��2 (��)
fk2 = input('fk2 = ');     % ��������� ������� ��2 (��)
d21 = input('d21 = ');     % ����������� ���������� ���������� � ��1
d1 = input('d1 = ');       % ����������� ���������� ���������� � ��
d22 = input('d22 = ');     % ����������� ���������� ���������� � ��2
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
disp('% �.2. ���������� ���������� ������� kaiserord')
disp('%')
disp('%')
disp('% ��� ������ ���������� ������� kaiserord ������� <ENTER>')
pause 
m = [0 1 0];              % ������ �������� ��������� ���
f = [fk1 ft1 ft2 fk2];    % ������ ��������� ������
ripple = [d21 d1 d22];    % ������ ����������� ���������� ����������
[R,wc,beta,ftype] = kaiserord(f,m,ripple,Fs);    % ���������� ���������� ���� �������
disp(['R = ' num2str(R)])               % ������ ������� ���-�������
disp(['wc(1) = ' num2str(wc(1)) '      wc(2) = ' num2str(wc(2))]) % ������ ������������� ������ �������
disp(['beta = ' num2str(beta)])         % �������� ���� �������
disp(['ftype = ' char(ftype)])          % ��� ���-�������
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.3. ������ ���-������� ��')
ORDER = 0; % ������� ������������� ������� ���-�������: 0 � �������������; 1 - �����������
while ORDER==0;
disp('%')
disp('%')
disp('% ��� ������� ���-������� �� ������� <ENTER>')
pause
b3 = fir1(R,wc,ftype,kaiser(R+1,beta),'noscale');     % ������������ ���-������� ��
disp('%')
disp('%')
disp(['  ������������ ���-������ �� ������� R = ' num2str(R)])
disp('%')
disp('%')
disp('% ��� ������ ����������� ������������ ���������� ���')
disp('% � ��1 (ds1), �� (dp) � ��2 (ds2) � �������� ���������� d21, d1 � d22 ������� <ENTER>')
pause
[ds1,dp,ds2] = check_pass(b3,fk1,ft1,ft2,fk2,Fs); % ���������� ����������� ������������ �� ������ ���������� � ��1, �� � ��2 
disp('%')
disp(['ds1=' num2str(ds1) '      dp = ' num2str(dp) '      ds2 = ' num2str(ds2)])
disp(['d21 = ' num2str(d21) '      d1 = ' num2str(d1) '      d22 = ' num2str(d22)])
disp('%')
disp('%')
disp('% �������� ����������� ���������� � ���������')
disp('%')
disp('% ���� ������� ������������� ������������, ������� 1')
disp('% ���� �� �������������, ������� 0 � ����� ������� R')
ORDER = input('--> ');
if ORDER==0 
R = input('R = ');                            % ������� ���-������� 
end 
end
disp('%')
disp(['  ������������ �� ������������ ������� R = ' num2str(R)])
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.4. ������ ������������� ���-������� ��')
disp('%')
disp('%')
disp('% ��� ������ �������� ��, ��� � ��� ������� <ENTER>')
pause
figure('Name','Bandpass FIR Filter - Impulse Response, Magnitude, Phase','NumberTitle', 'off')
plot_fir(R,b3,Fs)              % ���������� �������� ��, ��� � ��� 
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause 
disp('%')
disp('%')
disp('% �.5. �������� ��������� ���-������� �� � ���� ������� dfilt')
disp('%')
disp('%')
disp('% ��� ������ ������� ������� dfilt ������� <ENTER>')
pause
F_bandpass = dfilt.dfsymfir(b3)     % ������ dfilt � ���-������ ��
disp('%')
disp('%')
disp('% ������ ���-������� �� ��������')


































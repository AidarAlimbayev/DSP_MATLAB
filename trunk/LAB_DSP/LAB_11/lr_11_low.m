script
clc
clear
disp('% �� �11. ������ ���-������� ��� ������� ����')
disp('%')
disp('%')
disp('% �.1. ���� ���������� � ��� ���')
disp('%')
disp('%')
disp('% ������� ����� ������� � ���������� � ���')
DATA=0;
while DATA==0;
Nb = input('Nb = ');        % ����� �������
Fs = input('Fs = ');        % ������� ������������� (��)
ft = input('ft = ');        % ��������� ������� �� (��)
fk = input('fk = ');        % ��������� ������� �� (��)
d1 = input('d1 = ');        % ����������� ���������� ���������� � ��
d2 = input('d2 = ');        % ����������� ���������� ���������� � ��
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
m = [1 0];                % ������ �������� ��������� ���
f = [ft fk];              % ������ ��������� ������
ripple = [d1 d2];         % ������ ����������� ���������� ����������
[R,wc,beta,ftype] = kaiserord(f,m,ripple,Fs);% ���������� ���������� ���� �������
disp(['R = ' num2str(R)])            % ������ ������� ���-�������
disp(['wc = ' num2str(wc)])          % ������������� ������� �������
disp(['beta = ' num2str(beta)])      % �������� ���� �������
disp(['ftype = ' char(ftype)])       % ��� ���-�������
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.3. ������ ���-������� ���')
ORDER = 0; % ������� ������������� ������� ���-�������: 0 � �������������; 1 - �����������
while ORDER==0;
disp('%')
disp('%')
disp('% ��� ������� ���-������� ��� ������� <ENTER>')
pause
b1 = fir1(R,wc,ftype,kaiser(R+1,beta),'noscale');  % ������������ ���-������� ���
disp('%')
disp('%')
disp(['  ������������ ���-������ ��� ������� R = ' num2str(R)])
disp('%')
disp('%')
disp('% ��� ������ ����������� ������������ ���������� ���')
disp('% � �� (dp) � �� (ds) � �������� ���������� d1 � d2 ������� <ENTER>')
pause
[dp,ds] = check_low(b1,ft,fk,Fs);   % ���������� ����������� ������������ �� ������ ���������� � �� � �� 
disp('%')
disp(['dp = ' num2str(dp) '           ds = ' num2str(ds)])
disp(['d1 = ' num2str(d1) '           d2 = ' num2str(d2)])
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
disp(['  ������������ ��� ������������ ������� R = ' num2str(R)])
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.4. ������ ������������� ���-������� ���')
disp('%')
disp('%')
disp('% ��� ������ �������� ��, ��� � ��� ������� <ENTER>')
pause
figure('Name','Lowpass FIR Filter - Impulse Response, Magnitude, Phase','NumberTitle', 'off')
plot_fir(R,b1,Fs)              % ���������� �������� ��, ��� � ���  
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.5. �������� ��������� ���-������� ��� � ���� ������� dfilt')
disp('%')
disp('%')
disp('% ��� ������ ������� ������� dfilt ������� <ENTER>')
pause
F_lowpass = dfilt.dfsymfir(b1)     % ������ dfilt � ���-������ ���
disp('%')
disp('%')
disp('% ������ ���-������� ��� ��������')














































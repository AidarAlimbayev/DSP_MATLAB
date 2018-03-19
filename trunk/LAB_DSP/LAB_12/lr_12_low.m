script
clc
clear
disp('% �� �12. ������ ���-������� ��� ������� ����������� �������������')
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
ft = input ('ft = ');       % ��������� ������� �� (��)
fk = input ('fk = ');       % ��������� ������� �� (��)
d1 = input('d1 = ');        % ����������� ���������� ���������� � ��
d2 = input('d2 = ');        % ����������� ���������� ���������� � ��
Ap = input('Ap = ');        % ����������� ���������� ��������� � ��
Ast = input('Ast = ');      % ���������� ���������� ��������� � ��
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
disp('% �.2. ���������� ���������� ������� firpmord')
disp('%')
disp('%')
disp('% ��� ������ ������� ���-������� (R) � �����  � �� � �� (weight) ������� <ENTER>')
pause
m = [1 0];                % ������ �������� ��������� ���
f = [ft fk];              % ������ ��������� ������
ripple = [d1 d2];         % ������ ����������� ���������� ����������
[R,f0,m0,weight] = firpmord(f,m,ripple,Fs);% ���������� ���������� ������� firpmord
disp('%')
disp(['R = ' num2str(R)])               % ������ ������� ���-�������
weight = [weight(1) weight(2)]          % ���� � �� � ��
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
[b1,error,opt] = firpm(R,f0,m0,weight);     % ������������ ���-������� ��� b1
disp('%')
disp('%')
disp(['  ������������ ���-������ ��� ������� R = ' num2str(R)])
disp('%')
disp('%')
disp('% ��� ������ ������������ ���������� ������ ������������� error')
disp('% � ����������� ����������� ���������� max{d1,d2} ������� <ENTER>')
pause
disp('%')
disp(['error = ' num2str(error)])           % ����������� ������������ ���������� ��� �� ���������
disp(['max{d1,d2} = ' num2str(max(d1,d2))]) % �������� ���������� max{d1,d2}
disp('%')
disp('%')
disp('% �������� ����������� ���������� ��� � ��������')
disp('%')
disp('% ���� ������� ������������� ������������, ������� 1')
disp('% ���� �� �������������, ������� 0 � ����� ������� R')
ORDER = input('--> ');
if ORDER==0
R = input('R = ');                           % ������� ���-�������
end
end
disp('%')
disp([' ������������ ����������� ��� ������� R = ' num2str(R)])
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
plot_fir(R,b1,Fs)                % ���������� �������� ��, ��� � ���
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.5 ����� ������� ��� ������������ ���-������� � ����������� ��������� �����������')
disp('%')
disp('%')
disp('% ��� ������ ������� ��� � ��������� ����������� ������� <ENTER>')
pause
fextr = opt.fextr;              % ������ ������������� ������ �����������
figure('Name','Lowpass Filter - Magnitude','NumberTitle', 'off')
MAG_fir(b1,opt.fextr,f0,m0,Fs)  % ������ ��� � ��������� �����������
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.6. �������� ���������� � ��� ���-������� ��� � ���� ������� fdesign')
disp('%')
disp('%')
disp('% ��� ������ ������� ������� fdesign ������� <ENTER>')
pause
MAG_lowpass = fdesign.lowpass('Fp,Fst,Ap,Ast',ft,fk,Ap,Ast,Fs) % ������ fdesign ��� ���
disp('%')
disp('%')
disp('% ��� ����������� ������� <ENTER>')
pause
disp('%')
disp('%')
disp('% �.7. ������ ���-������� � ���� ������� dfilt �� ������ ������� fdesign')
disp('%')
disp('%')
disp('% ��� ������ ������� ������� dfilt ������� <ENTER>')
pause
F_lowpass = equiripple(MAG_lowpass)    % ���  � ���� ������� dfilt
disp('%')
disp('%')
disp('% ������ ���-������� ��� ��������')



























































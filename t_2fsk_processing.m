clc;
close all;
clear all;
[y,fs]=audioread('C:\Users\HP\Desktop\PhD����\0100101101����2 - ����.wav');
figure(1);
t=1:length(y);
plot(t,y(:,1));title('��Ƶ�ź�ʱ��ͼ');xlabel('t');ylabel('����');
%��ʵϸ����0���͡�1�����Զε�Ƶ�ʾ��ǲ�ͬ��
%�����˶����Ǹ�����������һ��������������Ȳ�ͬ����ɿ���������2ASK
figure(2);
N=2^20;
n=0:N-1;
f=n*fs/N-fs/2;
Y=fftshift(fft(y(:,1),N));
plot(f,Y);title('��Ƶ�ź�Ƶ��ͼ')

figure(3);
 b1=fir1(101,[1900/24000 2010/24000]);
 y1=filter(b1,1,y(:,1));
subplot(1,2,1); plot(y1); title('����������ͨ�˲�����ֳ�����2ASK�ź�y1')

b2=fir1(101,[3900/24000 4010/24000]);
 y2=filter(b2,1,y(:,1));
subplot(1,2,2); plot(y2); title('����������ͨ�˲�����ֳ�����2ASK�ź�y2')


figure(4);
y3=y1.*y1;
y4=y2.*y2;%��ʵ���ǿ����Լ������Լ�
subplot(1,2,1); plot(y3);title('y1�������ز�ͬƵͬ�������źŵ�y3');
subplot(1,2,2); plot(y4);title('y2�������ز�ͬƵͬ�������źŵ�y4');

%ÿ����Ԫ����Ϊ48000������y3,y4ȥ����Ƶ�Ǵ�ʲôʱ��ʼ��
for i=1:length(y3)
    if y3(i)>=0.01%��Ƶ��ͼ�۲���0.01Ϊ���ޱȽϺ���
        w1=i;
        break
    end
end
for i=1:length(y4)
    if y4(i)>=0.01
        w2=i;
        break
    end
end
%ȡw1,w2�н�С��ֵ��Ϊ���start
if w1>w2
    w=w2;
else
    start=w1;
end

for i=length(y3):-1:1 %���ű���ȥ�ҽ�β
    if y3(i)>=0.01%��Ƶ��ͼ�۲���0.01Ϊ���ޱȽϺ���
        w1=i;
        break
    end
end
for i=length(y4):-1:1 %���ű���ȥ�ҽ�β
    if y4(i)>=0.01%��Ƶ��ͼ�۲���0.01Ϊ���ޱȽϺ���
        w2=i;
        break
    end
end
%ȡw1,w2�нϴ��ֵ��Ϊ���en
if w1>w2
    w=w1;
else
    en=w2;
end

%������ʶ�����Ԫ����
for i=1:100 %����������100����Ԫ
    if i*fs>=(en-start)
        num=i;
        break;
    end
end

%����ʶ�������Ԫ���������趨��ȷ��en,Ȼ����start,end��ȡy3,y4Ϊֻʣ����Ƶ�ź�
en=start+num*fs;
y3=y3(start:en);
y4=y4(start:en);
figure(5);
subplot(1,2,1); plot(y3);title('ֻʣ����Ƶ�źŵ�y3');
subplot(1,2,2); plot(y4);title('ֻʣ����Ƶ�źŵ�y4');

figure(6);
 b3=fir1(101,[200/24000 400/24000]);
 y5=filter(b3,1,y3);
subplot(1,2,1); plot(y5); title('������ͨ�˲�����ʣ��y3�İ���y5')

b4=fir1(101,[200/24000 400/24000]);
 y6=filter(b4,1,y4);
subplot(1,2,2); plot(y6); title('������ͨ�˲�����ʣ��y4�İ���y6')

%��ʼ���߱Ƚϣ����г����о��ָ�����Ԫ
code=zeros(1,num);
for i=1:fs:num*fs
    if y5(i+fs/2)>y6(i+fs/2)
        code(ceil(i/fs))=0;
    else
        code(ceil(i/fs))=1;
    end
end

fprintf("ԭʼ��������ԪΪ:\n");
disp(code);





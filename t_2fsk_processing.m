clc;
close all;
clear all;
[y,fs]=audioread('C:\Users\HP\Desktop\PhD面试\0100101101传输2 - 副本.wav');//这里换成你自己的文件路径
figure(1);
t=1:length(y);
plot(t,y(:,1));title('音频信号时域图');xlabel('t');ylabel('幅度');
%其实细看“0”和“1”各自段的频率就是不同的
%但是人耳听那个明明振幅设的一样，但是明显响度不同，造成看起来像是2ASK
figure(2);
N=2^20;
n=0:N-1;
f=n*fs/N-fs/2;
Y=fftshift(fft(y(:,1),N));
plot(f,Y);title('音频信号频域图')

figure(3);
 b1=fir1(101,[1900/24000 2010/24000]);
 y1=filter(b1,1,y(:,1));
subplot(1,2,1); plot(y1); title('经过两个带通滤波器后分成两个2ASK信号y1')

b2=fir1(101,[3900/24000 4010/24000]);
 y2=filter(b2,1,y(:,1));
subplot(1,2,2); plot(y2); title('经过两个带通滤波器后分成两个2ASK信号y2')


figure(4);
y3=y1.*y1;
y4=y2.*y2;%其实就是可以自己乘以自己
subplot(1,2,1); plot(y3);title('y1乘以与载波同频同相的相干信号得y3');
subplot(1,2,2); plot(y4);title('y2乘以与载波同频同相的相干信号得y4');

%每个码元长度为48000，处理y3,y4去找音频是从什么时候开始的
for i=1:length(y3)
    if y3(i)>=0.01%由频谱图观察以0.01为门限比较合适
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
%取w1,w2中较小的值作为起点start
if w1>w2
    w=w2;
else
    start=w1;
end

for i=length(y3):-1:1 %倒着遍历去找结尾
    if y3(i)>=0.01%由频谱图观察以0.01为门限比较合适
        w1=i;
        break
    end
end
for i=length(y4):-1:1 %倒着遍历去找结尾
    if y4(i)>=0.01%由频谱图观察以0.01为门限比较合适
        w2=i;
        break
    end
end
%取w1,w2中较大的值作为起点en
if w1>w2
    w=w1;
else
    en=w2;
end

%这里来识别出码元个数
for i=1:100 %假设最多会有100个码元
    if i*fs>=(en-start)
        num=i;
        break;
    end
end

%根据识别出的码元个数重新设定正确的en,然后用start,end截取y3,y4为只剩下音频信号
en=start+num*fs;
y3=y3(start:en);
y4=y4(start:en);
figure(5);
subplot(1,2,1); plot(y3);title('只剩下音频信号的y3');
subplot(1,2,2); plot(y4);title('只剩下音频信号的y4');

figure(6);
 b3=fir1(101,[200/24000 400/24000]);
 y5=filter(b3,1,y3);
subplot(1,2,1); plot(y5); title('经过低通滤波器后剩下y3的包络y5')

b4=fir1(101,[200/24000 400/24000]);
 y6=filter(b4,1,y4);
subplot(1,2,2); plot(y6); title('经过低通滤波器后剩下y4的包络y6')

%开始二者比较，进行抽样判决恢复出码元
code=zeros(1,num);
for i=1:fs:num*fs
    if y5(i+fs/2)>y6(i+fs/2)
        code(ceil(i/fs))=0;
    else
        code(ceil(i/fs))=1;
    end
end

fprintf("原始发出的码元为:\n");
disp(code);





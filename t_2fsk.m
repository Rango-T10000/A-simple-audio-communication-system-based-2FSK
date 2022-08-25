clc;
close all;
clear all;
fs=44100;
t=0: 1/fs: 1;
c1=sin(2*pi*2000*t);
c2=sin(2*pi*4000 *t);
code=[0,1,0,0,1,0,1,1,0,1];
n=length(code);
word=zeros(1,n*44101);
x=1;
for i=1:n
   if code(i) == 0
       word(x:x+44101-1)=c1;
   else
       word(x:x+44101-1)=c2;
   end
   x=x+44101;
end
sound(word,fs);
   
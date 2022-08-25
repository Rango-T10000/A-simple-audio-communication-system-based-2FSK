# A-simple-audio-communication-system-based-2FSK
A-simple-audio-communication-system-based-2FSK（基于2FSK的简易音频通信系统）.  The codes talk about how to submit audio signals based 2FSK and how to demodulate it after receiving. 

本项目使用matlab完成
1.文件t_2fsk.m是发射音频信号，使用matlab中的sound函数进行发声
2.用手机录音后得到0100101101传输2.m4a文件，发送到电脑端改后缀为.wav，因为要用matlab中的sudioread函数读取
3.最后就是t_2fsk_processing.m文件，这就是解调的代码
如何正确使用该代码可以看下文档2FSK音频通信系统.docx

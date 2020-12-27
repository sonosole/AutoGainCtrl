using WAV
using AGC

wav, fs = wavread("./doc/123.wav")

new = agc(wav,fs,maxvalue=0.5,minstep=-0.99); # deepcopy wav and then operate in-place
agc!(wav,fs,maxvalue=0.15,minstep=-0.5)       # in-place operation

wavwrite(wav, "./doc/agced1.wav", Fs=fs, nbits=32)
wavwrite(new, "./doc/agced2.wav", Fs=fs, nbits=32)

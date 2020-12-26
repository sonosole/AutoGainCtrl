using WAV
using AGC

wav, fs = wavread("./doc/123.wav")
agc!(wav,fs,maxvalue=0.3)
new = agc(wav,fs,maxvalue=0.3)

wavwrite(wav, "./doc/agced1.wav", Fs=fs, nbits=32)
wavwrite(new, "./doc/agced2.wav", Fs=fs, nbits=32)

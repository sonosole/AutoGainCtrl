using WAV
using AGC

wav, fs = wavread("D:/repos/agc/doc/123.wav")
agc!(wav,fs,maxvalue=0.3)
new = agc(wav,fs,maxvalue=0.3)

wavwrite(wav, "D:/repos/agc/doc/agced1.wav", Fs=fs, nbits=32)
wavwrite(new, "D:/repos/agc/doc/agced2.wav", Fs=fs, nbits=32)

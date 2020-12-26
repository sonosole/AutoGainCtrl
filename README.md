# AGC
 Automatic gain control for speech signals 语音信号的自动增益控制模块

## Installation
```julia
]add
```

## Example

```julia
using WAV
using AGC

wav, fs = wavread("D:/repos/agc/doc/123.wav")
agc!(wav,fs,maxvalue=0.3)
new = agc(wav,fs,maxvalue=0.3)

wavwrite(wav, "D:/repos/agc/doc/agced1.wav", Fs=fs, nbits=32)
wavwrite(new, "D:/repos/agc/doc/agced2.wav", Fs=fs, nbits=32)
```

After adjustment, the value larger than specified maximum value is weakened.

![agced](/doc/agced-wav.png)

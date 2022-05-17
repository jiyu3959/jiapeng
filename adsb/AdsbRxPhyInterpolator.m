function z = AdsbRxPhyInterpolator(y, adsbParam)


coder.inline('never')

persistent interpFil

if isempty(interpFil)
  interpFil = dsp.FIRInterpolator(adsbParam.InterpolationFactor, ...
    adsbParam.InterpolationFilterCoefficients);
end

if adsbParam.InterpolationFactor > 1
  % Interpolate the input signal. For example, if Y is sampled at 2.4MHz,
  % since Mode-S signals are 2 MHz pulses, we need to upsample to a multiple
  % of 2 MHz. An interpolation factor of 5 will give us 12 MHz signal, which
  % is convenient for demodulation.
  z = interpFil(y);
else
  z = y;
end


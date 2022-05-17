function [pkt,pktCnt] = AdsbRxPhy(y,radioTime,adsbParam)


persistent packetSync

if isempty(packetSync)
  packetSync = AdsbRxPhySync(adsbParam);
end

% Interpolate to get an integer number of samples per chip
z = AdsbRxPhyInterpolator(y, adsbParam);

% Convert sample values to energy values
zAbs = abs(z).^2;

% Search for a Mode-S packet and return samples for the found packet
[pktSamples, pktCnt, syncTime] = packetSync(zAbs);

% Extract Mode-S header information and raw data bits
[pkt,pktCnt] = AdsbRxPhyBitParser(pktSamples, pktCnt, syncTime, ...
  radioTime, adsbParam);

end

function pkt = AdsbPhyPacket(adsbParam)


pkt.RawBits = coder.nullcopy(zeros(112,1,'uint8'));   
%pkt.RawBits = coder.nullcopy(zeros(adsbParam.LongPacketNumBits,1,'uint8'));   
                                    % Raw message
pkt.CRCError = true;                % CRC checksum (1: error, 0: no error)
pkt.Time = 0;                       % Packet reception time
pkt.DF = uint8(0);                  % Downlink format
pkt.CA = uint8(0);                  % Capability
end

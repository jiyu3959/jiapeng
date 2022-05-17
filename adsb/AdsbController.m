classdef AdsbController < comm.internal.ExampleController

  properties (SetObservable, AbortSet)
    %LaunchMap Do you want to launch the map (Requires Mapping Toolbox)?
    LaunchMap = false
  end
  
  properties (Access=protected, Constant)
    ExampleName = 'ADSBExample'
    ModelName = 'ADSBSimulinkExample'
    CodeGenCallback = @generateCodeCallback;
    
    MinContainerWidth = 270
    MinContainerHeight = 375

    Column1Width = 100
    Column2Width = 130
  end

  properties (Access=protected)
    HTMLFilename
    RunFunction = 'runADSBReceiver'
  end
  
  methods
    function obj = AdsbController(varargin)
      obj@comm.internal.ExampleController(varargin{:});
      obj.LogFilename = 'adsb_messages.txt';
      obj.HTMLFilename = fullfile(matlabroot, ...
        'toolbox','comm','commdemos','html','ADSBExample.html');
      obj.SignalFilename = 'adsb_capture_01.bb';
      obj.ExampleTitle = 'ADS-B';
    end
    
    function set.LaunchMap(obj, aFlag)
      validateattributes(aFlag,{'logical'},...
        {'scalar'},...
        '', 'LaunchMap');
      obj.LaunchMap = aFlag;
    end
  end
  
  methods 
    function flag = isInactiveProperty(obj,prop)
       flag = isInactiveProperty@comm.internal.ExampleController(obj, prop);
    end
  end
  
  methods (Access = protected)
    function addWidgets(obj)
      obj.addRow('Duration', 'Duration', 'edit', 'numeric');
      obj.addRow('SignalSource', 'Signal source', 'popupmenu');
      obj.addRow('RadioAddress', 'Radio address', 'popupmenu');
      obj.addRow('SignalFilename', 'Signal file name', 'edit', 'text');
      obj.addRow('LaunchMap', 'Launch map', 'checkbox');
      obj.addRow('LogData', 'Log data', 'checkbox');
      obj.addRow('LogFilename', 'Log file name', 'edit', 'text');
    end
    function getUserInputImpl(obj)
       getLaunchMap(obj);
%        getLogData(obj.LogDataController)
%        getLogFilename(obj.LogDataController)
    end
    
    function getLaunchMap(obj)
          obj.LaunchMap = false;
%       launchMapAns = input(...
%         '\n> Do you want to launch the map (Requires Mapping Toolbox) [n]: ', 's');
%       if isempty(launchMapAns) 
%         obj.LaunchMap = false;
%       else
%         if strcmpi(launchMapAns, 'y')
%           obj.LaunchMap = true;
%         elseif strcmpi(launchMapAns, 'n')
%           obj.LaunchMap = false;
%         else
%           error(message('comm_demos:common:Exit'));
%         end
%       end
    end
  end
end

function generateCodeCallback(userInput)
    if isempty(which('AdsbRxPhy_mex'))
      adsbParam = AdsbConfig(userInput);
      radioTime = 0;
      fields = {'isSourceRadio', 'isSourcePlutoSDR'};
      adsbParamPhy = rmfield(adsbParam, fields);
      codegen(which('AdsbRxPhy'), '-args', {complex(single(zeros(adsbParamPhy.SamplesPerFrame, 1))), radioTime, coder.Constant(adsbParamPhy)});
    end
end

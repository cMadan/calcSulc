function varargout = cache_results(cmd, args, cachename, cachedir, VERBOSE)
% varargout = cache_results(cmd, args, cachename, cachedir, VERBOSE)
%    Return the result of eval(cmd(args{:})), and store it in a Matlab
%    file <cachename>.  If, however, cachename already results,
%    simply load that instead and returns its contents.
% 2012-03-06 Dan Ellis dpwe@ee.columbia.edu

if nargin < 3;  cachename = '';  end
if nargin < 4;  cachedir = '';   end
if nargin < 5;  VERBOSE = 0;     end

if length(cachedir) == 0
  cachedir = './cache';
end

if ~iscell(args)
  args = {args};
end
% How many outputs?
noutputs = nargout;

% Figure name to write cache to
S = whos('args');
argsize = S.bytes;
if argsize < 256 
  argscmp = args;
  if ischar(args{1})
    argname = args{1};
  else
    arghash = DataHash(args);
    argname = arghash;
  end
else
  % some other type, hash it
  arghash = DataHash(args);
  argname = arghash;
  argscmp = arghash;
end
% Make it safe to be a file name
argname = regexprep(argname, '[. \?\*]','_');
cmdname = func2str(cmd);

if length(cachename) == 0
  cachename = fullfile(cmdname,argname);
end

cachefile = fullfile(cachedir, cachename);
if strcmp(cachefile(end-4:end),'.mat') == 0
  cachefile = [cachefile,'.mat'];
end

% Check modification date of cmd?
dirinfo = dir(which(cmdname));
cmdmodtime = dirinfo.datenum;

got = 0;

D.results = [];

if exist(cachefile, 'file')
  dirinfo = dir(cachefile);
  cachemodtime = dirinfo.datenum;
  
  if cmdmodtime > cachemodtime
    ddisp(['cache_results: warn: mod time of ',cmdname,'=', ...
          datestr(cmdmodtime), ' after mod time of ', cachefile, ...
          '=' datestr(cachemodtime)], VERBOSE);
    % .. but read it anyway
  end  
  ddisp(['loading from ',cachefile], VERBOSE);
  D = load(cachefile);
  nresults = length(D.results);
  % Check all available results to find one whose args are the same
  for i = 1:nresults
    if isequal(argscmp, D.results(i).args)
      % Arguments match!
      % Assign results to outputs
      for j = 1:noutputs
        varargout(j) = D.results(i).result(j);
      end
      got = 1;
    end
  end
  if got == 0
    ddisp(['*** No argument match in ',cachefile], VERBOSE);
    % and leave got == 0
  end
end

if got == 0
  % need to actually calculate it
  assert(isa(cmd,'function_handle'));
  %Y = cmd(arg);
  switch noutputs
   case 1
    result{1} = cmd(args{:});
   case 2
    [result{1},result{2}] = cmd(args{:});
   case 3
    [result{1},result{2},result{3}] = cmd(args{:});
   case 4
    [result{1},result{2},result{3},result{4}] = cmd(args{:});
   otherwise
    error(['Need to update cache_results for ',num2str(noutputs),' outputs']);
  end
  varargout = result;
  % Add this result to any existing ones before saving out
  nresults = length(D.results);
  D.results(nresults+1).cmd = cmd;
  D.results(nresults+1).args = argscmp;
  D.results(nresults+1).result = result;
  mymkdir(fileparts(cachefile));
  save(cachefile,'-struct','D','results');
  ddisp(['saved to ',cachefile], VERBOSE);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ddisp(str, verb)
if verb > 0
  disp(str);
end
% verb also carries file descriptor of log file
if verb ~= 0
  if verb ~= 1 && verb ~= 2
    fprintf(abs(verb), '%s\n', msg);
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r = mymkdir(dir)
% r = mymkdir(dir)
%   Ensure that dir exists by creating all its parents as needed.
% 2006-08-06 dpwe@ee.columbia.edu

r = 0;

if length(dir) == 0
  return;
end

[x,m,i] = fileattrib(dir);
if x == 0
  [pdir,nn] = fileparts(dir);
  disp(['creating ',dir,' ... ']);
  r = mymkdir(pdir);
  % trailing slash results in empty nn
  if length(nn) > 0
    if length(pdir) == 0
      pdir = pwd;
    end
    mkdir(pdir, nn);
    r = 1;
  end
end

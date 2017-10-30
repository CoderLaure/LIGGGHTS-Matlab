% CODE by Laure Lemrich, Nov 2017 at ETH Zurich
% 
% Read a packing
function dat = load_packing(file)

dat = struct;

fid = fopen(file);
fgetl(fid);
dat.timestep = str2double(fgetl(fid));
fgetl(fid);
dat.Natoms = str2double(fgetl(fid));
fgetl(fid);
t1 = str2double(strsplit(fgetl(fid)));
t2 = str2double(strsplit(fgetl(fid)));
t3 = str2double(strsplit(fgetl(fid)));
dat.boundingbox = [t1;t2;t3];
varnames = strsplit(fgetl(fid));
varnames = varnames(3:end-1);
dat.varnames = varnames;
dat.filename = file;

lines = textscan(fid,'%s','delimiter','\n'); 
lines = lines{1};
lines = cellfun(@(x) strsplit(x),lines,'UniformOutput',0);

%%
dat.vals = zeros(length(lines),length(varnames));
for loopl = 1:length(lines)
	C = lines{loopl}(1:end-1);
	C = sprintf('%s*', C{:});
	dat.vals(loopl,:) = sscanf(C, '%f*')';
end 

end

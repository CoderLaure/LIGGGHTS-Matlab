% CODE by Laure Lemrich, Nov 2017 at ETH Zurich
%
% This code lets you load a packing from LIGGGHTS dump command directly
% into matlab. Works also in loops (but beware file sizes).
% 
% 
% Load a packing ----------------------------------------------------------

file = 'dump.1191000.packing';
mydata = load_packing(file);

% mydata is a struct holding information from the packing.
% Available variables are stored in mydata.varnames
% Particles values are stored in an array in mydata.vals

%% (Fac.) Remove certain values -------------------------------------------

varnames = mydata.varnames;
vals = logical(zeros(length(varnames),1)+1);
for loopj = 1:length(varnames)
   if strcmp(varnames{loopj},'type') || strcmp(varnames{loopj},'ix') || ...
          strcmp(varnames{loopj},'iy') || strcmp(varnames{loopj},'iz')
       vals(loopj) = false;
   end
end

mydata.vals = mydata.vals(:,vals);
mydata.varnames = mydata.varnames(vals);

% Robust way of finding variables -----------------------------------------

i_x = find(strcmp(mydata.varnames,'x')>0);
i_y = find(strcmp(mydata.varnames,'y')>0);
i_Zc = find(strcmp(mydata.varnames,'c_contactatom')>0);

% Example plot ------------------------------------------------------------
plot3(mydata.vals(:,i_x),mydata.vals(:,i_y),mydata.vals(:,i_Zc),'o','LineWidth',2)
xlim([0 1])
ylim([0 1.2])
zlim([0 10])
grid on
xlabel('x (cm)')
ylabel('y (cm)')
zlabel('Coordination Number')



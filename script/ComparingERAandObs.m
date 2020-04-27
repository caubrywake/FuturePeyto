%% Observation for Peyto 2000-2015
% Manually load the different files
%% testing if i Make change in the text editor
load('ObsFiles.mat')
% Changin obs time to datetime
% some more change
fn = ERAIt;
ERAIt = datetime([fn zeros(length(fn),1)]);
fn = MNHt_20002018;
MNHt_20002018 = datetime([fn zeros(length(fn),1)]);
fn = MNH_MOHt_2010_2018;
MNH_MOHt_2010_2018 = datetime([fn zeros(length(fn),1)]);
fn = MOHt_20102016;
MOHt_20102016 = datetime([fn zeros(length(fn),1)]);
fn = OBSt_1991_2018;
OBSt_1991_2018 = datetime([fn zeros(length(fn),1)]);
ERAIs = ERAI(:, [1, 6,7,8,15]);

fn =MNHWiskiCleanwithEa;
MNHcleant = datetime([fn zeros(length(fn),1)]);
MNHclean = MNHWiskiCleanwithEa(:, [1,2,5, 3,4]);


%% All in the same order: T, RH/ea/ U, SWin, LWin
MNH_20002018 = MNH_20002018(:, [1,2,5, 3, 4, 6]);


% Plot all the temperatures
for i =1:5
figure
plot (ERAIt, ERAIs(:, i));
 hold on
 plot(MNHt_20002018, MNH_20002018(:, i))
 plot(MNH_MOHt_2010_2018, MNH_MOH_2010_2018(:, i))
 plot (MOHt_20102016, MOH_20102016(:, i)) % same as MNH_MOH
 legend ('ERA' ,'MNH', 'MNH_MOH', 'MOH')
end 

%% The 
for i =1:5
figure
plot (MNHcleant, MNHclean(:, i)); hold on
 plot(MNH_MOHt_2010_2018, MNH_MOH_2010_2018(:, i))
 hold on
 plot (MOHt_20102016, MOH_20102016(:, i)) % same as MNH_MOH
 legend ('MNH raw','MNH_MOH', 'MOH')
end 
 %Scatter plot
 % I trust the MNH_MOH - let us that to do the WRF comparison....
 
 %%%
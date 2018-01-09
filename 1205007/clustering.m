% Author:  <ashik@KAI10>
% Created: 2017-05-28

clear
clc

load('data.txt');
[dbscanClusterOutput, numberOfClusters, numberOfOutliers] = DBSCAN(data);

disp('numberOfOutliers: ');
disp(numberOfOutliers);

disp('numberOfClusters: ');
disp(numberOfClusters);

figure('Name','DBSCAN Output','NumberTitle','off');
gscatter(data(:, 1), data(:, 2), dbscanClusterOutput);

% ############ K means Algorithm ################# %

kMeansClusterOutput = KMeansAlgorithm(data, numberOfClusters);

Count = zeros(numberOfClusters, 1);
[row, col] = size(data);
for i=1:row
    Count(kMeansClusterOutput(i)) = Count(kMeansClusterOutput(i)) + 1;
end

disp('Number of points in clusters:');
disp(Count);

figure('Name','K Means Output','NumberTitle','off');
gscatter(data(:,1), data(:,2), kMeansClusterOutput);



function [ belongsToCluster, numberOfClusters, numberOfOutliers ] = DBSCAN( data )

    [row, col] = size(data);
    
    forPlot = zeros(row, 2);

    for i=1:row
       [~, d] = knnsearch(data, data(i,:), 'k', 5);
       forPlot(i,:) = [i, d(5)];
    end

    forPlot = sort(forPlot, 'ascend');
    %figure('Name','4NN Distane vs Data Point Index','NumberTitle','off');
    figure;
    plot(forPlot(:,1), forPlot(:,2));
    xlabel('Data Point Index');
    ylabel('4th Nearest Neighbour Distance');

    EPS = 0.08;
    MINPTS = 4;

    numberOfOutliers = 0;
    numberOfClusters = 0;
    belongsToCluster = zeros(row, 1);

    visited = false(row,1);
    outlier = false(row,1);

    for i=1:row
        disp('i = ')
        disp(i)

        if visited(i)
            continue;
        end

        visited(i) = true;
        neighbours = rangesearch(data, data(i,:), EPS);
        [~, numberOfNeighbours] = size(neighbours{1});

        if numberOfNeighbours < MINPTS
            numberOfOutliers = numberOfOutliers + 1;
            outlier(i) = true;
        else
            numberOfClusters = numberOfClusters + 1;
            [visited, belongsToCluster] = expandCluster(data, i, neighbours{1}', numberOfClusters, EPS, MINPTS, visited, belongsToCluster);
        end
    end

end


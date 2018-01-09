function [visited, belongsToCluster] = expandCluster(data, index, neighbours, clusterNumber, EPS, MINPTS, visited, belongsToCluster)
    belongsToCluster(index) = clusterNumber;
    [numberOfNeighbours, ~] = size(neighbours);
    
    i=1;
    while i<= numberOfNeighbours
        p = neighbours(i);
        if ~visited(p)
            visited(p) = true;
            
            newNeighbours = rangesearch(data, data(p, :), EPS);
            [~, newNeighbourSize] = size(newNeighbours{1});
            
            if newNeighbourSize >= MINPTS
                neighbours = [neighbours; newNeighbours{1}'];
                numberOfNeighbours = numberOfNeighbours + newNeighbourSize;
            end
            
            if belongsToCluster(p) == 0
                belongsToCluster(p) = clusterNumber;
            end
        end
        
        i=i+1;
    end
    
end

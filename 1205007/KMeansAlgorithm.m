function [ kMeansClusterOutput ] = KMeansAlgorithm( data, numberOfClusters )

    [row, col] = size(data);
    Means = zeros(numberOfClusters, col);
    for i=1: numberOfClusters
        index = randi(row);
        Means(i,:) = data(index,:);
    end

    first = true;
    prevMeans = zeros(numberOfClusters, col);

    saveR = zeros(row, numberOfClusters);
    iterations = 0;

    while true
        % Assignment step
        r = zeros(row, numberOfClusters);

        for n=1:row
            Cluster = 1;
            minDist = norm(data(n,:) - Means(1,:));
            for k=2:numberOfClusters
                cand = norm(data(n,:) - Means(k,:));
                if cand < minDist
                    minDist = cand;
                    Cluster = k;
                end
            end

            r(n, Cluster) = 1;
        end

        % Optimizing Mean
        for k=1:numberOfClusters
            Sum = zeros(1, col);
            denSum = 0;
            for n=1:row
                Sum = Sum + data(n,:) * r(n,k);
                denSum = denSum + r(n,k);
            end
            Means(k,:) = Sum / denSum;
        end

        if first
            first = false;
        elseif Means == prevMeans
            saveR = r;
            break;
        end

        prevMeans = Means;
        iterations = iterations + 1

    end

    kMeansClusterOutput = zeros(row, 1);
    for n=1:row
        for k=1:numberOfClusters
            if saveR(n,k) == 1
                kMeansClusterOutput(n) = k;
                break;
            end
        end
    end
end


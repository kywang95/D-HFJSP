function [nodes, links] = Graph3D(cost, solution)
% the amount of the iteration times
N = length(cost);
n = 1;
id = [];
from = [];
to = [];
fitness = [];
points = [];
group = [];
group_id =[];
radius = [];
for iteration = 1:N
    % the fitness and the solution of the local optima in each iteration
    solution_pick = solution{iteration};
    cost_pick = cost{iteration};
    radius_pick = ones(size(cost_pick));
    for i = 1:length(cost_pick) 
        radius_pick(i) = sum(cost_pick == cost_pick(i));
        cost_quant = cost_pick(i);
        cost_pick(cost_pick == cost_pick(i)) = 0;
        cost_pick(i) = cost_quant;
    end
    solution_pick(cost_pick == 0, :) = [];
    radius_pick(cost_pick == 0) = [];
    cost_pick(cost_pick == 0) = [];
    fitness = [fitness; cost_pick];
    points = [points; solution_pick];
    radius = [radius; radius_pick];
    len_ite = length(cost_pick);
    id = [id; (n:(n+len_ite-1))'];
    group = [group; ones(len_ite, 1) * iteration];
    group_id = [group_id; (1:len_ite)'];
    for round = n : (n + len_ite - 2)
        from = [ from; id(round) ];
        to = [ to; id(round+1) ];
    end
    n = n + len_ite;
end

node_amount = id(end);
for i = 1:node_amount
    for j = (i + 1) : node_amount
        if points(j,:) == points(i,:)
            from(from == id(j)) = id(i);
            to(to == id(j)) = id(i);
            id(j) = 0;
            if j<node_amount
                if group(j+1) == group(j)
                    group_id(i) = 0;
                    group(i) = 0;
                else
                    group(group == group(j)) = group(i);
            end
            end
            radius(i) = radius(i) + 1;
        end
    end
end
group(id == 0) = [];
group_id(id == 0) = [];
fitness(id == 0) = [];
radius(id == 0) = [];
id(id == 0) = [];

width = ones(size(from));
edge_amount = length(from);
for i = 1:edge_amount
    for j = (i+1) : edge_amount
        if from(j) == from(i) && to(j) == to(i)
            width(i) = width(i) + 1;
            from(j) = 0;
        end
        if from(i) == to(i)
            from(i) = 0;
        end
    end
end
to(from == 0) = [];
width(from == 0) = [];
from(from == 0) = [];

radius = mapminmax(radius, 1, 20);    
% links = table(from, to, weight);
% nodes = table(id, fitness, color, TENURE);

nodes = table(id, fitness, group, group_id, radius);
links = table(from, to, width);

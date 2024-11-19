class_name AStar
extends Object
## Implementation of the classic A* search algorithm for path-finding.

## Performs a heuristic search for the shortest path between the given start
## and goal locations.
static func search(graph, start, goal):
	var cost_so_far:Dictionary = {}
	var came_from:Dictionary = {}
	var frontier:PriorityQueue = PriorityQueue.new()
	frontier.insert(start, 0)
	cost_so_far[start] = 0
	came_from[start] = null

	while not frontier.is_empty():
		var current = frontier.extract()
		if current == goal:
			break
		for next in graph.neighbors(current):
			var new_cost = cost_so_far[current] + graph.cost(current, next)
			if is_inf(new_cost):
				continue
			if next not in cost_so_far or new_cost < cost_so_far[next]:
				came_from[next] = current
				cost_so_far[next] = new_cost
				var priority = new_cost + heuristic(next, goal)
				frontier.insert(next, priority)
	
	var path = []
	var p = goal
	while p != start:
		path.append(p)
		p = came_from[p]
	return path

## Manhattan distance on a square grid
static func heuristic(a, b):
	return abs(a.x - b.x) + abs(a.y - b.y)

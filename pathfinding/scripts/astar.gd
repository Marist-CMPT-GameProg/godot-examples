class_name AStar
extends Object
## Implementation of the classic A* search algorithm for path-finding.

## Performs a heuristic search for the shortest path between the given start
## and goal locations.
static func search(graph, start, goal):
	# TODO Implement A* search as described in the RdBlobGames tutorial
	pass
	# TODO Then use the came_from dictionary to build a list containing the
	# sequence of locations from start to goal that represent the shortest path.
	var path = []
	return path

## Manhattan distance on a square grid
static func heuristic(a, b):
	return abs(a.x - b.x) + abs(a.y - b.y)

class_name Planner
extends Resource

# Distance between two states
static func distance(src:WorldState, dst:WorldState):
	var d:float = 0
	for key in dst.properties:
		if not src.has(key):
			d += 1 # one property needs to be added
		elif src.get_property(key).value != dst.get_property(key).value:
			d += 1 # one property needs to be changed
	return d

## If the goal state is a possible result of applying the action,
## then we return a minimal substate of all states in which this
## action could have been applied to yield the goal state.
static func unify(action:Action, goal:WorldState):
	var unsatisfied = WorldState.reduce_by(goal, action.effects)
	if unsatisfied == null or unsatisfied == goal: return null
	var new_goal = WorldState.expand_by(unsatisfied, action.preconditions)
	return new_goal

static func devise_plan(current_state:WorldState, goal:WorldState, actions:Array[Action]):
	var plan:Array[Action] = []
	var came_from:Dictionary = {}
	var cost_so_far:Dictionary = {}

	goal = WorldState.reduce_by(goal, current_state, false)
	goal.properties.sort()
	came_from[goal] = null # start from the goal, so there is no predecessor
	cost_so_far[goal] = 0 # no cost to reach goal if we're already there
	
	var frontier:PriorityQueue = PriorityQueue.new()
	frontier.insert(goal, cost_so_far[goal])

	var start:WorldState = null
	while not frontier.is_empty():
		var current_goal:WorldState = frontier.extract()
		
		# TODO break out of the loop if we're done
		#if current_state.satisfies(current_goal):
		if current_goal.size() == 0:
			start = current_goal
			break

		#print(current_goal.properties.values())
		for action in actions:
			var next:WorldState = unify(action, current_goal)
			if next == null: continue
			#print("    ", next.properties.values())

			next = WorldState.reduce_by(next, current_state, false) # TODO double-check this
			if next.equals(current_goal): continue

			var g_cost = cost_so_far[current_goal] + action.cost
			for s in came_from.keys():
				if next.equals(s) and action == came_from[s].action:
					push_error("CYCLE!!!")
					push_error("    ", current_goal.properties.values())
					push_error("    ", came_from[s].state.properties.values())
					push_error("    ", came_from[s].action.name)
					push_error("    ", s.properties.values())

			next.properties.sort()
			if next not in cost_so_far or g_cost < cost_so_far[next]:
				#if next not in cost_so_far:
					#print("        for ", action.name, " insert ", hash(next))
				#else:
					#print("        for ", action.name, " update ", hash(next))
				cost_so_far[next] = g_cost
				var h_cost = distance(next, current_state)
				var priority = g_cost + h_cost
				frontier.insert(next, priority)
				came_from[next] = { "state": current_goal, "action": action }
	# Construct a plan from the start state to the goal state, if possible
	var n:WorldState = start
	while n != goal:
		if n not in came_from: break
		plan.append(came_from[n].action)
		n = came_from[n].state
	return plan

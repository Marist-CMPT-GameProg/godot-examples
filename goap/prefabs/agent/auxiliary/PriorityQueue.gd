class_name PriorityQueue
extends RefCounted
##

##
class Element extends RefCounted:
	var key
	var value
	func _init(k, v):
		key = k
		value = v

# Fields
#var precedes:Callable
var heap:Array

# Constructors
func _init():
#func _init(f:Callable):
	#precedes = f
	heap = []

# Observers

func is_empty() -> bool:
	return heap.is_empty()

func front() -> Variant:
	return heap[0]

# Auxiliary observers

func left(i:int) -> int:
	return 2 * i + 1

func parent(i:int) -> int:
	return (i - 1) / 2

func right(i:int) -> int:
	return 2 * i + 2

# Mutators

## Inserts an new element into the queue while preserving the heap property
func insert(x:Variant, priority:int):
	#heap.push_back(null)
	heap.push_back(-INF)
	update_key(heap.size() - 1, Element.new(priority, x))

## Removes and returns the element of the queue with the highest priority
func extract() -> Variant:
	if heap.size() < 1:
		return null # error “heap underflow”
	var extremum = heap[0].value
	heap[0] = heap.back()
	heap.pop_back()
	heapify(0)
	return extremum

# Auxiliary mutators

## Maintains the heap property by floating the root down to its proper position
func heapify(i:int):
	var l = left(i)
	var r = right(i)
	var extremum:int
	if l < heap.size() and heap[l].key < heap[i].key:
		extremum = l
	else:
		extremum = i
	if r < heap.size() and heap[r].key < heap[extremum].key:
		extremum = r
	if extremum != i:
		var tmp = heap[i]
		heap[i] = heap[extremum]
		heap[extremum] = tmp
		heapify(extremum)

## Updates the value of an element's key without violating the heap property
func update_key(i:int, elem:Element):
	#var prev_key = heap[i].key if i < heap.size() else INF
	if elem.key > heap[i].key:
		push_error("New key is larger than current key!")
	heap[i] = elem
	#if prev_key < elem.key:
		#heapify(i)
		#return
	var j = parent(i)
	while i > 0 and heap[i].key < heap[j].key:
		var tmp = heap[i]
		heap[i] = heap[j]
		heap[j] = tmp
		i = j
		j = parent(i)

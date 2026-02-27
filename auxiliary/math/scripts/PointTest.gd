class_name PointTest
## Various tests for 2D and 3D points.
##
## Due to floating-point imprecision, we cannot get exact solutions in most
## situations when a point lies "on" a line, plane, or surface. To account for
## this, we can use GDScript's is_zero_approx() global function, or we could
## modify our functions to incorporate some small tolerance, or *epsilon*.

## Test where a point is in relation to a line.
##
## Returns an integer indicating whether a given point is on the line (zero)
## "below" the line (negative), or "above" the line (positive), relative to
## the direction of the normal vector.
static func on_line(p:Vector2, e:Vector2, n:Vector2) -> int:
	var d:float = n.dot(p - e)
	return sign_approx(d)


## Test where a point is in relation to a line, with some user-defined error tolerance.
##
## Returns an integer indicating whether a given point is on the line (zero)
## "below" the line (negative), or "above" the line (positive), relative to
## the direction of the normal vector.
static func on_line_fuzzy(p:Vector2, e:Vector2, n:Vector2, epsilon:float = 1) -> int:
	epsilon = epsilon if epsilon >= 0 else -epsilon # ensure positive epsilon
	var d:float = n.dot(p - e)
	if d > epsilon:
		return 1
	if d < epsilon:
		return -1
	return 0


## Test where a point is in relation to a plane.
##
## Returns an integer indicating whether a given point is on the plane (zero),
## "below" the plane (negative), or "above" the plane (positive), relative to
## the direction of the normal vector.
static func on_plane(p:Vector3, e:Vector3, n:Vector3) -> int:
	var d:float = n.dot(p - e)
	return sign_approx(d)


## Test where a point is in relation to a plane, with some small error tolerance.
##
## Returns an integer indicating whether a given point is on the line (zero)
## "below" the line (negative), or "above" the line (positive), relative to
## the direction of the normal vector.
static func on_plane_fuzzy(p:Vector3, e:Vector3, n:Vector3, epsilon:float = 1) -> int:
	epsilon = epsilon if epsilon >= 0 else -epsilon # ensure positive epsilon
	var d:float = n.dot(p - e)
	if d > epsilon:
		return 1
	if d < epsilon:
		return -1
	return 0


## Test where a point is in relation to a circle.
##
## Returns an integer indicating whether a given point is on the circle (zero),
## inside the circle (negative), or "outside" the circle (positive).
static func on_circle(p:Vector2, c:Vector2, r:float) -> int:
	var n:Vector2 = p - c
	var d:float = n.dot(n) - (r * r)
	return sign_approx(d)


## Test where a point is in relation to a sphere.
##
## Returns an integer indicating whether a given point is on the sphere (zero),
## inside the sphere (negative), or "outside" the sphere (positive).
static func on_sphere(p:Vector3, c:Vector3, r:float) -> int:
	var n:Vector3 = p - c
	var d:float = n.dot(n) - (r * r)
	return sign_approx(d)


## Determines whether a number is positive, negative, or approximately zero.
static func sign_approx(a:float) -> int:
	if is_zero_approx(a):
		return 0
	elif a > 0:
		return 1
	else:
		return -1

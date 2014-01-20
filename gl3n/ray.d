module gl3n.ray;

private {
    import gl3n.linalg : Vector, dot, vec3;
    import gl3n.math : almost_equal;

    import std.traits : isFloatingPoint;
}


/// Base template for all plane-types.
/// Params:
/// type = all values get stored as this type (must be floating point)
struct RayT(type = float) if(isFloatingPoint!type) {
    alias type rt; /// Holds the internal type of the plane.
    alias Vector!(rt, 3) vec3; /// Convenience alias to the corresponding vector type.

    vec3 point = vec3(0.0f, 0.0f, 0.0f); /// The minimum of the AABB (e.g. vec3(0, 0, 0)).
    vec3 direction = vec3(0.0f, 0.0f, 0.0f); /// The maximum of the AABB (e.g. vec3(1, 1, 1)).

    @safe pure nothrow:

    /// Constructs the ray, from two 3-dimenational vectors
    /// Params:
    /// (=point) and (=direction)
    this(vec3 point, vec3 direction) {
        this.point = point;
        this.direction = this.direction;
    }

    unittest {
        Ray r = new Ray(vec3(0.0f, 0.0f, 0.0f), vec3(0.0f, 1.0f, 0.0f));
        assert(r.point == vec3(0.0f, 0.0f, 0.0f));
        assert(r.direction == vec3(0.0f, 1.0f, 0.0f));
        
    }

    bool opEquals(RayT other) const {
        return other.point == point && other.direction == direction;
    }

}

alias RayT!(float) Ray;
Ddoc

$(LINK2 https://bitbucket.org/dav1d/gl3n/overview, gl3n) provides all the math you need to work with OpenGL, DirectX.
Currently gl3n supports:
$(UL
  $(LI linear algebra)
  $(UL
    $(LI vectors)
    $(LI matrices)
    $(LI quaternions)
  )
  $(LI interpolation)
  $(UL
    $(LI linear interpolation (lerp))
    $(LI spherical linear interpolation (slerp))
    $(LI hermite interpolation)
    $(LI catmull rom interpolation)
  )
  $(LI nearly all GLSL defined functions (according to spec 4.1))
  $(LI the power of D, e.g. dynamic swizzling, templated types (vectors, matrices, quaternions), impressive constructors and more!)
)
$(BR)
Furthermore $(LINK2 https://bitbucket.org/dav1d/gl3n/overview, gl3n) is MIT licensed,
which allows you to use it everywhere you want it.
$(BR)$(BR)
A little example of gl3n's power:
---
vec4 v4 = vec4(1.0f, vec3(2.0f, 3.0f, 4.0f)); 
vec4 v4_2 = vec4(1.0f, vec4(1.0f, 2.0f, 3.0f, 4.0f).xyz); // "dynamic" swizzling with opDispatch

vec3 v3 = my_3dvec.rgb; 
float[] foo = v4.xyzzzwzyyxw // not useful but possible!

mat4 m4fv = mat4.translation(-0.5f, -0.54f, 0.42f).rotatex(PI).rotatez(PI/2);
glUniformMatrix4fv(location, 1, GL_TRUE, m4fv.value_ptr); // yes they are row major! 

mat3 inv_view = view.rotation; 
mat3 inv_view = mat3(view); 

mat4 m4 = mat4(vec4(1.0f, 2.0f, 3.0f, 4.0f), 5.0f, 6.0f, 7.0f, 8.0f, vec4(…) …); 
---

---
struct Camera { 
    vec3 position = vec3(0.0f, 0.0f, 0.0f); 
    quat orientation = quat.identity; 
    
    Camera rotatex(real alpha) { orientation.rotatex(alpha); return this; } 
    Camera rotatey(real alpha) { orientation.rotatey(alpha); return this; } 
    Camera rotatez(real alpha) { orientation.rotatez(alpha); return this; } 
    
    Camera move(float x, float y, float z) { 
        position += vec3(x, y, z); 
        return this; 
    } 
    Camera move(vec3 s) { 
        position += s; 
        return this; 
    } 
    
    @property camera() { 
        //writefln("yaw: %s, pitch: %s, roll: %s", degrees(orientation.yaw), degrees(orientation.pitch), degrees(orientation.roll)); 
        return mat4.translation(position.x, position.y, position.z) * orientation.to_matrix!(4,4); 
    } 
} 

        glUniformMatrix4fv(programs.main.view, 1, GL_TRUE, cam.camera.value_ptr); 
        glUniformMatrix3fv(programs.main.inv_rot, 1, GL_TRUE, cam.orientation.to_matrix!(3,3).inverse.value_ptr);
---
#include <metal_stdlib>
using namespace metal;

struct Ray {
    float3 origin;
    float3 direction;
    Ray(float3 o, float3 d) {
        origin = o;
        direction = d;
    }
};

struct Sphere {
    float3 center;
    float radius;
    Sphere(float3 c, float r) {
        center = c;
        radius = r;
    }
};

struct Plane {
    float yCoord;
    Plane(float y) {
        yCoord = y;
    }
};

struct Light {
    float3 position;
    Light(float3 pos) {
        position = pos;
    }
};

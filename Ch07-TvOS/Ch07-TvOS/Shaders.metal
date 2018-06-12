//
//  Shaders.metal
//  Ch07-OSX
//
//  Created by frank.Zhang on 12/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float4 position [[position]];
    float4 color;
};

struct Uniforms{
    float4x4 modelMatrix;
};

vertex Vertex vertex_func(constant Vertex *vertices [[buffer(0)]],constant Uniforms &uniforms [[buffer(1)]],uint vid [[vertex_id]]){
    float4x4 matrix = uniforms.modelMatrix;
    Vertex in = vertices[vid];
    Vertex out;
    out.position = matrix * float4(in.position);
    out.color = in.color;
    return out;
}

fragment float4 fragment_func(Vertex vert [[stage_in]]){
    return vert.color;
}


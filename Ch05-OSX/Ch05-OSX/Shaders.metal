//
//  Shaders.metal
//  Ch05-OSX
//
//  Created by frank.Zhang on 11/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float4 position [[position]];
    float4 color;
};

struct Uniforms {
    float4x4 modelMertrix;
};

vertex Vertex vertex_func(constant Vertex *vertices [[buffer(0)]],constant Uniforms &uniforms [[buffer(1)]],uint vid [[vertex_id]]){
    float4x4 martix = uniforms.modelMertrix;
    Vertex in = vertices[vid];
    Vertex out;
    out.position = martix * float4(in.position);
    out.color = in.color;
    return out;
}

fragment float4 fragment_func(Vertex vert [[stage_in]]){
    return vert.color;
}


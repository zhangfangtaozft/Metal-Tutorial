//
//  MetalView.swift
//  Ch03-iOS
//
//  Created by frank.Zhang on 07/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import MetalKit

class MetalView: MTKView {
    var commandQueue: MTLCommandQueue?
    var rps: MTLRenderPipelineState?
    var vertexData: [Float]?
    var vertexBuffer: MTLBuffer?
    required init(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }
    
    func render(){
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device?.makeCommandQueue()
        vertexData = [-1.0,-1.0,0.0,1.0,
                      1.0,-1.0,0.0,1.0,
                      0.0,1.0,0.0,1.0]
        let dataSize = vertexData!.count * MemoryLayout<Float>.size
        vertexBuffer = device?.makeBuffer(bytes: vertexData!, length: dataSize, options: [])
        let library = device?.makeDefaultLibrary()!
        let vertex_func = library?.makeFunction(name: "vertex_func")
        let frag_func = library?.makeFunction(name: "fragment_func")
        let rpld = MTLRenderPipelineDescriptor()
        rpld.vertexFunction = vertex_func
        rpld.fragmentFunction = frag_func
        rpld.colorAttachments[0].pixelFormat = .bgra8Unorm
        do{
            try rps = device?.makeRenderPipelineState(descriptor: rpld)
        }catch let error{
           fatalError("\(error)")
        }
    }
    
    override func draw(_ rect: CGRect) {
        if let drawable = currentDrawable, let rpd = currentRenderPassDescriptor {
            rpd.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.5, 0.5, 1.0)
            let commandBuffer = commandQueue!.makeCommandBuffer()
            let commandEncode = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd)
            commandEncode?.setRenderPipelineState(rps!)
            commandEncode?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            commandEncode?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
            commandEncode?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }
}

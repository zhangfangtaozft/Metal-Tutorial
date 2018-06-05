//
//  Renderer.swift
//  ch01_OSX
//
//  Created by frank.Zhang on 05/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import MetalKit
class Renderer: NSObject {
    let device: MTLDevice
    let commandQueue: MTLCommandQueue
    init(device: MTLDevice) {
        self.device = device
        commandQueue = device.makeCommandQueue()!
        super.init()
    }
}

extension Renderer: MTKViewDelegate{
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
            let descriptor = view.currentRenderPassDescriptor else {
                return
        }
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor:descriptor)
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}

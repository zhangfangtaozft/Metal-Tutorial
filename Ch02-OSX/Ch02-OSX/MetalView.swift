//
//  MetalView.swift
//  Ch02-OSX
//
//  Created by frank.Zhang on 06/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import MetalKit

class MetalView: MTKView {
    
    required init(coder:NSCoder){
        super.init(coder:coder)
        device = MTLCreateSystemDefaultDevice()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        if let drawable = currentDrawable,let rpd = currentRenderPassDescriptor{
            rpd.colorAttachments[0].texture = currentDrawable!.texture
            rpd.colorAttachments[0].clearColor = MTLClearColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
            rpd.colorAttachments[0].loadAction = .clear
            let commandBuffer = device?.makeCommandQueue()?.makeCommandBuffer()
            let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd);
            commandEncoder?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }
}

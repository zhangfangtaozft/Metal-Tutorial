//
//  MetalView.swift
//  Ch06-TvOS
//
//  Created by frank.Zhang on 12/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class MetalView: UIView {
    
    var commandQueue: MTLCommandQueue!
    var metalLayer: CAMetalLayer!
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        metalLayer = CAMetalLayer()
        metalLayer.device = MTLCreateSystemDefaultDevice()!
        metalLayer.frame = layer.frame
        layer.addSublayer(metalLayer)
        commandQueue = metalLayer.device?.makeCommandQueue()
        redraw()
    }
    
    private func redraw() {
        let drawable = metalLayer.nextDrawable()!
        let descriptor = MTLRenderPassDescriptor()
        descriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.5, 0.5, 1)
        descriptor.colorAttachments[0].texture = drawable.texture
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}

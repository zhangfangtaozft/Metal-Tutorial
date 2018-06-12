//
//  MetalView.swift
//  Ch06-OSX
//
//  Created by frank.Zhang on 12/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import Cocoa

class MetalView: NSView {

    var commandQueue: MTLCommandQueue!
    var metalLayer:CAMetalLayer!
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        metalLayer = CAMetalLayer()
        metalLayer.device =  MTLCreateSystemDefaultDevice()!
        metalLayer.frame = layer!.frame
        metalLayer.pixelFormat = .bgra8Unorm
        layer?.addSublayer(metalLayer)
        commandQueue = metalLayer.device?.makeCommandQueue()
        redraw()
    }
    
    private func redraw(){
        let drawable = metalLayer.nextDrawable()!
        let descriptor = MTLRenderPassDescriptor()
        descriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.5, 0.5, 1)
        descriptor.colorAttachments[0].texture = drawable.texture
        descriptor.colorAttachments[0].loadAction = .clear
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    override func draw(_ dirtyRect: NSRect) {
     metalLayer.frame = self.bounds
    }
}

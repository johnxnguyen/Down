//
//  AsyncImageLoad.swift
//  Down
//
//  Created by Mikhail Ivanov on 03.06.2021.
//  Copyright © 2021 Down. All rights reserved.
//

#if canImport(UIKit)

import UIKit

#elseif canImport(AppKit)

import AppKit

#endif

final public class AsyncImageLoad: NSTextAttachment
{
    public var imageURL: URL?

    public var displaySize: CGSize?
    
    public var maximumDisplayWidth: CGFloat?

    private var originalImageSize: CGSize?
    
    public init(imageURL: URL? = nil)
    {
        self.imageURL = imageURL
        
        super.init(data: nil, ofType: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if os(macOS)
    override public var image: NSImage? {
        didSet {
            originalImageSize = image?.size
        }
    }
    #else
    override public var image: UIImage? {
        didSet {
            originalImageSize = image?.size
        }
    }
    #endif
    
    // MARK: - Function
    
    private func startAsyncImageDownload()
    {
        guard let imageURL = imageURL,
              contents == nil
        else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            guard let data = data,
                  error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            var displaySizeChanged = false
            
            self.contents = data
            
            #if os(macOS)
            if let image = NSImage(data: data)
            {
                let imageSize = image.size
                
                if self.displaySize == nil
                {
                    displaySizeChanged = true
                }
                
                self.originalImageSize = imageSize
            }
            #else
            if let image = UIImage(data: data)
            {
                let imageSize = image.size
                
                if self.displaySize == nil
                {
                    displaySizeChanged = true
                }
                
                self.originalImageSize = imageSize
            }
            #endif
        }.resume()
    }

    #if os(macOS)
    public override func image(forBounds imageBounds: CGRect, textContainer: NSTextContainer?, characterIndex charIndex: Int) -> NSImage?
    {
        if let image = image { return image }
        
        guard let contents = contents, let image = NSImage(data: contents) else
        {
            startAsyncImageDownload()
            
            return nil
        }
        
        return image
    }
    #else
    public override func image(forBounds imageBounds: CGRect, textContainer: NSTextContainer?, characterIndex charIndex: Int) -> UIImage?
    {
        if let image = image { return image }
        
        guard let contents = contents, let image = UIImage(data: contents) else
        {
            startAsyncImageDownload()
            
            return nil
        }
        
        return image
    }
    #endif
    
    public override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect
    {
        if let displaySize = displaySize
        {
            return CGRect(origin: CGPoint.zero, size: displaySize)
        }
        
        if let imageSize = originalImageSize
        {
            let maxWidth = maximumDisplayWidth ?? lineFrag.size.width
            let factor = maxWidth / imageSize.width
            
            return CGRect(origin: CGPoint.zero, size:CGSize(width: Int(imageSize.width * factor), height: Int(imageSize.height * factor)))
        }
        
        return CGRect.zero
    }
}

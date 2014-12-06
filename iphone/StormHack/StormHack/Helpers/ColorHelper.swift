//
//  ColorHelper.swift
//  StartupLogoQuiz
//
//  Created by Selene Pinillos Franco on 01/08/2014.
//  Copyright (c) 2014 Mothhunters. All rights reserved.
//

import UIKit
import QuartzCore

class ColorHelper: NSObject {
    class func colorWithHex(hex: Int) -> UIColor{
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
    
    class func imageFromColor(color:UIColor) -> UIImage{
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    class func imageFromHex(hex: Int) -> UIImage {
        return self.imageFromColor(self.colorWithHex(hex))
    }
    
    class func blackAndWhite(image: UIImage) -> UIImage {
        var imageRect:CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
        
        // Grayscale color space
        var colorSpace = CGColorSpaceCreateDeviceGray();
        
        // Create bitmap content with current image size and grayscale colorspace
        var context = CGBitmapContextCreate(nil, UInt(image.size.width), UInt(image.size.height), 8, 0, colorSpace, nil);
        
        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        CGContextDrawImage(context, imageRect, image.CGImage);
        
        // Create bitmap image info from pixel data in current context
        var imageRef = CGBitmapContextCreateImage(context);
        
        // Create a new UIImage object
        var newImage = UIImage(CGImage:imageRef);

        
        // Return the new grayscale image
        return newImage
    }
    
    class func randomColor() -> UIColor {
        
        var redLevel:Float = Float(rand() / RAND_MAX)
        var greenLevel:Float = Float(rand() / RAND_MAX)
        var blueLevel:Float = Float(rand() / RAND_MAX)
        
        return UIColor(red: CGFloat(redLevel), green: CGFloat(greenLevel), blue: CGFloat(blueLevel), alpha: 1.0)

    }
}

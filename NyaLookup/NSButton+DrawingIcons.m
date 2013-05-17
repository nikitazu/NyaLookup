//
//  NSButton+DrawingIcons.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 17.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "NSButton+DrawingIcons.h"

@implementation NSButton (DrawingIcons)

- (void) drawCircleWithColor: (NSColor*) color {
    CGFloat height = self.frame.size.height * 0.7;
    
    NSSize size = NSMakeSize(height, height);
    NSImage* img = [[NSImage alloc] initWithSize:size];
    [img lockFocus];
    
    NSRect rect = NSMakeRect(0, 0, size.width, size.height);
    NSBezierPath* circle = [NSBezierPath bezierPath];
    
    [circle appendBezierPathWithOvalInRect:rect];
    [color setFill];
    [circle fill];
    
    [img unlockFocus];
    
    [img drawAtPoint:NSMakePoint(0, 0)
            fromRect:rect
           operation:NSCompositeSourceOver
            fraction:1.0];
    
    [self setImage:img];
}

@end

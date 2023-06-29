/*
 *  main.m: main function of Fractal.app
 *
 *  Copyright (c) 2002 Free Software Foundation, Inc.
 *  
 *  Author: Marko Riedel
 *  Date: May 2002
 *
 *  With code fragments from MemoryPanel, ImageViewer, Finger, GDraw
 *  and GShisen, as well as some fractal defintions from FractInt.
 *
 *  This sample program is part of GNUstep.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <GNUstepGUI/GSHbox.h>
#import <GNUstepGUI/GSVbox.h>

#import "GnuController.h"

int
main (void)
{
  NSAutoreleasePool *pool;
  NSApplication *app;
  GnuController *controller;
  FTYPE ft;
  CSCHEME cs;
  
  pool = [NSAutoreleasePool new];
  app = [NSApplication sharedApplication];
 
  controller = [GnuController new];
  [app setDelegate: controller];
  [app run];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
  RELEASE (controller);
  RELEASE (pool);
  return 0;
}



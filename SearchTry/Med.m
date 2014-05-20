//
//  Med.m
//  SearchTry
//
//  Created by SMART MEDIA on 7/04/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//  Coded by Felipe Quirós
//
#import "Med.h"

@interface Med ()

@end

@implementation Med

-(void) addSearchTag:(NSString *) nStr{
    
    if(!self.tags){//si no está inicializado
        //inicializo
        self.tags = [NSMutableString stringWithString:@""];
    }
    //concateno
    [self.tags appendString:nStr];
    //muestro en consola
    //NSLog(@"----------------------------------los tags %@",self.tags);
}

-(id) copyWithZone: (NSZone *) zone
{
    Med *MedCopy = [[Med allocWithZone: zone] init];
    
    [MedCopy setNombre: self.nombre];
    [MedCopy setLinea: self.linea];
    [MedCopy setTags:self.tags];
    [MedCopy setHtmlSource: self.htmlSource];
    
    return MedCopy;
}


@end
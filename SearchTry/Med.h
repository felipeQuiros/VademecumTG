//
//  Med.h
//  SearchTry
//
//  Created by SMART MEDIA on 7/04/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//  Coded by Felipe Quirós
//
//  Este objeto existe con el objetivo de almacenar temporalmente toda la información de un medicamento para una línea específica
//  No es usado para mostrar información, únicamente para entregar la información al detailViewController
//  Este último está diseñado para sacar y usar toda la información.

#import <Foundation/Foundation.h>

@interface Med : NSObject <NSCopying>

@property (strong, nonatomic) NSString *nombre;//nombre del medicamento
@property (strong, nonatomic) NSString *linea;//linea a la que pertenece
@property (strong, nonatomic) NSMutableString *tags;//palabras por las que se puede encontrar en el buscador
@property (strong, nonatomic) NSString *htmlSource;//código html para mostrar su contenido
@property (strong, nonatomic) NSMutableString *obj;

-(void) addSearchTag:(NSString *) nStr;
-(id) copyWithZone: (NSZone *) zone;

@end



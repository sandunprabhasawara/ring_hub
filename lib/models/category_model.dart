import 'package:flutter/material.dart';
import 'package:musicapp/models/utils.dart';

class Category {
  Category({
    required this.id,
    required this.categoryId,
    required this.discription,
    this.isFavourite = false,
    required this.imagePath,
    required this.colours,
  });
  final String id;

  final String discription;
  final bool isFavourite;
  final String categoryId;

  final String imagePath;
  final List<Color> colours;
}

final availableCategories = [
  Category(
      id: 'c01',
      categoryId: 'alternative',
      discription: 'some discription',
      imagePath: alternativeImage,
      colours: alternative),
  Category(
      id: 'c02',
      categoryId: 'animal',
      discription: 'some discription',
      imagePath: animalImage,
      colours: animal),
  Category(
      id: 'c03',
      categoryId: 'blue',
      discription: 'some discription',
      imagePath: blueImage,
      colours: blue),
  Category(
      id: 'c04',
      categoryId: 'bollywood',
      discription: 'some discription',
      imagePath: bollywoodImage,
      colours: bollywood),
  Category(
      id: 'c05',
      categoryId: 'caller',
      discription: 'some discription',
      imagePath: callerImage,
      colours: caller),
  Category(
      id: 'c06',
      categoryId: 'children',
      discription: 'some discription',
      imagePath: childrenImage,
      colours: children),
  Category(
      id: 'c07',
      categoryId: 'classical',
      discription: 'some discription',
      imagePath: classicalImage,
      colours: classical),
  Category(
      id: 'c08',
      categoryId: 'comedy',
      discription: 'some discription',
      imagePath: comedyImage,
      colours: comedy),
  Category(
      id: 'c09',
      categoryId: 'cool',
      discription: 'some discription',
      imagePath: coolImage,
      colours: cool),
  Category(
      id: 'c10',
      categoryId: 'country',
      discription: 'some discription',      
      imagePath: countryImage,
      colours: country),
  Category(
      id: 'c11',
      categoryId: 'creative',
      discription: 'some discription',
      imagePath: creativeImage,
      colours: creative),
  Category(
      id: 'c12',
      categoryId: 'dance',
      discription: 'some discription',
      imagePath: danceImage,
      colours: dance),
  Category(
      id: 'c13',
      categoryId: 'electronica',
      discription: 'some discription',
      imagePath: electronicaImage,
      colours: electronica),
  Category(
      id: 'c14',
      categoryId: 'hiphop',
      discription: 'some discription',
      imagePath: hiphopImage,
      colours: hiphop),
  Category(
      id: 'c15',
      categoryId: 'holidays',
      discription: 'some discription',
      imagePath: holidaysImage,
      colours: holidays),
  Category(
      id: 'c16',
      categoryId: 'humen',
      discription: 'some discription',
      imagePath: humenImage,
      colours: humen),
  Category(
      id: 'c17',
      categoryId: 'juzz',
      discription: 'some discription',
      imagePath: juzzImage,
      colours: juzz),
  Category(
      id: 'c18',
      categoryId: 'latin',
      discription: 'some discription',
      imagePath: latinImage,
      colours: latin),
  Category(
      id: 'c19',
      categoryId: 'message',
      discription: 'some discription',
      imagePath: messageImage,
      colours: message),
  Category(
      id: 'c20',                              
      categoryId: 'other',
      discription: 'some discription',
      imagePath: otherImage,
      colours: other),
  Category(
      id: 'c21',
      categoryId: 'pattern',
      discription: 'some discription',
      imagePath: patternImage,
      colours: pattern),
  Category(
      id: 'c22',
      categoryId: 'pop',
      discription: 'some discription',
      imagePath: popImage,
      colours: pop),
  Category(
      id: 'c23',
      categoryId: 'promotion',
      discription: 'some discription',
      imagePath: promotionImage,
      colours: promotion),
  Category(
      id: 'c24',
      categoryId: 'reggae',
      discription: 'some discription',
      imagePath: reggaeImage,
      colours: reggae),
  Category(
      id: 'c25',
      categoryId: 'religious',
      discription: 'some discription',
      imagePath: religiousImage,
      colours: religious),
  Category(
      id: 'c26',
      categoryId: 'rock',
      discription: 'some discription',
      imagePath: rockImage,
      colours: rock),
  Category(
      id: 'c27',
      categoryId: 'sayings',             
      discription: 'some discription',
      imagePath: sayingsImage,
      colours: sayings),
  Category(
      id: 'c28',
      categoryId: 'sound effects',
      discription: 'some discription',
      imagePath: soundeffectsImage,
      colours: soundeffects),
  Category(
      id: 'c29',
      categoryId: 'update',
      discription: 'some discription',
      imagePath: updateImage,
      colours: update),
  Category(
      id: 'c30',
      categoryId: 'wintage',
      discription: 'some discription',
      imagePath: wintageImage,
      colours: wintage),
];

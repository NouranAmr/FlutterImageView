import 'package:flutter/cupertino.dart';
import 'package:mytestingflutter/response/ResponseImage.dart';

import 'CarMakeImage360.dart';
import 'ExtraImages.dart';
import 'LocalizedDescription.dart';
import 'LocalizedNames.dart';

class CarSalesBrandModel {
  String id;
  String name;
  List<LocalizedNames> localizedNames;
  List<LocalizedDescription> localizedDescription;
  String description;
  int categoryTemplateId;
  List<CarMakeImage360> carMakeImage360;
  List<ExtraImages> extraImages;
  String email;
  bool testDrive;
  String callUs;
  String brochure;
  int makeyear;
  Null metaTitle;
  int parentCategoryId;
  String brandName;
  double minPrice;
  double maxPrice;
  int minCC;
  int maxCC;
  Null hasDiscountsApplied;
  bool published;
  bool deleted;
  int displayOrder;
  String createdOnUtc;
  String updatedOnUtc;
  String emailForTestDrive;
  List<int> storeIds;
  ResponseImage image;
  String seName;

  CarSalesBrandModel(
      {this.id,
      this.name,
      this.localizedNames,
      this.localizedDescription,
      this.description,
      this.categoryTemplateId,
      this.carMakeImage360,
      this.extraImages,
      this.email,
      this.testDrive,
      this.callUs,
      this.brochure,
      this.makeyear,
      this.metaTitle,
      this.parentCategoryId,
      this.brandName,
      this.minPrice,
      this.maxPrice,
      this.minCC,
      this.maxCC,
      this.hasDiscountsApplied,
      this.published,
      this.deleted,
      this.displayOrder,
      this.createdOnUtc,
      this.updatedOnUtc,
      this.emailForTestDrive,
      this.storeIds,
      this.image,
      this.seName});

  CarSalesBrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['localized_names'] != null) {
      localizedNames = new List<LocalizedNames>();
      json['localized_names'].forEach((v) {
        localizedNames.add(new LocalizedNames.fromJson(v));
      });
    }
    if (json['localized_description'] != null) {
      localizedDescription = new List<LocalizedDescription>();
      json['localized_description'].forEach((v) {
        localizedDescription.add(new LocalizedDescription.fromJson(v));
      });
    }
    description = json['description'];
    categoryTemplateId = json['category_template_id'];
    if (json['CarMakeImage360'] != null) {
      carMakeImage360 = new List<CarMakeImage360>();
      json['CarMakeImage360'].forEach((v) {
        carMakeImage360.add(new CarMakeImage360.fromJson(v));
      });
    }
    if (json['ExtraImages'] != null) {
      extraImages = new List<ExtraImages>();
      json['ExtraImages'].forEach((v) {
        extraImages.add(new ExtraImages.fromJson(v));
      });
    }
    email = json['email'];
    testDrive = json['test_drive'];
    callUs = json['call_us'];
    brochure = json['brochure'];
    makeyear = json['makeyear'];
    metaTitle = json['meta_title'];
    parentCategoryId = json['parent_category_id'];
    brandName = json['brand_name'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    minCC = json['minCC'];
    maxCC = json['maxCC'];
    hasDiscountsApplied = json['has_discounts_applied'];
    published = json['published'];
    deleted = json['deleted'];
    displayOrder = json['display_order'];
    createdOnUtc = json['created_on_utc'];
    updatedOnUtc = json['updated_on_utc'];
    emailForTestDrive = json['email_for_test_drive'];
    storeIds = json['store_ids'].cast<int>();
    image = json['image'] != null
        ? new ResponseImage.fromJson(json['image'])
        : null;
    seName = json['se_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.localizedNames != null) {
      data['localized_names'] =
          this.localizedNames.map((v) => v.toJson()).toList();
    }
    if (this.localizedDescription != null) {
      data['localized_description'] =
          this.localizedDescription.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['category_template_id'] = this.categoryTemplateId;
    if (this.carMakeImage360 != null) {
      data['CarMakeImage360'] =
          this.carMakeImage360.map((v) => v.toJson()).toList();
    }
    if (this.extraImages != null) {
      data['ExtraImages'] = this.extraImages.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['test_drive'] = this.testDrive;
    data['call_us'] = this.callUs;
    data['brochure'] = this.brochure;
    data['makeyear'] = this.makeyear;
    data['meta_title'] = this.metaTitle;
    data['parent_category_id'] = this.parentCategoryId;
    data['brand_name'] = this.brandName;
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['minCC'] = this.minCC;
    data['maxCC'] = this.maxCC;
    data['has_discounts_applied'] = this.hasDiscountsApplied;
    data['published'] = this.published;
    data['deleted'] = this.deleted;
    data['display_order'] = this.displayOrder;
    data['created_on_utc'] = this.createdOnUtc;
    data['updated_on_utc'] = this.updatedOnUtc;
    data['email_for_test_drive'] = this.emailForTestDrive;
    data['store_ids'] = this.storeIds;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['se_name'] = this.seName;
    return data;
  }
}

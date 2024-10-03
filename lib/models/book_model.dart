class BookModel {
  String? kind;
  int? totalItems;
  List<Items>? items;

  BookModel({this.kind, this.totalItems, this.items});

  BookModel.fromJson(Map<String, dynamic> json) {
    kind = json["kind"];
    totalItems = json["totalItems"];
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["kind"] = kind;
    data["totalItems"] = totalItems;
    if (items != null) {
      data["items"] = items?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;
  AccessInfo? accessInfo;
  SearchInfo? searchInfo;

  Items({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  });

  Items.fromJson(Map<String, dynamic> json) {
    kind = json["kind"];
    id = json["id"];
    etag = json["etag"];
    selfLink = json["selfLink"];
    volumeInfo = json["volumeInfo"] == null
        ? null
        : VolumeInfo.fromJson(json["volumeInfo"]);
    saleInfo =
        json["saleInfo"] == null ? null : SaleInfo.fromJson(json["saleInfo"]);
    accessInfo = json["accessInfo"] == null
        ? null
        : AccessInfo.fromJson(json["accessInfo"]);
    searchInfo = json["searchInfo"] == null
        ? null
        : SearchInfo.fromJson(json["searchInfo"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["kind"] = kind;
    data["id"] = id;
    data["etag"] = etag;
    data["selfLink"] = selfLink;
    if (volumeInfo != null) {
      data["volumeInfo"] = volumeInfo?.toJson();
    }
    if (saleInfo != null) {
      data["saleInfo"] = saleInfo?.toJson();
    }
    if (accessInfo != null) {
      data["accessInfo"] = accessInfo?.toJson();
    }
    if (searchInfo != null) {
      data["searchInfo"] = searchInfo?.toJson();
    }
    return data;
  }
}

class SearchInfo {
  String? textSnippet;

  SearchInfo({this.textSnippet});

  SearchInfo.fromJson(Map<String, dynamic> json) {
    textSnippet = json["textSnippet"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["textSnippet"] = textSnippet;
    return data;
  }
}

class AccessInfo {
  String? country;
  String? viewability;
  bool? embeddable;
  bool? publicDomain;
  String? textToSpeechPermission;
  Epub? epub;
  Pdf? pdf;
  String? webReaderLink;
  String? accessViewStatus;
  bool? quoteSharingAllowed;

  AccessInfo(
      {this.country,
      this.viewability,
      this.embeddable,
      this.publicDomain,
      this.textToSpeechPermission,
      this.epub,
      this.pdf,
      this.webReaderLink,
      this.accessViewStatus,
      this.quoteSharingAllowed});

  AccessInfo.fromJson(Map<String, dynamic> json) {
    country = json["country"];
    viewability = json["viewability"];
    embeddable = json["embeddable"];
    publicDomain = json["publicDomain"];
    textToSpeechPermission = json["textToSpeechPermission"];
    epub = json["epub"] == null ? null : Epub.fromJson(json["epub"]);
    pdf = json["pdf"] == null ? null : Pdf.fromJson(json["pdf"]);
    webReaderLink = json["webReaderLink"];
    accessViewStatus = json["accessViewStatus"];
    quoteSharingAllowed = json["quoteSharingAllowed"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["country"] = country;
    data["viewability"] = viewability;
    data["embeddable"] = embeddable;
    data["publicDomain"] = publicDomain;
    data["textToSpeechPermission"] = textToSpeechPermission;
    if (epub != null) {
      data["epub"] = epub?.toJson();
    }
    if (pdf != null) {
      data["pdf"] = pdf?.toJson();
    }
    data["webReaderLink"] = webReaderLink;
    data["accessViewStatus"] = accessViewStatus;
    data["quoteSharingAllowed"] = quoteSharingAllowed;
    return data;
  }
}

class Pdf {
  bool? isAvailable;
  String? acsTokenLink;

  Pdf({this.isAvailable, this.acsTokenLink});

  Pdf.fromJson(Map<String, dynamic> json) {
    isAvailable = json["isAvailable"];
    acsTokenLink = json["acsTokenLink"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isAvailable"] = isAvailable;
    data["acsTokenLink"] = acsTokenLink;
    return data;
  }
}

class Epub {
  bool? isAvailable;
  String? downloadLink;

  Epub({this.isAvailable, this.downloadLink});

  Epub.fromJson(Map<String, dynamic> json) {
    isAvailable = json["isAvailable"];
    downloadLink = json["downloadLink"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isAvailable"] = isAvailable;
    data["downloadLink"] = downloadLink;
    return data;
  }
}

class SaleInfo {
  String? country;
  String? saleability;
  bool? isEbook;
  String? buyLink;

  SaleInfo({this.country, this.saleability, this.isEbook, this.buyLink});

  SaleInfo.fromJson(Map<String, dynamic> json) {
    country = json["country"];
    saleability = json["saleability"];
    isEbook = json["isEbook"];
    buyLink = json["buyLink"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["country"] = country;
    data["saleability"] = saleability;
    data["isEbook"] = isEbook;
    data["buyLink"] = buyLink;
    return data;
  }
}

class VolumeInfo {
  String? title;
  String? publisher;
  List<String>? authors;
  String? publishedDate;
  List<IndustryIdentifiers>? industryIdentifiers;
  ReadingModes? readingModes;
  int? pageCount;
  String? printType;
  List<String>? categories;
  String? maturityRating;
  bool? allowAnonLogging;
  String? contentVersion;
  PanelizationSummary? panelizationSummary;
  ImageLinks? imageLinks;
  String? language;
  String? previewLink;
  String? infoLink;
  String? canonicalVolumeLink;
  String? description;


  VolumeInfo(
      {this.title,
      this.publisher,
      this.authors,
      this.publishedDate,
      this.industryIdentifiers,
      this.readingModes,
      this.pageCount,
      this.printType,
      this.categories,
      this.maturityRating,
      this.allowAnonLogging,
      this.contentVersion,
      this.panelizationSummary,
      this.imageLinks,
      this.language,
      this.previewLink,
      this.infoLink,
      this.canonicalVolumeLink,
      this.description,
      });

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    publisher = json["publisher"];
    authors =
        json["authors"] == null ? null : List<String>.from(json["authors"]);
    publishedDate = json["publishedDate"];
    industryIdentifiers = json["industryIdentifiers"] == null
        ? null
        : (json["industryIdentifiers"] as List)
            .map((e) => IndustryIdentifiers.fromJson(e))
            .toList();
    readingModes = json["readingModes"] == null
        ? null
        : ReadingModes.fromJson(json["readingModes"]);
    pageCount = json["pageCount"];
    printType = json["printType"];
    categories = json["categories"] == null
        ? null
        : List<String>.from(json["categories"]);
    maturityRating = json["maturityRating"];
    allowAnonLogging = json["allowAnonLogging"];
    contentVersion = json["contentVersion"];
    panelizationSummary = json["panelizationSummary"] == null
        ? null
        : PanelizationSummary.fromJson(json["panelizationSummary"]);
    imageLinks = json["imageLinks"] == null
        ? null
        : ImageLinks.fromJson(json["imageLinks"]);
    language = json["language"];
    previewLink = json["previewLink"];
    infoLink = json["infoLink"];
    canonicalVolumeLink = json["canonicalVolumeLink"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    if (authors != null) {
      data["authors"] = authors;
    }
    data["publishedDate"] = publishedDate;
    if (industryIdentifiers != null) {
      data["industryIdentifiers"] =
          industryIdentifiers?.map((e) => e.toJson()).toList();
    }
    if (readingModes != null) {
      data["readingModes"] = readingModes?.toJson();
    }
    data["pageCount"] = pageCount;
    data["printType"] = printType;
    if (categories != null) {
      data["categories"] = categories;
    }
    data["maturityRating"] = maturityRating;
    data["allowAnonLogging"] = allowAnonLogging;
    data["contentVersion"] = contentVersion;
    if (panelizationSummary != null) {
      data["panelizationSummary"] = panelizationSummary?.toJson();
    }
    if (imageLinks != null) {
      data["imageLinks"] = imageLinks?.toJson();
    }
    data["language"] = language;
    data["previewLink"] = previewLink;
    data["infoLink"] = infoLink;
    data["canonicalVolumeLink"] = canonicalVolumeLink;
    data["description"] = description;
    return data;
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json["smallThumbnail"];
    thumbnail = json["thumbnail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["smallThumbnail"] = smallThumbnail;
    data["thumbnail"] = thumbnail;
    return data;
  }
}

class PanelizationSummary {
  bool? containsEpubBubbles;
  bool? containsImageBubbles;

  PanelizationSummary({this.containsEpubBubbles, this.containsImageBubbles});

  PanelizationSummary.fromJson(Map<String, dynamic> json) {
    containsEpubBubbles = json["containsEpubBubbles"];
    containsImageBubbles = json["containsImageBubbles"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["containsEpubBubbles"] = containsEpubBubbles;
    data["containsImageBubbles"] = containsImageBubbles;
    return data;
  }
}

class ReadingModes {
  bool? text;
  bool? image;

  ReadingModes({this.text, this.image});

  ReadingModes.fromJson(Map<String, dynamic> json) {
    text = json["text"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["text"] = text;
    data["image"] = image;
    return data;
  }
}

class IndustryIdentifiers {
  String? type;
  String? identifier;

  IndustryIdentifiers({this.type, this.identifier});

  IndustryIdentifiers.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    identifier = json["identifier"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["identifier"] = identifier;
    return data;
  }
}

import "dart:html";

const QUERY = "kittens";
String searchOnFlickr =
    "https://secure.flickr.com/services/rest/?method=flickr.photos.search"
    "&api_key=90485e931f687a9b9c2a66bf58a3861a"
    "&text=${Uri.encodeComponent(QUERY)}&safe_search=1&content_type=1"
    "&sort=interestingness-desc&per_page=20";

String constructKittenURL(Element kitten) {
  return "http://farm${kitten.getAttribute("farm")}.static.flickr.com/"
      "${kitten.getAttribute("server")}/"
      "${kitten.getAttribute("id")}_${kitten.getAttribute("secret")}_s.jpg";
}

void requestKittens() {
  HttpRequest.request(searchOnFlickr).then((HttpRequest resp) {
    resp.responseXml.querySelectorAll("photo").forEach((Element kitten) {
      var image = new ImageElement()
          ..src = constructKittenURL(kitten)
          ..alt = kitten.getAttribute("title");

      document.body.append(image);
    });
  });
}

void main() {
  requestKittens();
}

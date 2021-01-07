

class UtilsConfig {

  static getCookies (res ){
    String cookies;
    var  cookiestr = res.headers['set-cookie'].join(';');
    List  cookiesarr = cookiestr.split(';');
    cookiesarr.forEach((item){
      if(item.indexOf('JSESSIONID') != -1){
        var itemar = item.split('=');
        cookies = itemar[itemar.length - 1];
        
      }
    });
    return cookies;
  }
}
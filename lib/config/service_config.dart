abstract class HostUrlInfo {
  static const String yfb = 'https://rltx2-yfb-gateway.rltx.com'; //预发布

}

abstract class ServiceConfig {

  static const String contentType = 'application/x-www-form-urlencoded';

  static const String serviceUrl = HostUrlInfo.yfb;

}

abstract class ServicePath {
  static const Map<String, String> servicePath = {

    'apiFreightlist': ServiceConfig.serviceUrl + '/driver-api/driver-api/freight/list',//货源列表
    'selfInfo': ServiceConfig.serviceUrl +  '/driver-api/driver-api/person/self/info', //司机信息
    'accountLogin': ServiceConfig.serviceUrl + '/account/driverLogin',//登录
    'getPublicKey': ServiceConfig.serviceUrl + '/account/account/public/key',//获取公钥
    'loginOut': ServiceConfig.serviceUrl + '/account/logout',//获取公钥
  };

}
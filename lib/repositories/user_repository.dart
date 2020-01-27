import 'dart:async';
import 'dart:convert';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/models/userInfo.dart';

import 'AadConfig.dart';

enum IdentityProvider { Local, SliqAzureAD, Google, }

class UserRepository {
  // static String azureClientId = "8036875d-201f-4f00-b95c-0cd0d3b6e8c5";
  // static String azureTennant = "sliqdev.onmicrosoft.com";
  // static String azureRedirectUrl = "msauth://com.example.simpleauthflutterexample/Bmce%2B9aHdOoVtE7fS3B07tfj7Bc%3D";
  // static final Config config = new Config(azureTennant, azureClientId, "openid profile offline_access", azureRedirectUrl,);
  // final AadOAuth oauth = AadOAuth(config);
  AadOAuth oauth;
  String accessToken;
  bool presistFlag = false;
  
  String accessTokenGraph;
  UserInfo userInfo;
  Response userPhotoResp;

  Future<String> authenticate({
    @required String username,
    @required String password,
    IdentityProvider idp = IdentityProvider.Local,
  }) async {
    // String azureClientId = "1a2785ed-54bc-42b0-8405-beef84a92572";
    // // azureClientId = "b6eaf0b9-76c6-4bb8-9ef9-f24e373baaba";
    // azureClientId = "26088a05-1389-48df-a467-2e6f338551fe";
    // azureClientId = "5415a448-9e89-42c5-8d1f-48dae4cdfd0b";
    // String azureTennant = "sliqdev.onmicrosoft.com";
    // String azureRedirectUrl = "msauth://com.example.simpleauthflutterexample/Bmce%2B9aHdOoVtE7fS3B07tfj7Bc%3D";
    // // azureRedirectUrl = "https://login.microsoftonline.com/common/oauth2/nativeclient";
    // // azureRedirectUrl = "https://parlcuision.app.test";
    // // azureRedirectUrl = "https://login.microsoftonline.com/tfp/oauth2/nativeclient";
    // azureRedirectUrl = "urn:ietf:wg:oauth:2.0:oob";

    // String umApiBase = "https://sliqdev.onmicrosoft.com/usermanagementapi";
    // umApiBase = "https://sliqdev.onmicrosoft.com/sliqapi";
    // String scopes = "https://sliqdev.onmicrosoft.com/usermanagementapi/read";
    // scopes = "openid profile offline_access $umApiBase/ACL.Read $umApiBase/ACL.Write $umApiBase/Customers.ReadAll $umApiBase/user_impersonation";
    
String azureClientId = "5415a448-9e89-42c5-8d1f-48dae4cdfd0b";
String azureTennant = "sliqdev.onmicrosoft.com";
String azureRedirectUrl = "urn:ietf:wg:oauth:2.0:oob";
String umApiBase = "https://sliqdev.onmicrosoft.com/sliqapi";
String scopes = "openid profile offline_access $umApiBase/ACL.Read $umApiBase/ACL.Write $umApiBase/Customers.ReadAll $umApiBase/user_impersonation";
String policy = "b2c_1_siupin";

    // String scopes_ms = "user.read";

    // String secret = "-cio0oE-v8PRS67dNqGvJtRva?x]dP2s";
    
    // Config config = new Config(azureTennant, azureClientId, scopes, azureRedirectUrl);    
    // Config config_ms = new Config(azureTennant, azureClientId, scopes_ms, azureRedirectUrl);

    AadConfig config = new AadConfig(azureTennant, policy, azureClientId, scopes, azureRedirectUrl);
    // AadConfig configMs = new AadConfig(azureTennant, policy, azureClientId, scopes_ms, azureRedirectUrl);
    oauth = AadOAuth(config);
    AppConfig.instance.oauth = oauth;

    if(idp == IdentityProvider.SliqAzureAD){
      try{
        await oauth.login();
        accessToken = await oauth.getAccessToken();
        // accessTokenGraph = await oauth.getAccessTokenGraph();
        // String userInfoStr = await oauth.getUserInfo(accessToken);
        // print(userInfoStr);
        // Map<String, dynamic> userInfoJson = json.decode(userInfoStr);
        // userInfo = UserInfo.fromJson(userInfoJson);
        // userInfo = new UserInfo();

        print(AppConfig.instance.parseJwt(accessToken));

         Map<String, dynamic> accessTokenJson = AppConfig.instance.parseJwt(accessToken);
         String userEmail = (accessTokenJson['emails'] as List)[0];
         await AppConfig.instance.getGraphAccessToken();
         userInfo = await AppConfig.instance.getUserInfo(userEmail);

        // userPhotoResp = await oauth.getUserPhoto();
      }catch(error){
        rethrow;
      }
      
    }else{
      await Future.delayed(Duration(milliseconds: 200));
      accessToken="local";
    }
    return accessToken;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    // await Future.delayed(Duration(milliseconds: 200));
    await oauth.logout();
    accessToken = "";
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(milliseconds: 200));
    AppConfig.instance.accessToken = token;
    presistFlag = true;
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(milliseconds: 200));
    return presistFlag;
  }
}

package com.vtweens.shell
{
   import com.vtweens.consts.VERSION;
   import com.vtweens.util.Map;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ServerConfig extends EventDispatcher
   {
      
      public static const DATA_LOADED:String = "data_loaded";
      
      public static const HTTP_PROTOCOL:String = "protocol_http";
      
      public static const HTTPS_PROTOCOL:String = "protocol_https";
      
      public static const APP_EKOLOKO:String = "app_ekoloko";
      
      public static const APP_DATA:String = "app_web";
      
      public static const APP_FACEBOOK:String = "app_facebook";
      
      public static const APP_I18N:String = "app_i18n";
      
      public static const APP_JSON:String = "app_json";
       
      
      private var urlsXml = null;
      
      private var protocol_http:String;
      
      private var protocol_https:String;
      
      private var static_data_ip:String;
      
      private var static_data_port_http:String;
      
      private var static_data_port_https:String;
      
      private var facebook_data_ip:String;
      
      private var facebook_data_port_http:String;
      
      private var facebook_data_port_https:String;
      
      private var dynamic_data_ip:String;
      
      private var dynamic_data_port_http:String;
      
      private var dynamic_data_port_https:String;
      
      private var ekoloko_url:String;
      
      private var app_ekoloko:String;
      
      private var app_web:String;
      
      private var app_facebook:String;
      
      private var app_i18n:String;
      
      private var app_json:String;
      
      private var languages:Array;
      
      private var language:String;
      
      private var allowLanguageChange:Boolean = false;
      
      private var registerUrl:String;
      
      private var registrationUrl:String;
      
      private var textsUrl:String;
      
      private var contactsUrl:String;
      
      private var reloginUrl:String;
      
      private var loginUrl:String;
      
      private var captchaUrl:String;
      
      private var captcha3Url:String;
      
      private var captcha5Url:String;
      
      private var supportUrl:String;
      
      private var detailsUrl:String;
      
      private var inviteAFriendUrl:String;
      
      private var linkMeUrl:String;
      
      private var forgotPassUrl:String;
      
      private var changePassUrl:String;
      
      private var printAvatarUrl:String;
      
      private var ekolokoAppUrl:String;
      
      private var accountDetailsUrl:String;
      
      private var updateAccountDetailsUrl:String;
      
      private var purchaseRequestUrl:String;
      
      private var cardBalanceUrl:String;
      
      private var cardRedeemUrl:String;
      
      private var promoCardUrl:String;
      
      private var accountActivationUrl:String;
      
      private var accountActivation2Url:String;
      
      private var contactUs911Url:String;
      
      private var contactUsPioneerUrl:String;
      
      private var contactUsGeneralUrl:String;
      
      private var resetActivationKeyUrl:String;
      
      private var removeEmailUrl:String;
      
      private var rangerApplicationUrl:String;
      
      private var usernameValidationUrl:String;
      
      private var deleteAccountUrl:String;
      
      private var deleteAccountConfirmationUrl:String;
      
      private var productDataUrl:String;
      
      private var allProductsDataUrl:String;
      
      private var ravtavCardBalanceUrl:String;
      
      private var ravtavRedeemCardUrl:String;
      
      private var isPayingUserDataUrl:String;
      
      private var zongFrameUrl:String;
      
      private var praxellEwalletBalanceUrl:String;
      
      private var creditsCardBalanceUrl:String;
      
      private var praxellEwalletRedeemCardUrl:String;
      
      private var creditsCardRedeemCardUrl:String;
      
      private var allopassFrameUrl:String;
      
      private var mailFormUrl:String;
      
      private var bigMailFormUrl:String;
      
      private var pelecardPurchaseUrl:String;
      
      private var securityCheckDataUrl:String;
      
      private var securityQuestionsDataUrl:String;
      
      private var validateSecurityFormUrl:String;
      
      private var payCallGetCodeUrl:String;
      
      private var payCallCheckAgeUrl:String;
      
      private var payCallValidateCodeUrl:String;
      
      private var staticDataUrl:String;
      
      private var addToParentsEmailListUrl:String;
      
      private var addToUserEmailListUrl:String;
      
      private var removeFromParentsEmailListUrl:String;
      
      private var removeFromUserEmailListUrl:String;
      
      private var resetPasswordRequestUrl:String;
      
      private var resetPasswordUrl:String;
      
      private var registrationItemsUrl:String;
      
      private var publicDetailsUrl:String;
      
      private var generalCSUrl:String;
      
      private var badRegistrationEmailUrl:String;
      
      private var removeFromCRMUrl:String;
      
      private var introClipUrl:String;
      
      private var mobileRegCompleteUrl:String;
      
      private var taggedUrls:Map;
      
      private var basePath:String;
      
      private var generalDataLoader:URLLoader;
      
      private var urlsDataLoader:URLLoader;
      
      public function ServerConfig(param1:String = ".")
      {
         this.taggedUrls = new Map();
         super();
         this.basePath = param1;
         this.loadGeneralData();
      }
      
      public function isLoaded() : *
      {
         return this.registerUrl != null;
      }
      
      public function getStaticIp(param1:Boolean = false) : String
      {
         var _loc2_:* = !!param1 ? this.static_data_port_https : this.static_data_port_http;
         return this.static_data_ip + this.createPortString(int(_loc2_));
      }
      
      public function get availableLanguages() : Array
      {
         return this.languages;
      }
      
      public function get defaultLanguage() : String
      {
         return this.language;
      }
      
      public function get mayChangeLaguage() : Boolean
      {
         return this.allowLanguageChange;
      }
      
      public function getLanguage() : *
      {
         return this.language;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(param1 == DATA_LOADED && this.isLoaded())
         {
            dispatchEvent(new Event(DATA_LOADED));
         }
      }
      
      private function loadGeneralData() : *
      {
         this.generalDataLoader = new URLLoader();
         this.generalDataLoader.load(new URLRequest(this.basePath + "/conf/urls_general.xml?r=" + Math.random()));
         this.generalDataLoader.addEventListener(Event.COMPLETE,this.generalDataLoaded,false,0,true);
      }
      
      private function generalDataLoaded(param1:Event) : void
      {
         this.generalDataLoader.removeEventListener(Event.COMPLETE,this.loadServerConfig);
         var _loc2_:* = XML(this.generalDataLoader.data);
         this.protocol_http = _loc2_.protocol_http;
         this.protocol_https = _loc2_.protocol_https;
         this.static_data_ip = _loc2_.static_data_ip;
         this.static_data_port_http = _loc2_.static_data_port_http;
         this.static_data_port_https = _loc2_.static_data_port_https;
         this.dynamic_data_ip = _loc2_.dynamic_data_ip;
         this.dynamic_data_port_http = _loc2_.dynamic_data_port_http;
         this.dynamic_data_port_https = _loc2_.dynamic_data_port_https;
         this.facebook_data_ip = _loc2_.facebook_data_ip;
         this.facebook_data_port_http = _loc2_.facebook_data_port_http;
         this.facebook_data_port_https = _loc2_.facebook_data_port_https;
         this.app_ekoloko = _loc2_.app_ekoloko;
         this.app_web = _loc2_.app_web;
         this.app_i18n = _loc2_.app_i18n;
         this.app_facebook = _loc2_.app_facebook;
         this.app_json = _loc2_.app_json;
         this.languages = [];
         var _loc3_:* = _loc2_.languages;
         this.allowLanguageChange = Boolean(_loc3_.@allowLanguageChange.toString() == "yes");
         var _loc4_:* = _loc3_.children().length();
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            this.languages.push(_loc3_.child(_loc5_).@id.toString());
            if(_loc3_.child(_loc5_).@§default§.toString() == "yes")
            {
               this.language = _loc3_.child(_loc5_).@id.toString();
            }
            _loc5_++;
         }
         this.loadServerConfig();
      }
      
      private function loadServerConfig() : *
      {
         this.urlsDataLoader = new URLLoader();
         this.urlsDataLoader.load(new URLRequest(this.basePath + "/conf/urls.xml?" + VERSION.version));
         this.urlsDataLoader.addEventListener(Event.COMPLETE,this.onServerConfigLoaded);
      }
      
      private function onServerConfigLoaded(param1:Event) : void
      {
         var _loc6_:* = undefined;
         this.urlsDataLoader.removeEventListener(Event.COMPLETE,this.onServerConfigLoaded);
         var _loc2_:* = XML(this.urlsDataLoader.data);
         this.setTextsUrl(_loc2_.i18n.protocol,_loc2_.i18n.app);
         this.setContactsUrl(_loc2_.contacts.protocol,_loc2_.contacts.app,_loc2_.contacts.page);
         this.setRegisterUrl(_loc2_.register.protocol,_loc2_.register.app,_loc2_.register.page);
         this.setCaptchaUrl(_loc2_.captcha.protocol,_loc2_.captcha.app,_loc2_.captcha.page);
         this.setCaptcha3Url(_loc2_.captcha3.protocol,_loc2_.captcha3.app,_loc2_.captcha3.page);
         this.setCaptcha5Url(_loc2_.captcha5.protocol,_loc2_.captcha5.app,_loc2_.captcha5.page);
         this.setSupportUrl(_loc2_.support.protocol,_loc2_.support.app,_loc2_.support.page);
         this.setLoginUrl(_loc2_.login.protocol,_loc2_.login.app,_loc2_.login.page);
         this.setReloginUrl(_loc2_.relogin.protocol,_loc2_.relogin.app,_loc2_.relogin.page);
         this.setGetDetailsUrl(_loc2_.user_details.protocol,_loc2_.user_details.app,_loc2_.user_details.page);
         this.setPrintAvatarUrl(_loc2_.print_avatar.protocol,_loc2_.print_avatar.app,_loc2_.print_avatar.page);
         this.setInviteAFriendUrl(_loc2_.invite_a_friend.protocol,_loc2_.invite_a_friend.app,_loc2_.invite_a_friend.page);
         this.setForgotPassUrl(_loc2_.forgot_password.protocol,_loc2_.forgot_password.app,_loc2_.forgot_password.page);
         this.setChangePassUrl(_loc2_.cahnge_password.protocol,_loc2_.cahnge_password.app,_loc2_.cahnge_password.page);
         this.setEkolokoAppUrl(_loc2_.relogin.protocol,_loc2_.relogin.app);
         this.setLinkMeUrl(_loc2_.link_me.protocol,_loc2_.link_me.app,_loc2_.link_me.page);
         this.setAccountDetailsUrl(_loc2_.getAccountDetails.protocol,_loc2_.getAccountDetails.app,_loc2_.getAccountDetails.page);
         this.setUpdateAccountDetailsUrl(_loc2_.updateAccountDetails.protocol,_loc2_.updateAccountDetails.app,_loc2_.updateAccountDetails.page);
         this.setPurchaseRequestUrl(_loc2_.purchaseRequest.protocol,_loc2_.purchaseRequest.app,_loc2_.purchaseRequest.page);
         this.setCardRedeemUrl(_loc2_.cardRedeem.protocol,_loc2_.cardRedeem.app,_loc2_.cardRedeem.page);
         this.setCardBalanceUrl(_loc2_.cardBalance.protocol,_loc2_.cardBalance.app,_loc2_.cardBalance.page);
         this.setPromoCardUrl(_loc2_.promoCard.protocol,_loc2_.promoCard.app,_loc2_.promoCard.page);
         this.setAccountActivationUrl(_loc2_.accountActivation.protocol,_loc2_.accountActivation.app,_loc2_.accountActivation.page);
         this.setAccountActivation2Url(_loc2_.accountActivation2.protocol,_loc2_.accountActivation2.app,_loc2_.accountActivation2.page);
         this.setContactUs911Url(_loc2_.contactUs911.protocol,_loc2_.contactUs911.app,_loc2_.contactUs911.page);
         this.setContactUsPioneerUrl(_loc2_.contactUsPioneer.protocol,_loc2_.contactUsPioneer.app,_loc2_.contactUsPioneer.page);
         this.setContactUsGeneralUrl(_loc2_.contactUsGeneral.protocol,_loc2_.contactUsGeneral.app,_loc2_.contactUsGeneral.page);
         this.setResetActivationKeyUrl(_loc2_.resetActivationKey.protocol,_loc2_.resetActivationKey.app,_loc2_.resetActivationKey.page);
         this.setRemoveEmailUrl(_loc2_.removeEmail.protocol,_loc2_.removeEmail.app,_loc2_.removeEmail.page);
         this.setRangerApplicationUrl(_loc2_.rangerApplication.protocol,_loc2_.rangerApplication.app,_loc2_.rangerApplication.page);
         this.setUsernameValidationUrl(_loc2_.usernameValidation.protocol,_loc2_.usernameValidation.app,_loc2_.usernameValidation.page);
         this.setRegistrationUrl(_loc2_.registration.protocol,_loc2_.registration.app,_loc2_.registration.page);
         this.setDeleteAccountConfirmationUrl(_loc2_.deleteAccountConfirmation.protocol,_loc2_.deleteAccountConfirmation.app,_loc2_.deleteAccountConfirmation.page);
         this.setDeleteAccountUrl(_loc2_.deleteAccount.protocol,_loc2_.deleteAccount.app,_loc2_.deleteAccount.page);
         this.setProductDataUrl(_loc2_.productData.protocol,_loc2_.productData.app,_loc2_.productData.page);
         this.setAllProductsDataUrl(_loc2_.allProductsData.protocol,_loc2_.allProductsData.app,_loc2_.allProductsData.page);
         this.setRavtavCardBalanceUrl(_loc2_.ravtavCardBalance.protocol,_loc2_.ravtavCardBalance.app,_loc2_.ravtavCardBalance.page);
         this.setRavtavRedeemCardUrl(_loc2_.ravtavRedeemCard.protocol,_loc2_.ravtavRedeemCard.app,_loc2_.ravtavRedeemCard.page);
         this.setIsPayingUserDataUrl(_loc2_.isPayingUserData.protocol,_loc2_.isPayingUserData.app,_loc2_.isPayingUserData.page);
         this.setZongFrameUrl(_loc2_.zongFrame.protocol,_loc2_.zongFrame.app,_loc2_.zongFrame.page);
         this.setPraxellEwalletBalanceUrl(_loc2_.praxellEwalletBalance.protocol,_loc2_.praxellEwalletBalance.app,_loc2_.praxellEwalletBalance.page);
         this.setCreditsCardBalanceUrl(_loc2_.creditsCardBalance.protocol,_loc2_.creditsCardBalance.app,_loc2_.creditsCardBalance.page);
         this.setPraxellEwalletRedeemCardUrl(_loc2_.praxellEwalletRedeemCard.protocol,_loc2_.praxellEwalletRedeemCard.app,_loc2_.praxellEwalletRedeemCard.page);
         this.setCreditsCardRedeemCardUrl(_loc2_.creditsCardRedeemCard.protocol,_loc2_.creditsCardRedeemCard.app,_loc2_.creditsCardRedeemCard.page);
         this.setAllopassFrameUrl(_loc2_.allopassFrameUrl.protocol,_loc2_.allopassFrameUrl.app,_loc2_.allopassFrameUrl.page);
         this.setMailFormUrl(_loc2_.mailFormUrl.protocol,_loc2_.mailFormUrl.app,_loc2_.mailFormUrl.page);
         this.setBigMailFormUrl(_loc2_.bigMailFormUrl.protocol,_loc2_.bigMailFormUrl.app,_loc2_.bigMailFormUrl.page);
         this.setPelecardPurchaseUrl(_loc2_.pelecardPurchaseUrl.protocol,_loc2_.pelecardPurchaseUrl.app,_loc2_.pelecardPurchaseUrl.page);
         this.setSecurityCheckData(_loc2_.securityCheckData.protocol,_loc2_.securityCheckData.app,_loc2_.securityCheckData.page);
         this.setSecurityQuestionsData(_loc2_.securityQuestionsData.protocol,_loc2_.securityQuestionsData.app,_loc2_.securityQuestionsData.page);
         this.setValidateSecurityForm(_loc2_.validateSecurityForm.protocol,_loc2_.validateSecurityForm.app,_loc2_.validateSecurityForm.page);
         this.setPayCallGetCodeUrl(_loc2_.paycallGetCode.protocol,_loc2_.paycallGetCode.app,_loc2_.paycallGetCode.page);
         this.setPayCallValidateCodeUrl(_loc2_.paycallValidateCode.protocol,_loc2_.paycallValidateCode.app,_loc2_.paycallValidateCode.page);
         this.setPayCallCheckAgeUrl(_loc2_.paycallCheckAge.protocol,_loc2_.paycallCheckAge.app,_loc2_.paycallCheckAge.page);
         this.setStaticDataUrl(_loc2_.staticDataUrl.protocol,_loc2_.staticDataUrl.app,_loc2_.staticDataUrl.page);
         this.setAddToParentsEmailListUrl(_loc2_.addToParentsEmailListUrl.protocol,_loc2_.addToParentsEmailListUrl.app,_loc2_.addToParentsEmailListUrl.page);
         this.setAddToUserEmailListUrl(_loc2_.addToUserEmailListUrl.protocol,_loc2_.addToUserEmailListUrl.app,_loc2_.addToUserEmailListUrl.page);
         this.setRemoveFromParentsEmailListUrl(_loc2_.removeFromParentsEmailListUrl.protocol,_loc2_.removeFromParentsEmailListUrl.app,_loc2_.removeFromParentsEmailListUrl.page);
         this.setRemoveFromUserEmailListUrl(_loc2_.removeFromUserEmailListUrl.protocol,_loc2_.removeFromUserEmailListUrl.app,_loc2_.removeFromUserEmailListUrl.page);
         this.setResetPasswordRequestUrl(_loc2_.resetPasswordRequestUrl.protocol,_loc2_.resetPasswordRequestUrl.app,_loc2_.resetPasswordRequestUrl.page);
         this.setResetPasswordUrl(_loc2_.resetPasswordUrl.protocol,_loc2_.resetPasswordUrl.app,_loc2_.resetPasswordUrl.page);
         this.setRegistrationItemsUrl(_loc2_.registrationItemsUrl.protocol,_loc2_.registrationItemsUrl.app,_loc2_.registrationItemsUrl.page);
         this.setPublicDetailsUrl(_loc2_.publicDetailsUrl.protocol,_loc2_.publicDetailsUrl.app,_loc2_.publicDetailsUrl.page);
         this.setGeneralCSUrl(_loc2_.generalCSUrl.protocol,_loc2_.generalCSUrl.app,_loc2_.generalCSUrl.page);
         this.setBadRegistrationEmailUrl(_loc2_.badRegistrationEmailUrl.protocol,_loc2_.badRegistrationEmailUrl.app,_loc2_.badRegistrationEmailUrl.page);
         this.setRemoveFromCRMUrl(_loc2_.removeFromCRMUrl.protocol,_loc2_.removeFromCRMUrl.app,_loc2_.removeFromCRMUrl.page);
         this.setIntroClipUrl(_loc2_.introClipUrl.protocol,_loc2_.introClipUrl.app,_loc2_.introClipUrl.page);
         this.setMobileRegCompleteUrl(_loc2_.mobileRegCompleteUrl.protocol,_loc2_.mobileRegCompleteUrl.app,_loc2_.mobileRegCompleteUrl.page);
         var _loc3_:* = _loc2_.tags;
         var _loc4_:* = _loc3_.children().length();
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_.child(_loc5_);
            this.taggedUrls.put(String(_loc6_.attribute("id")),this.createTagUrl(_loc6_));
            _loc5_++;
         }
         this.urlsXml = _loc2_;
         dispatchEvent(new Event(DATA_LOADED));
      }
      
      private function isStaticData(param1:String) : Boolean
      {
         return param1 == APP_EKOLOKO || param1 == APP_I18N || param1 == APP_JSON;
      }
      
      public function getApp(param1:String) : *
      {
         switch(param1)
         {
            case APP_EKOLOKO:
               return this.app_ekoloko;
            case APP_DATA:
               return this.app_web;
            case APP_FACEBOOK:
               return this.app_facebook;
            case APP_I18N:
               return this.app_i18n;
            case APP_JSON:
               return this.app_json;
            default:
               return "";
         }
      }
      
      public function buildUrl(param1:String, param2:String, param3:String = null) : String
      {
         var _loc6_:* = undefined;
         var _loc4_:String = "";
         var _loc5_:* = this.dynamic_data_ip;
         if(param2 == APP_EKOLOKO || param2 == APP_I18N || param2 == APP_JSON)
         {
            _loc5_ = this.static_data_ip;
         }
         else if(param2 == APP_FACEBOOK)
         {
            _loc5_ = this.facebook_data_ip;
         }
         if(param1 == HTTP_PROTOCOL)
         {
            _loc6_ = this.dynamic_data_port_http;
            if(this.isStaticData(param2))
            {
               _loc6_ = this.static_data_port_http;
            }
            else if(param2 == APP_FACEBOOK)
            {
               _loc6_ = this.facebook_data_port_http;
            }
            _loc4_ += "http://" + _loc5_ + this.createPortString(_loc6_) + "/";
         }
         else if(param1 == HTTPS_PROTOCOL)
         {
            _loc6_ = this.dynamic_data_port_https;
            if(this.isStaticData(param2))
            {
               _loc6_ = this.static_data_port_https;
            }
            else if(param2 == APP_EKOLOKO)
            {
               _loc6_ = this.facebook_data_port_https;
            }
            _loc4_ += "https://" + _loc5_ + this.createPortString(_loc6_) + "/";
         }
         _loc4_ += this.getApp(param2);
         if(param3)
         {
            _loc4_ += "/" + param3;
         }
         return _loc4_;
      }
      
      private function setTextsUrl(param1:String, param2:String) : *
      {
         this.textsUrl = this.buildUrl(param1,param2) + "/";
      }
      
      public function getTextsUrl() : String
      {
         return this.textsUrl;
      }
      
      public function getUrlsXml() : *
      {
         return this.urlsXml;
      }
      
      private function createPortString(param1:int) : String
      {
         return param1 == 80 || param1 == 443 ? "" : ":" + param1;
      }
      
      private function createTagUrl(param1:*) : String
      {
         return this.buildUrl(param1.protocol,param1.app,param1.page);
      }
      
      private function setContactsUrl(param1:String, param2:String, param3:String) : *
      {
         this.contactsUrl = this.buildUrl(param1,param2,param3) + "?request_locale=";
      }
      
      private function setRegisterUrl(param1:String, param2:String, param3:String) : *
      {
         this.registerUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setCaptchaUrl(param1:String, param2:String, param3:String) : *
      {
         this.captchaUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setCaptcha3Url(param1:String, param2:String, param3:String) : *
      {
         this.captcha3Url = this.buildUrl(param1,param2,param3);
      }
      
      private function setCaptcha5Url(param1:String, param2:String, param3:String) : *
      {
         this.captcha5Url = this.buildUrl(param1,param2,param3);
      }
      
      private function setLoginUrl(param1:String, param2:String, param3:String) : *
      {
         this.loginUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setSupportUrl(param1:String, param2:String, param3:String) : *
      {
         this.supportUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setReloginUrl(param1:String, param2:String, param3:String) : *
      {
         this.reloginUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setGetDetailsUrl(param1:String, param2:String, param3:String) : *
      {
         this.detailsUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPrintAvatarUrl(param1:String, param2:String, param3:String) : *
      {
         this.printAvatarUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setInviteAFriendUrl(param1:String, param2:String, param3:String) : *
      {
         this.inviteAFriendUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setForgotPassUrl(param1:String, param2:String, param3:String) : *
      {
         this.forgotPassUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setChangePassUrl(param1:String, param2:String, param3:String) : *
      {
         this.changePassUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setLinkMeUrl(param1:String, param2:String, param3:String) : *
      {
         this.linkMeUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setEkolokoAppUrl(param1:String, param2:String) : *
      {
         this.ekolokoAppUrl = this.buildUrl(param1,param2);
      }
      
      private function setAccountDetailsUrl(param1:String, param2:String, param3:String) : *
      {
         this.accountDetailsUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setUpdateAccountDetailsUrl(param1:String, param2:String, param3:String) : *
      {
         this.updateAccountDetailsUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPurchaseRequestUrl(param1:String, param2:String, param3:String) : *
      {
         this.purchaseRequestUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setCardBalanceUrl(param1:String, param2:String, param3:String) : *
      {
         this.cardBalanceUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setCardRedeemUrl(param1:String, param2:String, param3:String) : *
      {
         this.cardRedeemUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPromoCardUrl(param1:String, param2:String, param3:String) : *
      {
         this.promoCardUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setAccountActivationUrl(param1:String, param2:String, param3:String) : *
      {
         this.accountActivationUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setAccountActivation2Url(param1:String, param2:String, param3:String) : *
      {
         this.accountActivation2Url = this.buildUrl(param1,param2,param3);
      }
      
      private function setContactUs911Url(param1:String, param2:String, param3:String) : *
      {
         this.contactUs911Url = this.buildUrl(param1,param2,param3);
      }
      
      private function setContactUsPioneerUrl(param1:String, param2:String, param3:String) : *
      {
         this.contactUsPioneerUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setContactUsGeneralUrl(param1:String, param2:String, param3:String) : *
      {
         this.contactUsGeneralUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setResetActivationKeyUrl(param1:String, param2:String, param3:String) : *
      {
         this.resetActivationKeyUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRemoveEmailUrl(param1:String, param2:String, param3:String) : *
      {
         this.removeEmailUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRangerApplicationUrl(param1:String, param2:String, param3:String) : *
      {
         this.rangerApplicationUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setUsernameValidationUrl(param1:String, param2:String, param3:String) : *
      {
         this.usernameValidationUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRegistrationUrl(param1:String, param2:String, param3:String) : *
      {
         this.registrationUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setDeleteAccountConfirmationUrl(param1:String, param2:String, param3:String) : *
      {
         this.deleteAccountConfirmationUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setDeleteAccountUrl(param1:String, param2:String, param3:String) : *
      {
         this.deleteAccountUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setProductDataUrl(param1:String, param2:String, param3:String) : *
      {
         this.productDataUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setAllProductsDataUrl(param1:String, param2:String, param3:String) : *
      {
         this.allProductsDataUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRavtavCardBalanceUrl(param1:String, param2:String, param3:String) : *
      {
         this.ravtavCardBalanceUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRavtavRedeemCardUrl(param1:String, param2:String, param3:String) : *
      {
         this.ravtavRedeemCardUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setIsPayingUserDataUrl(param1:String, param2:String, param3:String) : *
      {
         this.isPayingUserDataUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setZongFrameUrl(param1:String, param2:String, param3:String) : *
      {
         this.zongFrameUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setCreditsCardBalanceUrl(param1:String, param2:String, param3:String) : *
      {
         this.creditsCardBalanceUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPraxellEwalletBalanceUrl(param1:String, param2:String, param3:String) : *
      {
         this.praxellEwalletBalanceUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setCreditsCardRedeemCardUrl(param1:String, param2:String, param3:String) : *
      {
         this.creditsCardRedeemCardUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPraxellEwalletRedeemCardUrl(param1:String, param2:String, param3:String) : *
      {
         this.praxellEwalletRedeemCardUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setAllopassFrameUrl(param1:String, param2:String, param3:String) : *
      {
         this.allopassFrameUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setMailFormUrl(param1:String, param2:String, param3:String) : *
      {
         this.mailFormUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPelecardPurchaseUrl(param1:String, param2:String, param3:String) : *
      {
         this.pelecardPurchaseUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setSecurityCheckData(param1:String, param2:String, param3:String) : *
      {
         this.securityCheckDataUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setSecurityQuestionsData(param1:String, param2:String, param3:String) : *
      {
         this.securityQuestionsDataUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setValidateSecurityForm(param1:String, param2:String, param3:String) : *
      {
         this.validateSecurityFormUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPayCallGetCodeUrl(param1:String, param2:String, param3:String) : *
      {
         this.payCallGetCodeUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPayCallValidateCodeUrl(param1:String, param2:String, param3:String) : *
      {
         this.payCallValidateCodeUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPayCallCheckAgeUrl(param1:String, param2:String, param3:String) : *
      {
         this.payCallCheckAgeUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setStaticDataUrl(param1:String, param2:String, param3:String) : *
      {
         this.staticDataUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setAddToParentsEmailListUrl(param1:String, param2:String, param3:String) : *
      {
         this.addToParentsEmailListUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setAddToUserEmailListUrl(param1:String, param2:String, param3:String) : *
      {
         this.addToUserEmailListUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRemoveFromParentsEmailListUrl(param1:String, param2:String, param3:String) : *
      {
         this.removeFromParentsEmailListUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRemoveFromUserEmailListUrl(param1:String, param2:String, param3:String) : *
      {
         this.removeFromUserEmailListUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setResetPasswordUrl(param1:String, param2:String, param3:String) : *
      {
         this.resetPasswordUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setResetPasswordRequestUrl(param1:String, param2:String, param3:String) : *
      {
         this.resetPasswordRequestUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRegistrationItemsUrl(param1:String, param2:String, param3:String) : *
      {
         this.registrationItemsUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setPublicDetailsUrl(param1:String, param2:String, param3:String) : *
      {
         this.publicDetailsUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setGeneralCSUrl(param1:String, param2:String, param3:String) : *
      {
         this.generalCSUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setBadRegistrationEmailUrl(param1:String, param2:String, param3:String) : *
      {
         this.badRegistrationEmailUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setRemoveFromCRMUrl(param1:String, param2:String, param3:String) : *
      {
         this.removeFromCRMUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setIntroClipUrl(param1:String, param2:String, param3:String) : *
      {
         this.introClipUrl = this.buildUrl(param1,param2,param3);
      }
      
      private function setMobileRegCompleteUrl(param1:String, param2:String, param3:String) : *
      {
         this.mobileRegCompleteUrl = this.buildUrl(param1,param2,param3);
      }
      
      public function getMobileRegCompleteUrl(param1:* = false) : String
      {
         return !param1 ? this.mobileRegCompleteUrl : this.setSecured(this.mobileRegCompleteUrl);
      }
      
      public function getIntroClipUrl(param1:* = false) : String
      {
         return !param1 ? this.introClipUrl : this.setSecured(this.introClipUrl);
      }
      
      public function getRemoveFromCRMUrl(param1:* = false) : String
      {
         return !param1 ? this.removeFromCRMUrl : this.setSecured(this.removeFromCRMUrl);
      }
      
      public function getBadRegistrationEmailUrl(param1:* = false) : String
      {
         return !param1 ? this.badRegistrationEmailUrl : this.setSecured(this.badRegistrationEmailUrl);
      }
      
      public function getGeneralCSUrl(param1:* = false) : String
      {
         return !param1 ? this.generalCSUrl : this.setSecured(this.generalCSUrl);
      }
      
      public function getPublicDetailsUrl(param1:* = false) : String
      {
         return !param1 ? this.publicDetailsUrl : this.setSecured(this.publicDetailsUrl);
      }
      
      public function getRegistrationItemsUrl(param1:* = false) : String
      {
         return !param1 ? this.registrationItemsUrl : this.setSecured(this.registrationItemsUrl);
      }
      
      public function getResetPasswordRequestUrl(param1:* = false) : String
      {
         return !param1 ? this.resetPasswordRequestUrl : this.setSecured(this.resetPasswordRequestUrl);
      }
      
      public function getResetPasswordUrl(param1:* = false) : String
      {
         return !param1 ? this.resetPasswordUrl : this.setSecured(this.resetPasswordUrl);
      }
      
      public function getRemoveFromUserEmailListUrl(param1:* = false) : String
      {
         return !param1 ? this.removeFromUserEmailListUrl : this.setSecured(this.removeFromUserEmailListUrl);
      }
      
      public function getRemoveFromParentsEmailListUrl(param1:* = false) : String
      {
         return !param1 ? this.removeFromParentsEmailListUrl : this.setSecured(this.removeFromParentsEmailListUrl);
      }
      
      public function getAddToUserEmailListUrl(param1:* = false) : String
      {
         return !param1 ? this.addToUserEmailListUrl : this.setSecured(this.addToUserEmailListUrl);
      }
      
      public function getAddToParentsEmailListUrl(param1:* = false) : String
      {
         return !param1 ? this.addToParentsEmailListUrl : this.setSecured(this.addToParentsEmailListUrl);
      }
      
      public function getStaticDataUrl(param1:* = false) : String
      {
         return !param1 ? this.staticDataUrl : this.setSecured(this.staticDataUrl);
      }
      
      public function getPayCheckAgeUrl(param1:* = false) : String
      {
         return !param1 ? this.payCallCheckAgeUrl : this.setSecured(this.payCallCheckAgeUrl);
      }
      
      public function getPayCallValidateCodeUrl(param1:* = false) : String
      {
         return !param1 ? this.payCallValidateCodeUrl : this.setSecured(this.payCallValidateCodeUrl);
      }
      
      public function getPayCallGetCodeUrl(param1:* = false) : String
      {
         return !param1 ? this.payCallGetCodeUrl : this.setSecured(this.payCallGetCodeUrl);
      }
      
      public function getValidateSecurityFormUrl(param1:* = false) : String
      {
         return !param1 ? this.validateSecurityFormUrl : this.setSecured(this.validateSecurityFormUrl);
      }
      
      public function getSecurityQuestionsData(param1:* = false) : String
      {
         return !param1 ? this.securityQuestionsDataUrl : this.setSecured(this.securityQuestionsDataUrl);
      }
      
      public function getSecurityCheckData(param1:* = false) : String
      {
         return !param1 ? this.securityCheckDataUrl : this.setSecured(this.securityCheckDataUrl);
      }
      
      private function setSecured(param1:String) : String
      {
         return param1.replace("http://","https://");
      }
      
      private function setBigMailFormUrl(param1:String, param2:String, param3:String) : *
      {
         this.bigMailFormUrl = this.buildUrl(param1,param2,param3);
      }
      
      public function getBigMailFormUrl(param1:* = false) : String
      {
         return !param1 ? this.bigMailFormUrl : this.setSecured(this.bigMailFormUrl);
      }
      
      public function getPelecardPurchaseUrl(param1:* = false) : String
      {
         return !param1 ? this.pelecardPurchaseUrl : this.setSecured(this.pelecardPurchaseUrl);
      }
      
      public function getMailFormUrl(param1:* = false) : String
      {
         return !param1 ? this.mailFormUrl : this.setSecured(this.mailFormUrl);
      }
      
      public function getAllopassFrameUrl(param1:* = false) : String
      {
         return !param1 ? this.allopassFrameUrl : this.setSecured(this.allopassFrameUrl);
      }
      
      public function getPraxellEwalletRedeemCardUrl(param1:* = false) : String
      {
         return !param1 ? this.praxellEwalletRedeemCardUrl : this.setSecured(this.praxellEwalletRedeemCardUrl);
      }
      
      public function getCreditsCardRedeemCardUrl(param1:* = false) : String
      {
         return !param1 ? this.creditsCardRedeemCardUrl : this.setSecured(this.creditsCardRedeemCardUrl);
      }
      
      public function getPraxellEwalletBalanceUrl(param1:* = false) : String
      {
         return !param1 ? this.praxellEwalletBalanceUrl : this.setSecured(this.praxellEwalletBalanceUrl);
      }
      
      public function getCreditsCardBalanceUrl(param1:* = false) : String
      {
         return !param1 ? this.creditsCardBalanceUrl : this.setSecured(this.creditsCardBalanceUrl);
      }
      
      public function getZongFrameUrl(param1:* = false) : String
      {
         return !param1 ? this.zongFrameUrl : this.setSecured(this.zongFrameUrl);
      }
      
      public function getIsPayingUserDataUrl(param1:* = false) : String
      {
         return !param1 ? this.isPayingUserDataUrl : this.setSecured(this.isPayingUserDataUrl);
      }
      
      public function getRavtavRedeemCardUrl(param1:* = false) : String
      {
         return !param1 ? this.ravtavRedeemCardUrl : this.setSecured(this.ravtavRedeemCardUrl);
      }
      
      public function getRavtavCardBalanceUrl(param1:* = false) : String
      {
         return !param1 ? this.ravtavCardBalanceUrl : this.setSecured(this.ravtavCardBalanceUrl);
      }
      
      public function getAllProductsDataUrl(param1:* = false) : String
      {
         return !param1 ? this.allProductsDataUrl : this.setSecured(this.allProductsDataUrl);
      }
      
      public function getProductDataUrl(param1:* = false) : String
      {
         return !param1 ? this.productDataUrl : this.setSecured(this.productDataUrl);
      }
      
      public function getDeleteAccountUrl(param1:* = false) : String
      {
         return !param1 ? this.deleteAccountUrl : this.setSecured(this.deleteAccountUrl);
      }
      
      public function getDeleteAccountConfirmationUrl(param1:* = false) : String
      {
         return !param1 ? this.deleteAccountConfirmationUrl : this.setSecured(this.deleteAccountConfirmationUrl);
      }
      
      public function getRegistrationUrl(param1:* = false) : String
      {
         return !param1 ? this.registrationUrl : this.setSecured(this.registrationUrl);
      }
      
      public function getUsernameValidationUrl(param1:* = false) : String
      {
         return !param1 ? this.usernameValidationUrl : this.setSecured(this.usernameValidationUrl);
      }
      
      public function getRangerApplicationUrl(param1:* = false) : String
      {
         return !param1 ? this.rangerApplicationUrl : this.setSecured(this.rangerApplicationUrl);
      }
      
      public function getRemoveEmailUrl(param1:* = false) : String
      {
         return !param1 ? this.removeEmailUrl : this.setSecured(this.removeEmailUrl);
      }
      
      public function getResetActivationKeyUrl(param1:* = false) : String
      {
         return !param1 ? this.resetActivationKeyUrl : this.setSecured(this.resetActivationKeyUrl);
      }
      
      public function getContactUsGenetalUrl(param1:* = false) : String
      {
         return !param1 ? this.contactUsGeneralUrl : this.setSecured(this.contactUsGeneralUrl);
      }
      
      public function getContactUsPioneerUrl(param1:* = false) : String
      {
         return !param1 ? this.contactUsPioneerUrl : this.setSecured(this.contactUsPioneerUrl);
      }
      
      public function getContactUs911Url(param1:* = false) : String
      {
         return !param1 ? this.contactUs911Url : this.setSecured(this.contactUs911Url);
      }
      
      public function getAccountActivationUrl(param1:* = false) : String
      {
         return !param1 ? this.accountActivationUrl : this.setSecured(this.accountActivationUrl);
      }
      
      public function getAccountActivation2Url(param1:* = false) : String
      {
         return !param1 ? this.accountActivation2Url : this.setSecured(this.accountActivation2Url);
      }
      
      public function getPromoCardUrl(param1:* = false) : String
      {
         return !param1 ? this.promoCardUrl : this.setSecured(this.promoCardUrl);
      }
      
      public function getCardRedeemUrl(param1:* = false) : String
      {
         return !param1 ? this.cardRedeemUrl : this.setSecured(this.cardRedeemUrl);
      }
      
      public function getCardBalanceUrl(param1:* = false) : String
      {
         return !param1 ? this.cardBalanceUrl : this.setSecured(this.cardBalanceUrl);
      }
      
      public function getPurchaseRequestUrl(param1:* = false) : String
      {
         return !param1 ? this.purchaseRequestUrl : this.setSecured(this.purchaseRequestUrl);
      }
      
      public function getUpdateAccountDetailsUrl(param1:* = false) : String
      {
         return !param1 ? this.updateAccountDetailsUrl : this.setSecured(this.updateAccountDetailsUrl);
      }
      
      public function getAccountDetailsUrl(param1:* = false) : String
      {
         return !param1 ? this.accountDetailsUrl : this.setSecured(this.accountDetailsUrl);
      }
      
      public function getRegisterUrl(param1:* = false) : String
      {
         return !param1 ? this.registerUrl : this.setSecured(this.registerUrl);
      }
      
      public function getContactsUrl(param1:* = false) : String
      {
         return !param1 ? this.contactsUrl : this.setSecured(this.contactsUrl);
      }
      
      public function getReloginUrl(param1:* = false) : String
      {
         return !param1 ? this.reloginUrl : this.setSecured(this.reloginUrl);
      }
      
      public function getLoginUrl(param1:* = false) : String
      {
         return !param1 ? this.loginUrl : this.setSecured(this.loginUrl);
      }
      
      public function getCaptchaUrl(param1:* = false) : String
      {
         return !param1 ? this.captchaUrl : this.setSecured(this.captchaUrl);
      }
      
      public function getCaptcha3Url(param1:* = false) : String
      {
         return !param1 ? this.captcha3Url : this.setSecured(this.captcha3Url);
      }
      
      public function getCaptcha5Url(param1:* = false) : String
      {
         return !param1 ? this.captcha5Url : this.setSecured(this.captcha5Url);
      }
      
      public function getSupportUrl(param1:* = false) : String
      {
         return !param1 ? this.supportUrl : this.setSecured(this.supportUrl);
      }
      
      public function getDetailsUrl(param1:* = false) : String
      {
         return !param1 ? this.detailsUrl : this.setSecured(this.detailsUrl);
      }
      
      public function getInviteAFriendUrl(param1:* = false) : String
      {
         return !param1 ? this.inviteAFriendUrl : this.setSecured(this.inviteAFriendUrl);
      }
      
      public function getForgotPassUrl(param1:* = false) : String
      {
         return !param1 ? this.forgotPassUrl : this.setSecured(this.forgotPassUrl);
      }
      
      public function getChangePassUrl(param1:* = false) : String
      {
         return !param1 ? this.changePassUrl : this.setSecured(this.changePassUrl);
      }
      
      public function getPrintAvatarUrl(param1:* = false) : String
      {
         return !param1 ? this.printAvatarUrl : this.setSecured(this.printAvatarUrl);
      }
      
      public function getLinkMeUrl(param1:* = false) : String
      {
         return !param1 ? this.linkMeUrl : this.setSecured(this.linkMeUrl);
      }
      
      public function getEkolokoAppUrl(param1:* = false) : String
      {
         return !param1 ? this.ekolokoAppUrl : this.setSecured(this.ekolokoAppUrl);
      }
      
      public function getUrlByTag(param1:String, param2:* = false) : String
      {
         return !param2 ? this.taggedUrls.get(param1) : this.setSecured(this.taggedUrls.get(param1));
      }
   }
}

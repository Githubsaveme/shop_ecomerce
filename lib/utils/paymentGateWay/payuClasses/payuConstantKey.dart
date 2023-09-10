class PayUConstants {
  static const payUPaymentParams = "payUPaymentParams";
  static const payUCheckoutProConfig = "payUCheckoutProConfig";
  //Callback handling, Method channel name
  static const onPaymentSuccess = "onPaymentSuccess";
  static const onPaymentFailure = "onPaymentFailure";
  static const onPaymentCancel = "onPaymentCancel";
  static const onError = "onError";
  static const generateHash = "generateHash";
  static const errorMsg = "errorMsg";
  static const errorCode = "errorCode";
  static const isTxnInitiated = "isTxnInitiated";
}

class PayUHashConstantsKeys {
  static const hashName = "hashName";
  static const hashString = "hashString";
  static const hashType = "hashType";
  static const hashVersionV1 = "V1";
  static const hashVersionV2 = "V2";
  static const mcpLookup = "mcpLookup";
  static const postSalt = "postSalt";
}

//Payment request keys ------
class PayUPaymentParamKey {
  static const key = "key";
  static const amount = "amount";
  static const productInfo = "productInfo";
  static const firstName = "firstName";
  static const email = "email";
  static const phone = "phone";
  static const ios_surl = "ios_surl";
  static const ios_furl = "ios_furl";
  static const android_surl = "android_surl";
  static const android_furl = "android_furl";
  static const environment = "environment";
  static const userCredential = "userCredential";
  static const transactionId = "transactionId";
  static const additionalParam = "additionalParam";
  static const payUSIParams = "payUSIParams";
  static const splitPaymentDetails = "splitPaymentDetails";
  static const enableNativeOTP = "enableNativeOTP";
  static const userToken = "userToken"; //Offers user token -
}

class PayUSIParamsKeys {
  static const isFreeTrial = "isFreeTrial";
  static const billingAmount = "billingAmount";
  static const billingInterval = "billingInterval";
  static const paymentStartDate = "paymentStartDate";
  static const paymentEndDate = "paymentEndDate";
  static const billingCycle = "billingCycle";
  static const remarks = "remarks";
  static const billingCurrency = "billingCurrency";
  static const billingLimit = "billingLimit";
  static const billingRule = "billingRule";
}

class PayUUserCredentialsParamKeys {
  static const userName = "userName";
}

class PayUAdditionalParamKeys {
  static const udf1 = "udf1";
  static const udf2 = "udf2";
  static const udf3 = "udf3";
  static const udf4 = "udf4";
  static const udf5 = "udf5";
  static const hash = "hash";
  static const merchantAccessKey = "merchantAccessKey";
  static const sourceId = "sourceId"; //Sodexo source ID
}

class PayUCheckoutProConfigKeys {
  static const primaryColor = "primaryColor";
  static const secondaryColor = "secondaryColor";
  static const merchantName = "merchantName";
  static const merchantLogo = "merchantLogo";
  static const showExitConfirmationOnCheckoutScreen =
      "showExitConfirmationOnCheckoutScreen";
  static const showExitConfirmationOnPaymentScreen =
      "showExitConfirmationOnPaymentScreen";
  static const cartDetails = "cartDetails";
  static const paymentModesOrder = "paymentModesOrder";
  static const merchantResponseTimeout = "merchantResponseTimeout";
  static const customNotes = "customNotes";
  static const autoSelectOtp = "autoSelectOtp";
  static const enforcePaymentList = "enforcePaymentList";

  static const waitingTime = "waitingTime"; //-->(Android)
  static const autoApprove = "autoApprove"; //-->(Android)
  static const merchantSMSPermission = "merchantSMSPermission"; //-->(Android)
  static const showCbToolbar = "showCbToolbar"; //-->(Android)
}


class PayUPaymentTypeKeys {

  static const card =  "CARD";
  static const nb =  "NB";
  static const upi =  "UPI";
  static const upiIntent =  "UPI_INTENT";
  static const wallet =  "WALLET";
  static const emi =  "EMI";
  static const neftRtgs =  "NEFTRTGS";
  static const l1Option =  "L1_OPTION";
  static const sodexo =  "SODEXO";
}

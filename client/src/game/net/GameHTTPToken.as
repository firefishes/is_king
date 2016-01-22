package game.net 
{
	import shipDock.core.SDCore;
	import shipDock.manager.LocaleManager;
	import shipDock.net.http.HTTPToken;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GameHTTPToken extends HTTPToken 
	{
		
		public static const R_CODE_ABNORMAL:int = 1;//异常返回值
		public static const R_CODE_UNKNOW:int = 2;//未知的异常返回值
		
		public static const M_CODE_0:int = 0;//网络问题
		public static const M_CODE_500:int = 500;//服务端接口报错
		public static const M_CODE_N_500:int = -500;//服务端接口报错
		public static const M_CODE_N_403:int = -403;//服务端系统维护
		
		public function GameHTTPToken(doSuccess:Function=null, doFail:Function=null) 
		{
			super(doSuccess, doFail);
			
		}
		
		override protected function checkResultSuccess(result:Object):Boolean 
		{
			var rCode:int = result["rc"];
			var mCode:int = result["mc"];
			
			if (rCode == R_CODE_ABNORMAL) {//异常处理
				
				var errorData:Object = {"rc":rCode, "errorCode":mCode};//报错数据
				errorData["errorContent"] = LocaleManager.getInstance().getText(result["mc"]);
				
				if (mCode == M_CODE_N_500) {//服务端错误
					result = null;
					
				}else if (mCode == M_CODE_N_403) {//系统维护
					result = null;
					
				}else if (result["url"] != null) {//应用更新
					errorData["open_time"] = result["open_time"];
					
				}else if (result["open_time"] != null) {//定时开放
					errorData["open_time"] = result["open_time"];
					
				}else {//其他异常
				}
				SDCore.getInstance().debug("Error HTTPToken-JSONDataResult: mc值 " + mCode + " ( " + errorData["errorContent"] + ")");
				//this.failResult(result, errorData["errorContent"]);
				return false;
				
			}else if (rCode == R_CODE_UNKNOW) {
				//this.failResult(result);
				return false;
			}else {
				//this.successResult(result);//正常处理返回值
				return true;
			}
		}
		
	}

}
package 
{
	import assets.mapEditer.Skin;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class Main extends AIRApplication 
	{
		
		public function Main():void 
		{
			super();
		}
		
		override protected function initSOName():void
		{
			this._soName = "isKingMapEditer";
		}
		
		override protected function initSkinClass():void 
		{
			this._skinClass = Skin;
		}
		
		override protected function setLogText():void 
		{
			this._infoText = this.infoText;
		}
		
		override protected function createUI():void 
		{
			super.createUI();
			
			
		}
		
		private function get infoText():TextField {
			return this.getTextField("infoText");
		}
		
	}
	
}
package game.view.battle 
{
	import flash.geom.Point;
	
	import game.action.BattleOptionPannelActoin;
	import game.notice.AddBattleCardToViewNotice;
	import game.utils.BattleOwner;
	import game.utils.BattlePropertyName;
	
	import shipDock.framework.application.SDConfig;
	import shipDock.framework.application.SDCore;
	import shipDock.framework.application.component.SDImage;
	import shipDock.framework.core.notice.InvokeProxyedNotice;
	import shipDock.framework.core.utils.SDMath;
	import shipDock.ui.ProgressClippedBar;
	import shipDock.ui.View;
	
	import starling.animation.IAnimatable;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleOptionPannel extends View 
	{		
		public function BattleOptionPannel() 
		{
			super();
			this._UIConfigName = "battleOptionsPannel";
		}
		
		override protected function createUI():void 
		{
			super.createUI();
			
			this.initClipped("angerValueBar");
			this.initClipped("moraleValueBar");
			this.initClipped("intelligenceValueBar");
			
			this.setBattlePropertyText(BattlePropertyName.ANGER, 0, 0);
			this.setBattlePropertyText(BattlePropertyName.MORALE, 0, 0);
			this.setBattlePropertyText(BattlePropertyName.INTELLIGENCE, 0, 0);
			this.commitStaticTextsChanged();
			
			this.isReloadIntellingenceBar = true;//一定要记得打开情报收集
			
		}
		
		/**
		 * 使用遮罩初始化战场属性槽
		 * 
		 * @param	name
		 */
		private function initClipped(name:String):void {
			var barImage:SDImage = SDCore.getInstance().assetManager.getImage(name);
			var bgImage:SDImage = SDCore.getInstance().assetManager.getImage(name + "Bg");
			var clipped:BattlePropertyBar = new BattlePropertyBar(barImage.width, barImage.height, barImage, 0, 0, null, bgImage);
			clipped.percentValue = 0;
			this.putChildraw(clipped, name + "Clipped");
			this.getEmptySpriteUI(name).addChild(clipped);
		}
		
		/**
		 * 重置情报属性槽
		 * 
		 * @param	isReload
		 */
		private function resetIntellingenceBar(isReload:Boolean = true):void {
			var bar:ProgressClippedBar = this.getBattlePropertyBar("intelligenceValueBar");
			bar.percentValue = 0;
			(isReload) && this.setIntellingenceBar();
		}
		
		/**
		 * 情报槽蓄满后
		 * 
		 */
		private function intellingenceBarComplete():void {
			SDCore.getInstance().juggler.remove(this.intellingenceBarAnimatable);
			this.changeProperty("intellingenceBarAnimatable", null);
			this.battleOptionPannelAction.intelligenceMax(BattleOwner.USER_VALUE);
			this.isReloadIntellingenceBar = false;
		}
		
		/**
		 * 设置情报槽变化值
		 * 
		 */
		private function setIntellingenceBar():void {
			if (this.isReloadIntellingenceBar && !this.intellingenceBarAnimatable) {
				var value:Number = this.getPropertyChanged("intellingenceValue");
				var time:Number = 100 / value * 3;//读条时间=情报值比例*3
				if (time != 0) {
					var bar:ProgressClippedBar = this.getBattlePropertyBar("intelligenceValueBar");
					bar.percentValue = 0;
					var tween:IAnimatable = SDCore.getInstance().juggler.tween(bar, time, { "percentValue":100, "onComplete":this.intellingenceBarComplete } );
					
					this.changeProperty("intellingenceBarTime", time);
					this.changeProperty("intellingenceBarAnimatable", tween);
				}
			}
		}
		
		/**
		 * 开始新一轮情报收集
		 * 
		 * @param	notice
		 */
		public function restartInellingenceBar(notice:InvokeProxyedNotice):void {
			this.isReloadIntellingenceBar = true;
			this.setIntellingenceBar();
		}
		
		/**
		 * 设置战场属性槽的值与文本
		 * 
		 * @param	propertyName
		 * @param	value
		 * @param	max
		 */
		public function setBattlePropertyText(propertyName:String, value:Number, max:Number):void {
			this.setStaticTextValue(propertyName + "Value", "text", String(value));
			var bar:ProgressClippedBar = this.getBattlePropertyBar(propertyName + "ValueBar");
			if (propertyName == BattlePropertyName.INTELLIGENCE) {
				this.changeProperty("intellingenceValue", value);
				this.setIntellingenceBar();
			}else {
				var percent:Number = SDMath.percent(value, max) * 100;
				(bar != null) && (bar.percentValue = percent);
				if (percent == 100) {//情报值蓄满
					var maxMethod:Function = this.battleOptionPannelAction[propertyName + "Max"];
					maxMethod(BattleOwner.USER_VALUE);
				}
			}
			this.commitStaticTexts();
		}
		
		public function commitStaticTexts(notice:InvokeProxyedNotice = null):void {
			this.commitStaticTextsChanged();
		}
		
		public function getBattleCardTargetPos(notice:InvokeProxyedNotice):Point {
			var dataNotice:AddBattleCardToViewNotice = notice.data;
			if (this.parent == null)
				return new Point();
			var x:Number = (this.parent.x + this.getEmptySpriteUI("battleCardContent").x + dataNotice.cardIndex * 110) * SDConfig.globalScale;// + SDConfig.mainOffsetX;
			var y:Number = (this.parent.y + this.getEmptySpriteUI("battleCardContent").y) * SDConfig.globalScale;
			var result:Point = new Point(x, y);
			return result;
		}
		
		public function pauseIntelligenceBar(notice:InvokeProxyedNotice):void {
			this.changeProperty("isIntelligenceBarPause", true);
			SDCore.getInstance().juggler.remove(this.intellingenceBarAnimatable);
		}
		
		public function continueIntelligenceBar(notice:InvokeProxyedNotice):void {
			var flag:Boolean = this.getPropertyChanged("isIntelligenceBarPause");
			if (flag) {
				var bar:BattlePropertyBar = this.getBattlePropertyBar("intelligenceValueBar");
				var percent:Number = bar.percentValue / 100;
				if (percent > 0) {
					var value:Number = this.getPropertyChanged("intellingenceValue");
					var time:Number = 100 / value * 3;
					time -= time * percent;//重新计算填满情报槽的剩余时间
					if (time != 0) {
						var tween:IAnimatable = SDCore.getInstance().juggler.tween(bar, time, { "percentValue":100, "onComplete":this.intellingenceBarComplete } );
						this.changeProperty("intellingenceBarTime", time);
						this.changeProperty("isIntelligenceBarPause", false);
						this.changeProperty("intellingenceBarAnimatable", tween);
					}
				}
			}
		}
		
		private function getBattlePropertyBar(name:String):BattlePropertyBar {
			return this.getChildraw(name + "Clipped") as BattlePropertyBar;
		}
		
		private function get battleOptionPannelAction():BattleOptionPannelActoin {
			return this.action as BattleOptionPannelActoin;
		}
		
		private function get intellingenceBarTime():Number {
			return this.getPropertyChanged("intellingenceBarTime");
		}
		
		private function get intellingenceBarAnimatable():IAnimatable {
			return this.getPropertyChanged("intellingenceBarAnimatable") as IAnimatable;
		}
		
		private function get intellingenceValue():Number {
			return this.getPropertyChanged("intellingenceValue");
		}
		
		/**
		 * 是否重新填充情报槽
		 * 
		 */
		private function get isReloadIntellingenceBar():Boolean {
			return this.getPropertyChanged("isReloadIntellingenceBar");
		}
		
		private function set isReloadIntellingenceBar(value:Boolean):void {
			return this.changeProperty("isReloadIntellingenceBar", value);
		}
	}

}
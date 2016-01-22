package game.ui 
{
	import game.command.BattleAICommand;
	import game.command.BattleViewCommand;
	import game.model.GeneralModel;
	import game.notice.BattleAINotice;
	import game.notice.BattleViewNotice;
	
	import shipDock.framework.application.SDCore;
	import shipDock.framework.application.component.SDComponent;
	import shipDock.framework.application.component.SDQuadText;
	import shipDock.framework.core.action.Action;
	import shipDock.ui.View;
	
	import starling.animation.IAnimatable;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleWords extends View 
	{
		
		private var _generalModel:GeneralModel;
		private var _wordText:String;
		private var _battleViewNotice:BattleViewNotice;
		
		public function BattleWords(word:String, generalModel:GeneralModel) 
		{
			super();
			this._generalModel = generalModel;
			this._UIConfigName = "battleWords";
			this._wordText = word;
		}
		
		override protected function addEvents():void 
		{
			super.addEvents();
			
			this.addEventListener(TouchEvent.TOUCH, this.battleWordsTouch);
		}
		
		override protected function removeEvents():void 
		{
			super.removeEvents();
			
			this.removeEventListener(TouchEvent.TOUCH, this.battleWordsTouch);
		}
		
		override protected function createUI():void 
		{
			super.createUI();
			
			this.setAction(new Action("battleWordsAction"));
			
			this.setStaticTextValue("battleWordsText", "text", this._wordText);
			
			var battleWordsText:SDQuadText = this.getTextUI("battleWordsText");
			this.battleViewNotice.sendSelf(this.action, BattleViewCommand.MERGE_BATTLE_WORD_TEXT_COMMAND, [battleWordsText]);
			
			var addCardEnd:IAnimatable = SDCore.getInstance().juggler.delayCall(this.addBattleCard, 2);
			this.changeProperty("addCardEnd", addCardEnd);
		}
		
		private function battleWordsTouch(event:TouchEvent):void {
			if (SDComponent.touchCheck(event)) {
				this.addBattleCard();
			}
		}
		
		private function addBattleCard():void {
			this.removeEventListener(TouchEvent.TOUCH, this.battleWordsTouch);
			this.action.sendNotice(new BattleAINotice(BattleAICommand.BATTLE_AI_CREATE_BATTLE_CARD_COMMAND, this._generalModel));
			var addCardEnd:IAnimatable = this.getPropertyChanged("addCardEnd");
			SDCore.getInstance().juggler.remove(addCardEnd);
			SDCore.getInstance().juggler.delayCall(this.close, 0.8);
		}
		
		private function get battleViewNotice():BattleViewNotice {
			(this._battleViewNotice == null) && (this._battleViewNotice = new BattleViewNotice(null));
			return this._battleViewNotice;
		}
	}

}
package game.ui 
{
	import game.action.ActionName;
	import game.command.BattleAssetCommand;
	import game.model.GeneralModel;
	import game.notice.NoticeName;
	import game.utils.BattleOwner;
	import shipDock.framework.core.manager.NoticeManager;
	import shipDock.framework.core.notice.Notice;
	
	import shipDock.framework.application.SDCore;
	import shipDock.framework.application.component.SDComponent;
	import shipDock.framework.application.component.SDImage;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleGeneral extends SDComponent 
	{
		
		private var _battleOwner:int;
		
		public function BattleGeneral() 
		{
			super();
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
		override public function redraw():void 
		{
			super.redraw();
		}
		
		public function updateGeneralImage():void {
			if (this.generalModel == null)
				return;
			var scale:Number = 0.5;
			var image:SDImage = SDCore.getInstance().assetManager.getImage(this.generalModel.middelImageID, false, true);
			image.scaleX = scale;
			image.scaleY = scale;
			image.x += image.width / 2 - image.width * (1 - scale);
			image.y += image.height / 2 - image.height * (1 - scale);
			//var cliped:ClippedSprite = new ClippedSprite(image.width, 100);
			//cliped.addChild(image);
			//this.addChild(cliped);
			this.addChild(image);
		}
		
		override public function set data(value:Object):void 
		{
			
			var assetName:String = (value as GeneralModel).assetID;
			var notice:Notice = new Notice(NoticeName.BATTLE_ASSETS, assetName);
			notice.subCommand = BattleAssetCommand.ADD_BATTLE_PRELOAD_ASSET_COMMAND;
			NoticeManager.sendNotice(notice);//组织素材
			
			super.data = value;
		}
		
		public function get generalModel():GeneralModel {
			return this.data as GeneralModel;
		}
		
		public function set battleOwner(value:int):void 
		{
			_battleOwner = value;
		}
		
		public function get battleOwner():int 
		{
			return _battleOwner;
		}
		
		public function get isUserOwner():Boolean {
			return (this._battleOwner == BattleOwner.USER_VALUE);
		}
	}

}
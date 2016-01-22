package game.data 
{
	import game.model.GameProfile;
	import shipDock.data.ProfileProxy;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class ProfileData extends ProfileProxy 
	{
		public function ProfileData() 
		{
			super();
			
		}
		
		override protected function setProfileModel():void 
		{
			this._profileModel = new GameProfile();
		}
		
	}

}
package 
{
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class Main extends Sprite 
	{
		public static const VIEW_UI_TYPE_TEXT:int = 0;
		public static const VIEW_UI_TYPE_IMAGE:int = 1;
		public static const VIEW_UI_TYPE_MOVIE:int = 2;
		public static const VIEW_UI_TYPE_BUTTON:int = 3;
		public static const VIEW_UI_TYPE_QUAD:int = 4;
		public static const VIEW_UI_TYPE_CONTAINER:int = 5;
		public static const VIEW_UI_TYPE_DYNAMIC_TEXT:int = 6;
		
		private var _loader:Loader;
		private var _dataLoader:DataLoader;
		private var _configList:Array;
		private var _currentName:String;
		private var _infoText:TextField;
		private var _pathText:TextField;
		private var _count:int = 0;
		
		private var _button:Sprite;
		
		private var _fileList:FileReferenceList;
		
		private var _dataList:Array = [];
		private var _currentFileRef:FileReference;
		private var _skin:UISkin;
		
		private var _xmlPools:Object = { };
		private var _oneBatchs:Array = [VIEW_UI_TYPE_QUAD, VIEW_UI_TYPE_CONTAINER];//这些需要独立一个层
		
		private var _xmlPath:String;
		
		public function Main():void 
		{
			this.init();
		}
		
		private function addInfo(text:String):void {
			if (this._count > 50) {
				this._count = 0;
				this._infoText.text = "";
			}
			this._count++;
			this._infoText.appendText(text + "\r\n");
			this._infoText.scrollV = this._infoText.bottomScrollV;
		}
		
		private function init():void {
			
			this._skin = new UISkin();
			this._pathText = this._skin.exportText;
			var lastPath:String = SCutils.getShareObject("lastPath");
			this._pathText.text = (lastPath == null) ? "D:/NBAToolExport/NBAUI/" : lastPath;
			this._button = this._skin.browserBtn;
			this._button.addEventListener(MouseEvent.CLICK, this.startBrowser);
			this._skin.loadBtn.addEventListener(MouseEvent.CLICK, this.loadConig);
			this._infoText = this._skin.infoText;
			
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var xml:XML = appXml.elements()[1];
			this.addInfo("NBAUIParser version " + xml);
			
			this._xmlPath = SCutils.getShareObject("xmlPath");
			if (this._xmlPath != null) {
				this._skin.xmlPathText.text = this._xmlPath;
			}else {
				this._skin.xmlPathText.text = "";
			}
			if (this._skin.xmlPathText.text == "") {
				this._xmlPath = "";
				this._skin.xmlPathText.text = "请填写项目里纹理XML的路径";
			}
			
			this.addChild(this._skin);
		}
		
		private function loadConig(event:MouseEvent):void {
			this._dataLoader = new DataLoader("assets/ui_list.json", this.configComplete);
			this._dataLoader.commit();
		}
		
		private function configComplete(result:*):void {
			var data:Array = result as Array;
			var i:int = 0;
			var max:int = data.length;
			
			this.initData();
			while (i < max) {
				this._dataList.push(data[i]["name"]);
				this._configList.push(data[i]["name"]);
				i++;
			}
			this.loadSWF();
			this._dataLoader.dispose();
		}
		
		private function startBrowser(event:MouseEvent):void {
			this._fileList = new FileReferenceList();
			this._fileList.browse([new FileFilter("swfs", "*.swf")]);
			this._fileList.addEventListener(Event.SELECT, this.browserComplete);
		}
		
		private function initData():void {
			this._dataList = [];
			this._configList = [];
			this._xmlPools = { };
		}
		
		private function browserComplete(event:Event):void {
			this._infoText.text = "";
			this.initData();
			var i:int = 0;
			while (i < this._fileList.fileList.length) {
				var fileRef:FileReference = this._fileList.fileList[i];
				fileRef.addEventListener(Event.COMPLETE, fileLoaded);
				fileRef.load();
				i++;
			}
		}
		
		private function fileLoaded(e:Event):void {
			this._currentFileRef = e.currentTarget as FileReference;
			this._currentFileRef.removeEventListener(Event.COMPLETE, fileLoaded);
			this._dataList.push(this._currentFileRef.data);
			this._configList.push(this._currentFileRef.name);
			
			if (this._dataList.length == this._fileList.fileList.length) {
				this.addInfo("需要解析的配置名列表为：\r");
				var list:Array = [];
				var i:int = 0;
				var max:int = this._configList.length;
				var text:String = "";
				while (i < max) {
					this.addInfo(this._configList[i] + "\r\n");
					i++;
				}
				this.addInfo("开始生成配置\r");
				//this.loadSWF();
				this.loadXML();
			}
			SCutils.addShareObject("lastPath", this._pathText.text);
		}
		
		private function loadXML():void {
			this._skin.xmlPathText.text = this._skin.xmlPathText.text.replace(new RegExp("\\\\", '*g'), "/");
			this._xmlPath = this._skin.xmlPathText.text;
			SCutils.addShareObject("xmlPath", this._xmlPath);
			var file:File = new File("file:///" + this._xmlPath);
			if (!file.exists) {
				this.addInfo("纹理XML路径不正确，请重新填写。");
				return;
			}
			//var file:File = File.applicationDirectory.resolvePath();//"assets/xml/"
			var list:Array = file.getDirectoryListing();
			for each(var f:File in list) {
				if (f.url.indexOf("svn") != -1) {
					continue;
				}
				var fs:FileStream = new FileStream();
				fs.open(f, FileMode.READ);
				var xml:XML = XML(fs.readUTFBytes(fs.bytesAvailable));
				var key:String = xml.@imagePath;
				for each(var k:* in xml.children()) {
					var kk:String = k.@name;
					if(!this._xmlPools.hasOwnProperty(kk)) {
						this._xmlPools[kk] = key;
					}else {
						//纹理里有重名！
					}
				}
				fs.close();
			}
			this.loadSWF();
		}
		
		private function loadSWF():void {
			if (_loader != null) {
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadSWFComplete);
			}
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadSWFComplete);
			
			var data:* = this._dataList.shift();
			this._currentName = this._configList.shift();// ["name"];
			
			if (data != null) {
				if(data is ByteArray) {
					var lc:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
					lc.allowCodeImport = true;
					_loader.loadBytes(data, lc);
					
				}else if (data is String) {
					_loader.load(new URLRequest("assets/" + this._currentName + ".swf"));
				}
			}else {
				this.addInfo("恭喜主人！所有的界面配置生成完毕!");
			}
		}
		
		private function loadSWFComplete(event:Event):void {
			var content:DisplayObjectContainer = (event.currentTarget as LoaderInfo).content as DisplayObjectContainer;
			var i:int = 0;
			var max:int = content.numChildren;
			var result:Object = {"view":[]};
			var viewData:Array = result["view"];
			var isError:Boolean;
			var layerName:String;
			var layerNames:Object = { };
			var layers:Array = [];
			var textLayer:Array = [];
			var dTextLayer:Array = [];
			var btnLayer:Array = [];
			while (i < max) {
				var child:* = content.getChildAt(i);
				if (child is DisplayObject) {
					var name:String = child.name;
					var nameInfo:Array = name.split("_");
					var texture:String = nameInfo[1];
					var childName:String = ((nameInfo[2] != null) && (nameInfo[2] != "img")) ? nameInfo[2] : nameInfo[1];
					
					var item:Object = {
						"name":childName,//名字，没有值时与纹理名相同
						"texture":texture,//纹理
						"x":child.x,//坐标
						"y":child.y//坐标
					};
					if (texture == null) {
						this.addInfo(nameInfo + "'s texture is null");
					}
					switch(nameInfo[0]) {
						case "stxt"://静态文本
							this.addTextItem(item, child);
							break;
						case "img"://图片
							item["type"] = VIEW_UI_TYPE_IMAGE;
							break;
						case "ani"://动画
							item["type"] = VIEW_UI_TYPE_MOVIE;
							break;
						case "btn"://按钮
							item["type"] = VIEW_UI_TYPE_BUTTON;
							if (nameInfo[3] != null) {
								item["labelTexture"] = nameInfo[3];
							}
							break;
						case "quad"://四边形区域
							item["type"] = VIEW_UI_TYPE_QUAD;
							break;
						case "null"://空容器
							item["type"] = VIEW_UI_TYPE_CONTAINER;
							delete item["texture"];//容器不需要纹理
							break;
						case "txt"://动态文本
							this.addTextItem(item, child, true);
							break;
						default:
							isError = true;
							this.addInfo("在界面 " + this._currentName + " 的 " + child.name + " 上遇到未知的UI类型，请确保工具是最新版本");
							break;
					}
					var tn:String = item["texture"];
					if (item["type"] == VIEW_UI_TYPE_BUTTON) {
						tn = "btn0_" + tn;
					}
					if (tn == "matchResultTitle" || tn == "matchResultWord") {
						tn;
					}
					var isSameLayer:Boolean = (tn != null) ? (layerName == this._xmlPools[tn]) : true;
					layerName = (isSameLayer) ? layerName : this._xmlPools[tn];
					if (item["type"] == VIEW_UI_TYPE_TEXT) {
						textLayer.push(item);
						i++;
						continue;
					}else if (item["type"] == VIEW_UI_TYPE_BUTTON) {
						btnLayer.push(item);
						i++;
						continue;
					}else if (item["type"] == VIEW_UI_TYPE_DYNAMIC_TEXT) {
						dTextLayer.push(item);
						i++;
						continue;
					}else {
						if (!isSameLayer || _oneBatchs.indexOf(item["type"]) != -1) {//不同纹理或需要独立放一层的情况
							layers.push([]);
						}
					}
					var ii:int = (layers.length > 0) ? (layers.length - 1) : 0;
					if (layers[ii] == null) {
						layers[ii] = [];//补充初始化
					}
					(layers[ii] as Array).push(item);
				}
				i++;
			}
			if (btnLayer.length > 0) {//按钮层
				layers.push(btnLayer);
			}
			if (textLayer.length > 0) {//文本层
				layers.push(textLayer);
			}
			if (dTextLayer.length > 0) {
				var di:int = 0;
				var dm:int = dTextLayer.length;
				while (di < dm) {
					layers.push([dTextLayer[di]]);
					di++;
				}
			}
			result["view"] = layers;
			if (isError) {
				return;
			}
			var fileContent:String = JSON.stringify(result);
			
			this._currentName = this._currentName.replace(".swf", "");
			this._pathText.text = this._pathText.text.replace(new RegExp("\\\\", '*g'), "/");
			var file:File = new File("file:///" + this._pathText.text + "/" + this._currentName + ".json");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(fileContent);
			fileStream.close();
			
			this.addInfo(this._currentName + "配置生成成功！\r\n");
			
			this.loadSWF();
		}
		
		private function addTextItem(item:Object, child:*, isDynamic:Boolean = false):void {
			item["type"] = (isDynamic) ? VIEW_UI_TYPE_DYNAMIC_TEXT : VIEW_UI_TYPE_TEXT;
			item["textWidth"] = child.width;
			item["textHeight"] = child.height;
			var textField:TextField;
			if (child is TextField) {
				textField = child as TextField;
			}else if(child is MovieClip) {
				textField = (child as MovieClip).getChildAt(0) as TextField;
			}
			if (textField != null) {
				if (textField.text == "") {
					textField.text = " ";
				}
				item["text"] = textField.text;
				item["color"] = textField.textColor;
				item["fontSize"] = textField.getTextFormat().size;
			}
			delete item["texture"];//位图文本不需要纹理
		}
		
	}
	
}
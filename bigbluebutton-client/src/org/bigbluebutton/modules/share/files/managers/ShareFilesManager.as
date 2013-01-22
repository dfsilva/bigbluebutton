package org.bigbluebutton.modules.share.files.managers
{
	import com.asfusion.mate.events.Dispatcher;
	
	import mx.collections.ArrayCollection;
	
	import org.bigbluebutton.common.IBbbModuleWindow;
	import org.bigbluebutton.common.LogUtil;
	import org.bigbluebutton.common.Role;
	import org.bigbluebutton.common.events.CloseWindowEvent;
	import org.bigbluebutton.common.events.OpenWindowEvent;
	import org.bigbluebutton.core.managers.UserManager;
	import org.bigbluebutton.main.events.MadePresenterEvent;
	import org.bigbluebutton.main.model.users.BBBUser;
	import org.bigbluebutton.main.model.users.Conference;
	import org.bigbluebutton.modules.polling.views.PollingInstructionsWindow;
	import org.bigbluebutton.modules.share.files.events.ShareFilesModuleStartedEvent;
	import org.bigbluebutton.modules.share.files.views.ShareFilesWindow;

			
	public class ShareFilesManager{	
		
		public static const LOGNAME:String = "[ShareFilesManager] ";	
		
		public var toolbarButtonManager:ToolbarButtonManager;
		private var module:PollingModule;
		private var dispatcher:Dispatcher;
		private var isPolling:Boolean = false;
		public var participants:int;
		private var conference:Conference;
		private var _module:ShareFilesModule;
		private var filesWindow:ShareFilesWindow;

		public function ShareFilesManager(){
				LogUtil.debug(LOGNAME +" Construindo ShareFilesManager");
				dispatcher = new Dispatcher();
				toolbarButtonManager = new ToolbarButtonManager();
		}
		
		public function handleMadePresenterEvent(e:MadePresenterEvent):void{
			LogUtil.debug(LOGNAME +" Adicionando o botao de compartilhar arquivos a toolbar");
			toolbarButtonManager.addToolbarButton();
		}
		
		public function handleMadeViewerEvent(e:MadePresenterEvent):void{
			LogUtil.debug(LOGNAME +" Removendo o botao de compartilhar arquivos a toolbar");
			toolbarButtonManager.removeToolbarButton();
		}
		
		public function moduleStarted(e:ShareFilesModuleStartedEvent):void{
			_module = e.module;
			
			if (filesWindow == null){
				filesWindow = new ShareFilesWindow();
				var windowEvent:OpenWindowEvent = new OpenWindowEvent(OpenWindowEvent.OPEN_WINDOW_EVENT);
				windowEvent.window = filesWindow;
				dispatcher.dispatchEvent(windowEvent);
			}
		}
	
   }
}

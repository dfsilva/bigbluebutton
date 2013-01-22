package org.bigbluebutton.modules.share.files.manager
{
	import com.asfusion.mate.events.Dispatcher;
	import mx.collections.ArrayCollection;
	
	import org.bigbluebutton.modules.polling.views.PollingInstructionsWindow;
	
	import org.bigbluebutton.common.LogUtil;
	import org.bigbluebutton.main.events.MadePresenterEvent;
	import org.bigbluebutton.common.events.OpenWindowEvent;
	import org.bigbluebutton.common.events.CloseWindowEvent;

	import org.bigbluebutton.common.IBbbModuleWindow;

	import org.bigbluebutton.core.managers.UserManager;
	import org.bigbluebutton.main.model.users.Conference 
	import org.bigbluebutton.main.model.users.BBBUser;
	import org.bigbluebutton.common.Role;

			
	public class Manager{	
		
		public static const LOGNAME:String = "[ShareFilesManager] ";	
		
		public var toolbarButtonManager:ToolbarButtonManager;
		private var module:PollingModule;
		private var globalDispatcher:Dispatcher;
		private var isPolling:Boolean = false;
		public var participants:int;
		private var conference:Conference;

		public function Manager(){
				LogUtil.debug(LOGNAME +" Construindo ShareFilesManager");
			    globalDispatcher = new Dispatcher();
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
	
   }
}

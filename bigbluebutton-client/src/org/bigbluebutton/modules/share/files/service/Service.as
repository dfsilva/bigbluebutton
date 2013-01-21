/**
* BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
*
* Copyright (c) 2010 BigBlueButton Inc. and by respective authors (see below).
*
* This program is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free Software
* Foundation; either version 2.1 of the License, or (at your option) any later
* version.
*
* BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
* WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
* PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License along
* with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.
* 
*/
package org.bigbluebutton.modules.share.files.service
{
	import com.asfusion.mate.events.Dispatcher;  
	import flash.events.AsyncErrorEvent;
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;

	import flash.net.NetConnection;
	import flash.net.SharedObject;
	import flash.net.Responder;
	import mx.collections.ArrayCollection;
    
	import mx.controls.Alert;
	import org.bigbluebutton.core.managers.UserManager;
	
	import org.bigbluebutton.common.LogUtil;
	import org.bigbluebutton.common.events.OpenWindowEvent;
	import org.bigbluebutton.common.IBbbModuleWindow;
	
	public class Service{	
		public static const LOGNAME:String = "[ShareFilesService] ";

		private var pollingSO:SharedObject;
		private var nc:NetConnection;
		private var uri:String;
		private var dispatcher:Dispatcher;
		private var attributes:Object;
		
		private static const SHARED_OBJECT:String = "shareFilesSO";
		
		public function Service(){
			LogUtil.debug(LOGNAME + " Construindo ShareFilesService");
		}
	}
}
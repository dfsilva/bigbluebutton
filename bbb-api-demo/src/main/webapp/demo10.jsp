<!--
XX
BigBlueButton - http://www.bigbluebutton.org

Copyright (c) 2008-2009 by respective authors (see below). All rights reserved.

BigBlueButton is free software; you can redistribute it and/or modify it under the 
terms of the GNU Lesser General Public License as published by the Free Software 
Foundation; either version 3 of the License, or (at your option) any later 
version. 

BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY 
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along 
with BigBlueButton; if not, If not, see <http://www.gnu.org/licenses/>.

-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="css/ui.jqgrid.css" />
	<link rel="stylesheet" type="text/css" href="css/redmond/jquery-ui-redmond.css" />
	<script type="text/javascript" src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script src="js/grid.locale-en.js" type="text/javascript"></script>
	<script src="js/jquery.jqGrid.min.js" type="text/javascript"></script>
	<script src="js/jquery.xml2json.js" type="text/javascript"></script>
	<title>Gravar uma Reuniao de Demonstracao</title>
	<style type="text/css">
	 #formcreate{
		margin-bottom:30px;
	 }
	 #formcreate label.labform{
	 	display:block;
	 	float:left;
	 	width:100px;
	 	text-align:right;
		margin-right:5px;
	 }
	 #formcreate div{
		margin-bottom:5px;
		clear:both;
	 }
	 #formcreate .submit{
		margin-left:100px;
		margin-top:15px;
	 }
	 #descript{
	 	vertical-align:top;
	 }
	 #meta_description , #username1{
		float:left;
	 }
	 .ui-jqgrid{
		font-size:0.7em
	}
	label.error{
		float: none; 
		color: red; 
		padding-left: .5em; 
		vertical-align: top;
		width:200px;
		text-align:left;
	}
	</style>
</head>
<body>

<%@ include file="bbb_api.jsp"%>
<%@ page import="java.util.regex.*"%>

<%@ include file="demo_header.jsp"%>

<%
	if (request.getParameterMap().isEmpty()) {
		//
		// Assume we want to create a meeting
		//
%>
	<h2>Entrar no curso (Gravado)</h2>

	<form id="formcreate" name="formcreate" method="get" action=""> 		
		<div>
			<label class="labform" for="meetingID">Curso:</label>
			<select name="meetingID" onchange="onChangeMeeting(this.value);">
				<option value="Ingles 101">Ingles 101</option>
				<option value="Ingles 102">Ingles 102</option>
				<option value="Ingles 103">Ingles 103</option>
				<option value="Ingles 104">Ingles 104</option>
				<option value="Ingles 105">Ingles 105</option>
				<option value="Ingles 106">Ingles 106</option>
				<option value="Ingles 107">Ingles 107</option>
				<option value="Ingles 108">Ingles 108</option>
				<option value="Ingles 109">Ingles 109</option>
				<option value="Ingles 110">Ingles 110</option>
			</select>
		</div>
		<div>
			<label class="labform" id="descript" for="meta_description">Descricao:</label>
			<textarea id="meta_description" name="meta_description" cols="50" rows="6" autofocus required></textarea>
		</div>
		<div>
			<label class="labform" for="meta_email">Seu nome:</label>
			<input id="meta_email" name="meta_email" type="text" required size="30" />
		</div>	
		<div style="clear:both"></div>
		<input class="submit" type="submit" value="Entrar" >
		<input type="hidden" name="action" value="create" />
	</form>

	<h3>Sessoes Gravadas</h3>
	<select id="actionscmb" name="actions" onchange="recordedAction(this.value);">
		<option value="novalue" selected>Acoes...</option>
		<option value="publish">Publicar</option>
		<option value="unpublish">Despublicar</option>
		<option value="delete">Apagar</option>
	</select>
	<table id="recordgrid"></table>
	<div id="pager"></div> 
	<p>Nota: Novas gravacoes podem aparecer na lista apos o processamento.  Atualize o browser para refletir.</p>
	<script>
	function onChangeMeeting(meetingID){
		isRunningMeeting(meetingID);
	}
	function recordedAction(action){
		if(action=="novalue"){
			return;
		}
		
		var s = jQuery("#recordgrid").jqGrid('getGridParam','selarrrow');
		if(s.length==0){
			alert("Selecione pelo menos uma linha");
			$("#actionscmb").val("novalue");
			return;
		}
		var recordid="";
		for(var i=0;i<s.length;i++){
			var d = jQuery("#recordgrid").jqGrid('getRowData',s[i]);
			recordid+=d.id;
			if(i!=s.length-1)
				recordid+=",";
		}
		if(action=="delete"){
			var answer = confirm ("Tem certeza que deseja apagar estas gravacoes?");
			if (answer)
				sendRecordingAction(recordid,action);
			else{
				$("#actionscmb").val("novalue");
				return;
			}
		}else{
			sendRecordingAction(recordid,action);
		}
		$("#actionscmb").val("novalue");
	}
	
	function sendRecordingAction(recordID,action){
		$.ajax({
			type: "GET",
			url: 'demo10_helper.jsp',
			data: "command="+action+"&recordID="+recordID,
			dataType: "xml",
			cache: false,
			success: function(xml) {
				window.location.reload(true);
				$("#recordgrid").trigger("reloadGrid");
			},
			error: function() {
				alert("Falha ao conectar-se na api.");
			}
		});
	}
	
	function isRunningMeeting(meetingID) {
		$.ajax({
			type: "GET",
			url: 'demo10_helper.jsp',
			data: "command=isRunning&meetingID="+meetingID,
			dataType: "xml",
			cache: false,
			success: function(xml) {
				response = $.xml2json(xml);
				if(response.running=="true"){
					$("#meta_description").val("Existe uma sessao ativa para "+meetingID+". Esta sessao esta sendo gravada.");
					$("#meta_description").attr("readonly","readonly");
					$("#meta_description").attr("disabled","disabled");
				}else{
					$("#meta_description").val("");
					$("#meta_description").removeAttr("readonly");
					$("#meta_description").removeAttr("disabled");
				}
				
			},
			error: function() {
				alert("Falha ao conectar na api.");
			}
		});
	}
	var meetingID="Ingles 101,Ingles 102,Ingles 103,Ingles 104,Ingles 105,Ingles 106,Ingles 107,Ingles 108,Ingles 109,Ingles 110";
	$(document).ready(function(){
		isRunningMeeting("Ingles 232");
		$("#formcreate").validate();
		$("#meetingID option[value='Ingles 101']").attr("selected","selected");
		jQuery("#recordgrid").jqGrid({
			url: "demo10_helper.jsp?command=getRecords&meetingID="+meetingID,
			datatype: "xml",
			height: 150,
			loadonce: true,
			sortable: true,
			colNames:['Codigo','Curso','Descricao', 'Data da Gravacao', 'Publicado', 'Gravado', 'Tamanho'],
			colModel:[
				{name:'id',index:'id', width:50, hidden:true, xmlmap: "recordID"},
				{name:'course',index:'course', width:150, xmlmap: "name", sortable:true},
				{name:'description',index:'description', width:300, xmlmap: "description",sortable: true},
				{name:'daterecorded',index:'daterecorded', width:200, xmlmap: "startTime", sortable: true, sorttype: "datetime", datefmt: "d-m-y h:i:s"},
				{name:'published',index:'published', width:80, xmlmap: "published", sortable:true },
				{name:'playback',index:'playback', width:150, xmlmap:"playback", sortable:false},
				{name:'length',index:'length', width:80, xmlmap:"length", sortable:true}
			],
			xmlReader: {
				root : "recordings",
				row: "recording",
				repeatitems:false,
				id: "recordID"
			},
			pager : '#pager',
			emptyrecords: "Nada para mostrar",
			multiselect: true,
			caption: "Sessoes gravadas",
			loadComplete: function(){
				$("#recordgrid").trigger("reloadGrid");
			}
		});
	});
	</script>
<%
	} else if (request.getParameter("action").equals("create")) {
		
		String meetingID = request.getParameter("meetingID");
		String username = request.getParameter("meta_email");
		
		//metadata
		Map<String,String> metadata=new HashMap<String,String>();
		
		metadata.put("description", request.getParameter("meta_description"));
		metadata.put("email", request.getParameter("meta_email"));
		// Use the meetingID (e.g English 101) as the title as slides playback
		// uses the title to display the link.
		metadata.put("title", request.getParameter("meetingID"));

		//
		// This is the URL for to join the meeting as moderator
		//
		String welcomeMsg = "Seja bem vindo a %%CONFNAME%%!";
		String joinURL = getJoinURL(username, meetingID, "true", welcomeMsg, metadata, null);
		if (joinURL.startsWith("http://")) {
%>
<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>
<%
		}else{
%>
Erro: getJoinURL() falhou
<p /><%=joinURL%> <%
		}
	}
%> 
</body>
</html>

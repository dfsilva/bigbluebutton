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
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title>Criar sua própria reunião</title>

	<script type="text/javascript"
		src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/heartbeat.js"></script>
</head>
<body>


<%@ include file="bbb_api.jsp"%>
<%@ page import="java.util.regex.*"%>

<br>

<%
	if (request.getParameterMap().isEmpty()) {
		//
		// Assume we want to create a meeting
		//
%>
<%@ include file="demo_header.jsp"%>
<h2>Criar sua própria reunião</h2>

<p />
<FORM NAME="form1" METHOD="GET">

<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	border=3>
	<tbody>
		<tr>
			<td width="50%">Criar sua própria reunião.
			<p />
			</td>
			<td width="50%">Passo 1. Entre com seu Nome: <input type="text" autofocus required
				name="username1" /> <br />
			<INPUT TYPE=hidden NAME=action VALUE="create"> <br />
			<input id="submit-button" type="submit" value="Criar reunião" /></td>
		</tr>
	</tbody>
</table>

</FORM>

<script>
//
// We could have asked the user for both their name and a meeting title, but we'll just use their name to create a title
// We'll use JQuery to dynamically update the button
//
$(document).ready(function(){
    $("input[name='username1']").keyup(function() {
        if ($("input[name='username1']").val() == "") {
        	$("#submit-button").attr('value',"Create meeting" );
        } else {
       $("#submit-button").attr('value',"Criar reunião" +$("input[name='username1']").val());
        }
    });
});
</script>

<%
	} else if (request.getParameter("action").equals("create")) {
		//
		// User has requested to create a meeting
		//

		String username = request.getParameter("username1");
		String meetingID = "Reunião "+username;

		//
		// This is the URL for to join the meeting as moderator
		//
		String joinURL = getJoinURL(username, meetingID, "false", "<br>Bem vindo a conferencia %%CONFNAME%%.<br>", null, null);

		String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
		String inviteURL = url + "create.jsp?action=invite&meetingID=" + URLEncoder.encode(meetingID, "UTF-8");
%>

<hr />
<h2>Reunião criada</h2>
<hr />


<table width="800" cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	border=3>
	<tbody>
		<tr>
			<td width="50%">
			<center><strong> Reuniao <%=username%>'s </strong> foi criada.</center>
			</td>

			<td width="50%">
			<p>&nbsp;</p>

			Passo 2. Envie a outros usuarios usando o <a href="<%=inviteURL%>">link</a> (abaixo):
			<form name="form2" method="POST">
				<textarea cols="62" rows="5" name="myname" style="overflow: hidden">
					<%=inviteURL%>
				</textarea>
			</form>
			<p>&nbsp;
			<p />Passo 3. Click no link a seguir para iniciar a reunião:
			<p>&nbsp;</p>
			<center><a href="<%=joinURL%>">Iniciar Reunião</a></center>
			<p>&nbsp;</p>

			</td>
		</tr>
	</tbody>
</table>

<%
	} else if (request.getParameter("action").equals("enter")) {
		//
		// The user is now attempting to joing the meeting
		//
		String meetingID = request.getParameter("meetingID");
		String username = request.getParameter("username");

		String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
		String enterURL = url + "create.jsp?action=join&username="
			+ URLEncoder.encode(username, "UTF-8") + "&meetingID="
			+ URLEncoder.encode(meetingID, "UTF-8");

		if (isMeetingRunning(meetingID).equals("true")) {
			//
			// The meeting has started -- bring the user into the meeting.
			//
%>
<script type="text/javascript">
	window.location = "<%=enterURL%>";
</script>
<%
	} else {
			//
			// The meeting has not yet started, so check until we get back the status that the meeting is running
			//
			String checkMeetingStatus = getURLisMeetingRunning(meetingID);
%>

<script type="text/javascript">
$(document).ready(function(){
		$.jheartbeat.set({
		   url: "<%=checkMeetingStatus%>",
		   delay: 5000
		}, function () {
			mycallback();
		});
	});


function mycallback() {
	// Not elegant, but works around a bug in IE8 
	var isMeetingRunning = ($("#HeartBeatDIV").text().search("true") > 0 );

	if (isMeetingRunning) {
		window.location = "<%=enterURL%>"; 
	}
}
</script>

<hr />
<h2><strong><%=meetingID%></strong> has not yet started.</h2>
<hr />


<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	border=3>
	<tbody>
		<tr>
			<td width="50%">

			<p>Ola <%=username%>,</p>
			<p>Aguardando moderador para iniciar a reunião <strong><%=meetingID%></strong>.</p>
			<br />
			<p>(Seu browser será automaticamente recarregado quando for iniciado)</p>
			</td>
			<td width="50%"><img src="polling.gif"></img></td>
		</tr>
	</tbody>
</table>


<%
}
	} else if (request.getParameter("action").equals("invite")) {
		//
		// We have an invite to an active meeting.  Ask the person for their name 
		// so they can join.
		//
		String meetingID = request.getParameter("meetingID");
%>

<hr />
<h2>Convidar</h2>
<hr />

<FORM NAME="form3" METHOD="GET">

<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	border=3>
	<tbody>
		<tr>
			<td width="50%">

			<p />Você foi convidado para se juntar<br />
			<strong><%=meetingID%></strong>.
			</td>

			<td width="50%">Entre com seu nome: <input type="text"
				name="username" /> <br />
			<INPUT TYPE=hidden NAME=meetingID VALUE="<%=meetingID%>"> <INPUT
				TYPE=hidden NAME=action VALUE="enter"> <br />
			<input type="submit" value="Join" /></td>
		</tr>
	</tbody>
</table>

</FORM>

<%
	} else if (request.getParameter("action").equals("join")) {
		//
		// We have an invite request to join an existing meeting and the meeting is running
		//
		// We don't need to pass a meeting descritpion as it's already been set by the first time 
		// the meeting was created.
		String joinURL = getJoinURLViewer(request.getParameter("username"), request.getParameter("meetingID"));
			
		if (joinURL.startsWith("http://")) {
%>

<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>

<%
	} else { 
%>

Erro: getJoinURL() falhou
<p /><%=joinURL%> 

<%
 	}
 }
 %> 

</body>
</html>

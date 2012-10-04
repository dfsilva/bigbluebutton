<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Entrar com senha</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap.css" rel="stylesheet">
    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assets/css/docs.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
  </head>
<body>

<%@ include file="bbb_api.jsp"%>

<% 

//
// We're going to define some sample courses (meetings) below.  This API exampe shows how you can create a login page for a course. 
// The password below are not available to users as they are compiled on the server.
//

HashMap<String, HashMap> allMeetings = new HashMap<String, HashMap>();
HashMap<String, String> meeting;

// String welcome = "<br>Welcome to %%CONFNAME%%!<br><br>For help see our <a href=\"event:http://www.bigbluebutton.org/content/videos\"><u>tutorial videos</u></a>.<br><br>To join the voice bridge for this meeting:<br>  (1) click the headset icon in the upper-left, or<br>  (2) dial xxx-xxx-xxxx (toll free:1-xxx-xxx-xxxx) and enter conference ID: %%CONFNUM%%.<br><br>";

String welcome = "<br>Bem vindo a conferencia <b>%%CONFNAME%%</b>!";

//
// English courses
//

meeting = new HashMap<String, String>();
allMeetings.put("Aula de ingles 1", meeting );	// The title that will appear in the drop-down menu
	meeting.put("welcomeMsg", 	welcome);			// The welcome mesage
	meeting.put("moderatorPW", 	"prof123");			// The password for moderator
	meeting.put("viewerPW", 	"student123");			// The password for viewer
	meeting.put("voiceBridge", 	"72013");			// The extension number for the voice bridge (use if connected to phone system)
	meeting.put("logoutURL", 	"/demo/demo3.jsp");  // The logout URL (use if you want to return to your pages)

meeting = new HashMap<String, String>();
allMeetings.put("Aula de ingles 2", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"72213");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

meeting = new HashMap<String, String>();
allMeetings.put("Aula de ingles 3", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"72023");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

//
// Law Courses
//

meeting = new HashMap<String, String>();
allMeetings.put("Aula de ingles 4", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"71232");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

	
meeting = new HashMap<String, String>();
allMeetings.put("Aula de ingles 5", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"72273");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

meeting = new HashMap<String, String>();
allMeetings.put("Aula de ingles 6", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"theprof");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"71642");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

//
// Professor's Virtaul Office Hours
//

meeting = new HashMap<String, String>();
allMeetings.put("Reuniao de escritorio 1", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"70001");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

	
meeting = new HashMap<String, String>();
allMeetings.put("Reuniao de escritorio 2", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"70002");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

	
meeting = new HashMap<String, String>();
allMeetings.put("Reuniao de escritorio 3", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"70003");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");


meeting = null;

Iterator<String> meetingIterator = new TreeSet<String>(allMeetings.keySet()).iterator();

if (request.getParameterMap().isEmpty()) {
		//
		// Assume we want to join a course
		//
	%> 
<%@ include file="demo_header.jsp"%>

<div class="container-fluid">

<div class="hero-unit">
	<h2>Entrar na sessao (senha requerida)</h2>
</div>

<form name="form1" class="well" method="get">
	<input type=hidden name=action value="create">
	<label>Nome</label>
	<input type="text" autofocus required name="username"/>
	<label>Sessao</label>
	<select name="meetingID">
	<%
		String key;
		while (meetingIterator.hasNext()) {
			key = meetingIterator.next(); 
			out.println("<option value=\"" + key + "\">" + key + "</option>");
		}
	%>
	</select>
	<label>Senha</label>
	<input type="password" required name="password" />
    <div class="form-actions">
       	<input type="submit" value="Entrar" class="btn btn-primary"/>
    </div>
</form>

Senhas:  
<ul>
   <li>prof123 - Entrar como professor (privilegios de moderador)</li>
   <li>student123 - Entrar com estudante (privilegios de visualizador)</li>
</ul>

<%
	} else if (request.getParameter("action").equals("create")) {
		//
		// Got an action=create
		//

		String username = request.getParameter("username");
		String meetingID = request.getParameter("meetingID");
		String password = request.getParameter("password");
		
		meeting = allMeetings.get( meetingID );
		
		String welcomeMsg = meeting.get( "welcomeMsg" );
		String logoutURL = meeting.get( "logoutURL" );
		Integer voiceBridge = Integer.parseInt( meeting.get( "voiceBridge" ).trim() );

		String viewerPW = meeting.get( "viewerPW" );
		String moderatorPW = meeting.get( "moderatorPW" );
		
		//
		// Check if we have a valid password
		//
		if ( ! password.equals(viewerPW) && ! password.equals(moderatorPW) ) {
%>

Invalid Password, please <a href="javascript:history.go(-1)">Tentar novamente</a>.

<%
			return;
		}
		
		//
		// Looks good, let's create the meeting
		//
		String meeting_ID = createMeeting( meetingID, welcomeMsg, moderatorPW, viewerPW, voiceBridge, logoutURL );
		
		//
		// Check if we have an error.
		//
		if( meeting_ID.startsWith("Error ")) {
%>

Erro: createMeeting() falhou
<p /><%=meeting_ID%> 

<%
			return;
		}
		
		//
		// We've got a valid meeting_ID and passoword -- let's join!
		//
		
		String joinURL = getJoinMeetingURL(username, meeting_ID, password);			
%>

<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>

<%
	} 
%>

</div>

<%@ include file="demo_footer.jsp"%>

    <script src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-transition.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-alert.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-modal.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-dropdown.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-scrollspy.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-tab.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-tooltip.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-popover.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-button.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-collapse.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-carousel.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-typeahead.js"></script>
</body>
</html>


